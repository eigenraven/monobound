/**
 * Bindings to Mono assemblies and images.
 * 
 * License:
 * 
 * Boost Software License - Version 1.0 - August 17th, 2003
 * Permission is hereby granted,free of charge,to any person or organization
 * obtaining a copy of the software and accompanying documentation covered by
 * this license (the "Software") to use,reproduce,display,distribute,
 * execute,and transmit the Software,and to prepare derivative works of the
 * Software,and to permit third-parties to whom the Software is furnished to
 * do so,all subject to the following:
 * 
 * The copyright notices in the Software and this entire statement,including
 * the above license grant,this restriction and the following disclaimer,
 * must be included in all copies of the Software,in whole or in part,and
 * all derivative works of the Software,unless such copies or derivative
 * works are solely in the form of machine-executable object code generated by
 * a source language processor.
 * 
 * THE SOFTWARE IS PROVIDED "AS IS",WITHOUT WARRANTY OF ANY KIND,EXPRESS OR
 * IMPLIED,INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE,TITLE AND NON-INFRINGEMENT. IN NO EVENT
 * SHALL THE COPYRIGHT HOLDERS OR ANYONE DISTRIBUTING THE SOFTWARE BE LIABLE
 * FOR ANY DAMAGES OR OTHER LIABILITY,WHETHER IN CONTRACT,TORT OR OTHERWISE,
 * ARISING FROM,OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
 * DEALINGS IN THE SOFTWARE.
 */
module monod.assembly;

import derelict.mono.mono;
import std.string, std.array, std.algorithm;
import monod.utils;
import monod.runtime;
import std.traits;

/// Exception thrown in case of an error when loading an image or assembly.
class ImageLoadException : Exception
{
	@nogc @safe pure nothrow this(string msg, string file = __FILE__,
			size_t line = __LINE__, Throwable next = null)
	{
		super(msg, file, line, next);
	}

	@nogc @safe pure nothrow this(string msg, Throwable next,
			string file = __FILE__, size_t line = __LINE__)
	{
		super(msg, file, line, next);
	}
}

/// Wrapper for a Mono assembly, container for Images that contain the code.
struct Assembly
{
	private MonoAssembly* mAssembly;
	@disable this();

	/// Closes the assembly, releasing it to the Mono runtime to be deleted when no longer needed.
	void close() nothrow @trusted @nogc
	{
		if (mAssembly !is null)
		{
			mono_assembly_close(mAssembly);
			mAssembly = null;
		}
	}

	/// Constructs an assembly from a C reference.
	static Assembly fromRawObject(MonoAssembly* a) nothrow @nogc
	in
	{
		assert(a !is null);
	}
	body
	{
		Assembly I = void;
		I.mAssembly = a;
		return I;
	}

	/** 
	 * Opens an assembly.
	 * Params:
	 *  filename = A file path or local URL (file://)
	 */
	static Assembly openFile(string filename) @trusted
	{
		Assembly I = void;
		MonoImageOpenStatus ios;
		I.mAssembly = mono_assembly_open(filename.toStringz, &ios);
		final switch (ios)
		{
		case MONO_IMAGE_OK:
			return I;
		case MONO_IMAGE_ERROR_ERRNO:
			throw new ImageLoadException("Error loading Mono assembly (ERRNO)");
		case MONO_IMAGE_MISSING_ASSEMBLYREF:
			throw new ImageLoadException("Error loading Mono asssembly (MISSING_ASSEMBLYREF)");
		case MONO_IMAGE_IMAGE_INVALID:
			throw new ImageLoadException("Error loading Mono asssembly (IMAGE_INVALID)");
		}
	}

	/** 
	 * Opens an assembly located in the GAC or one of additional GACs.
	 * Params:
	 *  assemblyname = The assembly name, it might contain a qualified type name, version, culture and token
	 */
	static Assembly openGAC(string assemblyname) @trusted
	{
		Assembly I = void;
		MonoImageOpenStatus ios;
		I.mAssembly = mono_assembly_load_with_partial_name(assemblyname.toStringz, &ios);
		final switch (ios)
		{
		case MONO_IMAGE_OK:
			return I;
		case MONO_IMAGE_ERROR_ERRNO:
			throw new ImageLoadException("Error loading Mono assembly (ERRNO)");
		case MONO_IMAGE_MISSING_ASSEMBLYREF:
			throw new ImageLoadException("Error loading Mono asssembly (MISSING_ASSEMBLYREF)");
		case MONO_IMAGE_IMAGE_INVALID:
			throw new ImageLoadException("Error loading Mono asssembly (IMAGE_INVALID)");
		}
	}

	/// Iterates over all the assemblies loaded in the Mono runtime.
	static int opApply(Dg = int delegate(Assembly))(scope Dg dg)
			if (is(Dg == delegate) && is(int == ReturnType!Dg))
	{
		int res = 0;
		static struct Udata
		{
			int* resp;
			Dg dg;
		}

		Udata ud = Udata(&res, dg);
		static void mIter(MonoAssembly* a, Udata* d) nothrow
		{
			if (!(*d.resp))
				return;
			try
			{
				Assembly A = Assembly.fromRawObject(a);
				d.dg(A);
			}
			catch (Throwable)
			{
				*d.resp = 0;
				return;
			}
		}

		mono_assembly_foreach(cast(MonoFunc)&mIter, cast(void*)&ud);

		return res;
	}

	/// Collects all the assemblies loaded in the Mono runtime to an array.
	static Assembly[] loadedAssemblies() @trusted nothrow
	{
		Assembly[] list;
		foreach (Assembly a; Assembly)
		{
			list ~= move(a);
		}
		return list;
	}

	/// Returns the name of the assembly.
	string getName() @trusted nothrow
	{
		MonoAssemblyName* n = mono_assembly_get_name(mAssembly);
		return mono_assembly_name_get_name(n).monoOwnedCStrToD();
	}

	static struct Version
	{
		ushort major, minor, build, revision;
	}

	/// Returns the version of the assembly.
	Version getVersion() @trusted nothrow @nogc
	{
		Version v;
		MonoAssemblyName* n = mono_assembly_get_name(mAssembly);
		v.major = mono_assembly_name_get_version(n, &v.minor, &v.build, &v.revision);
		return v;
	}

	/// Returns the culture of the assembly.
	string getCulture() @trusted nothrow
	{
		MonoAssemblyName* n = mono_assembly_get_name(mAssembly);
		return mono_assembly_name_get_culture(n).monoOwnedCStrToD();
	}

	/// Returns: the image associated with the assembly.
	CodeImage getImage() @trusted nothrow @nogc
	{
		MonoImage* img = mono_assembly_get_image(mAssembly);
		return CodeImage.fromRawObject(img);
	}

}

/// Wrapper around MonoImage
struct CodeImage
{
	private MonoImage* mImage;
	@disable this();

	/// Closes the image.
	void close() nothrow @trusted @nogc
	{
		if (mImage !is null)
		{
			mono_image_close(mImage);
			mImage = null;
		}
	}

	/// Construct a CodeImage from a raw Mono C object.
	static CodeImage fromRawObject(MonoImage* i) nothrow @nogc
	in
	{
		assert(i !is null);
	}
	body
	{
		CodeImage I = void;
		I.mImage = i;
		return I;
	}

	/// Returns: the assembly associated with the image.
	Assembly getAssembly() @trusted nothrow @nogc
	{
		MonoAssembly* a = mono_image_get_assembly(mImage);
		return Assembly.fromRawObject(a);
	}

	/// Returns: the metadata token of the entry point associated with this image.
	uint getEntryPointToken() @trusted nothrow @nogc
	{
		return mono_image_get_entry_point(mImage);
	}

	/// Returns: resource in the metadata that starts at a given offset.
	immutable(ubyte)[] getRawResource(uint offset) nothrow @nogc
	{
		uint size;
		auto P = mono_image_get_resource(mImage, offset, &size);
		return (cast(immutable(ubyte)*) P)[0 .. size];
	}

	/// Returns: resource with a given MONO_PE_RESOURCE_ID_, language and name
	MonoPtr!T getResource(T)(uint resourceId, uint languageId, wstring name)
	{
		void* R = mono_image_lookup_resource(mImage, resourceId, languageId, name.toWstringz);
		return MonoPtr!T(cast(T*) R);
	}

}

module app;
import std.stdio;
import std.file : getcwd;
import std.process;
import monobound;
import derelict.mono.mono;
import freefunctions;

version(GenerateBindings)
{
	void main()
	{
		saveModuleToFile!(freefunctions)("bind-d", "bind-cs");
	}
}
else
{
	void main(string[] args)
	{
		stderr.writeln("[D]", "Compiling the C# code...");
		Pid p = spawnProcess(["csc", "/t:library", "/out:samplecs.dll", "bind-cs/MonoBind/freefunctions.cs", "sample.cs"]);
		if(wait(p))
		{
			stderr.writeln("[D]", "Compilation error, quitting");
			return;
		}
		stderr.writeln("[D]", "Initialising the Mono runtime");
		Mono.initialise("SampleApp", args);
		stderr.writeln("[D]", "Binding functions");
		{
			import monobind.freefunctions;
			bindToMono_Freefunctions();
		}
		stderr.writeln("[D]", "Loading the assembly");
		Assembly as = Assembly.openFile("samplecs.dll");
		stderr.writeln("[D]", "Loaded: ", as.getName, " ", as.getVersion);
		CodeImage im = as.getImage();
		MonoClass* cl = mono_class_from_name(im.mImage, "SampleApp".ptr, "SampleApp".ptr);
		if(cl is null)
		{
			stderr.writeln("[D]", "Can't find the SampleApp.SampleApp class.");
			return;
		}
		MonoMethod* m = mono_class_get_method_from_name(cl, "CSTests".ptr, 0);
		if(m is null)
		{
			stderr.writeln("[D]", "Can't find the SampleApp.SampleApp.CSTests() method.");
			return;
		}
		stderr.writeln("[D]", "Invoking SampleApp.SampleApp.CSTests():");
		mono_runtime_invoke(m, null, null, null);
		stderr.writeln("[D]", "Finished invoking SampleApp.SampleApp.CSTests().");
	}
}

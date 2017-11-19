// Automatically generated D->Mono bindings for module freefunctions
using System;
using System.Runtime.CompilerServices;
using System.Runtime.InteropServices;

namespace MonoBind {
	class Freefunctions
	{
		[MethodImplAttribute(MethodImplOptions.InternalCall)]
		private extern static void monobound_D13freefunctions12boundSimple0FZv ();
		public static void boundSimple0 ()
		{
			monobound_D13freefunctions12boundSimple0FZv();
		}
		[MethodImplAttribute(MethodImplOptions.InternalCall)]
		private extern static void monobound_D13freefunctions19renamedboundSimple0FZv ();
		public static void renamedSimple0 ()
		{
			monobound_D13freefunctions19renamedboundSimple0FZv();
		}
		[MethodImplAttribute(MethodImplOptions.InternalCall)]
		private extern static int monobound_D13freefunctions19boundSimpleOverloadFiZi (int a);
		public static int boundSimpleOverload (int a)
		{
			return monobound_D13freefunctions19boundSimpleOverloadFiZi(a);
		}
		[MethodImplAttribute(MethodImplOptions.InternalCall)]
		private extern static float monobound_D13freefunctions19boundSimpleOverloadFfZf (float a);
		public static float boundSimpleOverload (float a)
		{
			return monobound_D13freefunctions19boundSimpleOverloadFfZf(a);
		}
		[MethodImplAttribute(MethodImplOptions.InternalCall)]
		private extern static void monobound_D13freefunctions7myWriteFAyaAyuAywZv (string u8, string u16, string u32);
		public static void myWrite (string u8, string u16, string u32)
		{
			monobound_D13freefunctions7myWriteFAyaAyuAywZv(u8, u16, u32);
		}
	}
}
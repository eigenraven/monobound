/// Automatically generated D->Mono bindings for module freefunctions
module monobind.freefunctions;
import monobound.utils;
import monobound.runtime;
static import freefunctions;

/// Binds freefunctions internal calls to the Mono runtime.
void bindToMono_Freefunctions()
{
	extern(C) void monobound_D13freefunctions12boundSimple0FZv() nothrow
	{try{
			freefunctions.boundSimple0();
		}
		catch(Throwable t)
		{
	}}
	Mono.addInternalCall("MonoBind.Freefunctions::monobound_D13freefunctions12boundSimple0FZv", &monobound_D13freefunctions12boundSimple0FZv);
	extern(C) void monobound_D13freefunctions19renamedboundSimple0FZv() nothrow
	{try{
			freefunctions.renamedboundSimple0();
		}
		catch(Throwable t)
		{
	}}
	Mono.addInternalCall("MonoBind.Freefunctions::monobound_D13freefunctions19renamedboundSimple0FZv", &monobound_D13freefunctions19renamedboundSimple0FZv);
	extern(C) int monobound_D13freefunctions19boundSimpleOverloadFiZi(int a) nothrow
	{try{
			int __monobound_retval = MonoboundTypeInfo!(int, BoundTypeContext.FunctionList).wrapForMono(freefunctions.boundSimpleOverload(a));
			return __monobound_retval;
		}
		catch(Throwable t)
		{
			return int.init;
	}}
	Mono.addInternalCall("MonoBind.Freefunctions::monobound_D13freefunctions19boundSimpleOverloadFiZi", &monobound_D13freefunctions19boundSimpleOverloadFiZi);
	extern(C) float monobound_D13freefunctions19boundSimpleOverloadFfZf(float a) nothrow
	{try{
			float __monobound_retval = MonoboundTypeInfo!(float, BoundTypeContext.FunctionList).wrapForMono(freefunctions.boundSimpleOverload(a));
			return __monobound_retval;
		}
		catch(Throwable t)
		{
			return float.init;
	}}
	Mono.addInternalCall("MonoBind.Freefunctions::monobound_D13freefunctions19boundSimpleOverloadFfZf", &monobound_D13freefunctions19boundSimpleOverloadFfZf);
	extern(C) void monobound_D13freefunctions7myWriteFAyaAyuAywZv(MonoString* u8, MonoString* u16, MonoString* u32) nothrow
	{try{
			MonoboundTypeInfo!(string, BoundTypeContext.FunctionList).beginUse(u8);
			MonoboundTypeInfo!(wstring, BoundTypeContext.FunctionList).beginUse(u16);
			MonoboundTypeInfo!(dstring, BoundTypeContext.FunctionList).beginUse(u32);
			freefunctions.myWrite(MonoboundTypeInfo!(string, BoundTypeContext.FunctionList).unwrapToD(u8), MonoboundTypeInfo!(wstring, BoundTypeContext.FunctionList).unwrapToD(u16), MonoboundTypeInfo!(dstring, BoundTypeContext.FunctionList).unwrapToD(u32));
			MonoboundTypeInfo!(string, BoundTypeContext.FunctionList).endUse(u8);
			MonoboundTypeInfo!(wstring, BoundTypeContext.FunctionList).endUse(u16);
			MonoboundTypeInfo!(dstring, BoundTypeContext.FunctionList).endUse(u32);
		}
		catch(Throwable t)
		{
	}}
	Mono.addInternalCall("MonoBind.Freefunctions::monobound_D13freefunctions7myWriteFAyaAyuAywZv", &monobound_D13freefunctions7myWriteFAyaAyuAywZv);

}
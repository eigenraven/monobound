/// Automatically generated D->Mono bindings for module freefunctions
module monobind.Freefunctions;
import monobound.utils;
import monobound.runtime;
static import freefunctions;

/// Binds freefunctions internal calls to the Mono runtime.
void bindToMono_Freefunctions(Mono* monoInstance)
{
	extern(C) void monobound_D13freefunctions12boundSimple0FZv() nothrow
	{try{
			freefunctions.boundSimple0();
		}
		catch(Throwable t)
		{
	}}
	monoInstance.addInternalCall("monobound_D13freefunctions12boundSimple0FZv", &monobound_D13freefunctions12boundSimple0FZv);
	extern(C) void monobound_D13freefunctions19renamedboundSimple0FZv() nothrow
	{try{
			freefunctions.renamedboundSimple0();
		}
		catch(Throwable t)
		{
	}}
	monoInstance.addInternalCall("monobound_D13freefunctions19renamedboundSimple0FZv", &monobound_D13freefunctions19renamedboundSimple0FZv);
	extern(C) int monobound_D13freefunctions19boundSimpleOverloadFiZi(int a) nothrow
	{try{
			int __monobound_retval = MonoboundTypeInfo!(int, BoundTypeContext.FunctionList).wrapForMono(freefunctions.boundSimpleOverload(a));
			return __monobound_retval;
		}
		catch(Throwable t)
		{
			return int.init;
	}}
	monoInstance.addInternalCall("monobound_D13freefunctions19boundSimpleOverloadFiZi", &monobound_D13freefunctions19boundSimpleOverloadFiZi);
	extern(C) float monobound_D13freefunctions19boundSimpleOverloadFfZf(float a) nothrow
	{try{
			float __monobound_retval = MonoboundTypeInfo!(float, BoundTypeContext.FunctionList).wrapForMono(freefunctions.boundSimpleOverload(a));
			return __monobound_retval;
		}
		catch(Throwable t)
		{
			return float.init;
	}}
	monoInstance.addInternalCall("monobound_D13freefunctions19boundSimpleOverloadFfZf", &monobound_D13freefunctions19boundSimpleOverloadFfZf);

}
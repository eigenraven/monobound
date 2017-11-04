module app;
import std.stdio;
import std.file : getcwd;
import monobound;
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
	void main()
	{
		
	}
}

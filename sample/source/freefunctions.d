
module freefunctions;

import monobound;
import std.stdio;

@MonoBind
void boundSimple0()
{
    stderr.writeln("[D]", __FUNCTION__ ~ " called from the D side.");
}

@MonoBind("renamedSimple0")
void renamedboundSimple0()
{
    stderr.writeln("[D]", __FUNCTION__ ~ " called from the D side.");
}

@MonoBind
int boundSimpleOverload(int a)
{
    stderr.writeln("[D]", __FUNCTION__ ~ " called from the D side.");
    return a-5;
}

@MonoBind
float boundSimpleOverload(float a)
{
    stderr.writeln("[D]", __FUNCTION__ ~ " called from the D side.");
    return a*3.1415f;
}

@MonoBind
void myWrite(string u8, wstring u16, dstring u32)
{
    stderr.writeln("[D]", __FUNCTION__ ~ " called from the D side.");
    stderr.writeln("[D]", u8);
    stderr.writeln("[D]", u16);
    stderr.writeln("[D]", u32);
}

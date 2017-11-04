
module freefunctions;

import monobound;

@MonoBind
void boundSimple0()
{
}

@MonoBind("renamedSimple0")
void renamedboundSimple0()
{
}

@MonoBind
int boundSimpleOverload(int a)
{
    return -a;
}

@MonoBind
float boundSimpleOverload(float a)
{
    return -a;
}

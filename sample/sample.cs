using System;
using System.IO;
using MonoBind;

namespace SampleApp
{
    class SampleApp
    {
        public static void CSTests()
        {
            new SampleApp().RunCSTests();
        }

        private void RunCSTests()
        {
            Console.WriteLine("[C#] Starting C#->D tests.");
            
            Console.WriteLine("[C#] Calling boundSimple0.");
            Freefunctions.boundSimple0();
            Console.WriteLine("[C#] > OK");

            Console.WriteLine("[C#] Calling renamedSimple0.");
            Freefunctions.renamedSimple0();
            Console.WriteLine("[C#] > OK");

            Console.WriteLine("[C#] Calling boundSimpleOverload(int).");
            if(Freefunctions.boundSimpleOverload(5) == 0)
                Console.WriteLine("[C#] > OK");
            else
                {Console.WriteLine("[C#] > Wrong return value");return;}
            
            Console.WriteLine("[C#] Calling boundSimpleOverload(float).");
            if(Freefunctions.boundSimpleOverload(1.0f) == 3.1415f)
                Console.WriteLine("[C#] > OK");
            else
                {Console.WriteLine("[C#] > Wrong return value");return;}
            
            Console.WriteLine("[C#] Calling myWrite with various UTF strings.");
            Freefunctions.myWrite("This is UTF8", "This is UTF16", "This is UTF32");
            Console.WriteLine("[C#] > OK");

            Console.WriteLine("[C#] Finished C#->D tests.");
        }
    }
}

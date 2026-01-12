#include <iostream>

#include <complex>
#include <pbrapp.h>

// -----------------------------------------------------------------------------
// -----------------------------------------------------------------------------
int main(int argc, char* argv[])
{
    WindowProperties wprops( 640, 480, "FieldApp", true );
    PBRApp app(wprops);
    app.Run();

    return 0;
}

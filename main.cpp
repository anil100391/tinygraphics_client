#include <pbrapp.h>
#include <filesystem>

// -----------------------------------------------------------------------------
// -----------------------------------------------------------------------------
static std::string assetsDir;

// -----------------------------------------------------------------------------
// -----------------------------------------------------------------------------
int main(int argc, char* argv[])
{
    auto exeDir = std::filesystem::absolute(argv[0]);
    assetsDir = (exeDir.parent_path() / "assets").string();

    WindowProperties wprops( 640, 480, "FieldApp", true );
    PBRApp app(wprops, assetsDir);
    app.Run();

    return 0;
}

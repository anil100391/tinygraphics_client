#ifndef __pbrapp_h__
#define __pbrapp_h__

#include <tinygraphics/app.h>
#include <tinygraphics/shader.h>
#include <tinygraphics/camera.h>
#include <tinygraphics/texture.h>
#include <tinygraphics/vertexarray.h>
#include <tinygraphics/indexbuffer.h>
#include <tinygraphics/vertexbuffer.h>

// -----------------------------------------------------------------------------
// -----------------------------------------------------------------------------
class PBRApp : public Application
{
public:

    PBRApp( const WindowProperties &wprops = WindowProperties() );
    virtual ~PBRApp();

    virtual void Update() override;

    virtual bool OnEvent( Event &evt ) override;

private:

    void MakeSphereMesh( unsigned int segments, unsigned int rings, float radius );

    std::vector<float>            _vertices; // 3 pos, 3 normals per vertex, 2 texcoords
    std::vector<unsigned int>     _indices;

    std::unique_ptr<VertexArray>  _vao;
    std::unique_ptr<VertexBuffer> _vbo;
    std::unique_ptr<IndexBuffer>  _ibo;
    std::unique_ptr<Shader>       _shader;
    std::unique_ptr<Texture>      _texture;

    Camera                        _camera;
    glm::vec3                     _cameraPos {-1.0f, -1.0f, 5.0f};
    float                         _lightY = 0.0f;
    float                         _lightAngle = 0.0f;
};

#endif // __pbrapp_h__

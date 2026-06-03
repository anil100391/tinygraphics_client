#include <cmath>
#include <pbrapp.h>

#include <imgui.h>
#include <backends/imgui_impl_glfw.h>
#include <backends/imgui_impl_opengl3.h>

#include <tinygraphics/renderer.h>
#include <tinygraphics/vertexbufferlayout.h>

#include <glm/glm.hpp>

// -----------------------------------------------------------------------------
// -----------------------------------------------------------------------------
PBRApp::PBRApp( const WindowProperties &wprops, const std::string &assetsDir )
    : Application( wprops, true )
{
    glEnable( GL_BLEND );
    glEnable( GL_DEPTH_TEST );

    std::string vertexShader =
        "#version 330 core\n"
        "layout(location = 0) in vec3 position;\n"
        "layout(location = 1) in vec3 normal;\n"
        "layout(location = 2) in vec2 texCoord;\n"
        "uniform mat4 u_M;\n"
        "uniform mat4 u_V;\n"
        "uniform mat4 u_P;\n"
        "out vec3 fragNormal;\n"
        "out vec3 fragPos;\n"
        "out vec2 fragTexCoord;\n"
        "void main()\n"
        "{\n"
        "    gl_Position = u_P * u_V * u_M * vec4(position, 1.0);\n"
        "    fragPos = vec3(u_M * vec4(position, 1.0));\n"
        "    fragNormal = normal;\n"
        "    fragTexCoord = texCoord;\n"
        "}"
    ;

    std::string fragmentShader =
        "#version 330 core\n"
        "in vec3 fragNormal;\n"
        "in vec3 fragPos;\n"
        "in vec2 fragTexCoord;\n"
        "uniform vec3 u_Color;\n"
        "uniform vec3 u_LightPos;\n"
        "uniform vec3 u_CameraPos;\n"
        "uniform int  u_Emission;\n"
        "uniform sampler2D u_Texture;\n"
        "void main()\n"
        "{\n"
        "    if ( u_Emission != 0 )\n"
        "    {\n"
        "        gl_FragColor = vec4(u_Color, 1.0);\n"
        "        return;\n"
        "    }\n"

        "    vec3 lightColor = vec3(1.0);\n"
        "    // AMBIENT\n"
        "    float ambientFactor = 0.02;\n"
        "    vec3 ambient = ambientFactor * lightColor;\n"

        "    // DIFFUSE\n"
        "    vec3 norm = normalize(fragNormal);\n"
        "    vec3 lightDir = normalize(u_LightPos - fragPos);\n"
        "    float diffuseFactor = max(dot(norm, lightDir), 0.0);\n"
        "    vec3 diffuse = diffuseFactor * lightColor;\n"

        "    // SPECULAR\n"
        "    float specularStrength = 0.5;\n"
        "    vec3 viewDir = normalize(u_CameraPos - fragPos);\n"
        "    vec3 reflectDir = reflect(lightDir, norm);\n"
        "    vec3 specular = specularStrength * pow(max(dot(viewDir, reflectDir), 0.0), 32) * lightColor;\n"

        "    vec3 color = (ambient +  diffuse /*+ specular*/) * texture(u_Texture, fragTexCoord).rgb;\n"
        "    gl_FragColor = vec4(1.4 * color, 1.0);\n"
        "}"
    ;

    MakeSphereMesh( 64, 32, 0.5f );
    VertexBufferLayout layout;
    layout.Push<float>( 3 );
    layout.Push<float>( 3 );
    layout.Push<float>( 2 );
    _vao = std::make_unique<VertexArray>();
    _vbo = std::make_unique<VertexBuffer>(_vertices.data(), static_cast<unsigned int>(_vertices.size() * sizeof(float)));
    _vao->AddBuffer( *_vbo, layout );
    _ibo = std::make_unique<IndexBuffer>(_indices.data(), static_cast<unsigned int>(_indices.size()));
    _shader = std::make_unique<Shader>(vertexShader, fragmentShader);

    _camera.SetPosition( glm::vec3( -1.0f, -1.0f, 5.0f ) );
    _camera.SetLookAt( glm::vec3( 0.0f, 0.0f, 0.0f ) );
    _camera.SetUpVec( glm::vec3( 0.0f, 1.0f, 0.0f ) );

    _texture = std::make_unique<Texture>( assetsDir + "/moon.jpg" );
    _texture->Bind();
}

// -----------------------------------------------------------------------------
// -----------------------------------------------------------------------------
PBRApp::~PBRApp()
{
}

// -----------------------------------------------------------------------------
// -----------------------------------------------------------------------------
void PBRApp::Update()
{
    glClearColor( 0.0f, 0.0f, 0.0f, 1.0f );

    glClear( GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);

    Render();

    // Start the Dear ImGui frame
    ImGui_ImplOpenGL3_NewFrame();
    ImGui_ImplGlfw_NewFrame();
    ImGui::NewFrame();

    ImGui::SliderFloat3( "Camera Position", &_cameraPos.x, 0.0f, 50.0f );
    ImGui::SliderFloat( "Light Angle", &_lightAngle, 0.0f, 2 * M_PI );
    ImGui::SliderFloat( "Light Distance", &_lightY, 0.0f, 50.0f );

    // Rendering
    ImGui::Render();
    ImGui_ImplOpenGL3_RenderDrawData( ImGui::GetDrawData() );

    Application::Update();
}

// -----------------------------------------------------------------------------
// -----------------------------------------------------------------------------
bool PBRApp::OnEvent( Event & evt )
{
    return false;
}

// -----------------------------------------------------------------------------
// -----------------------------------------------------------------------------
void PBRApp::Render()
{
    Renderer renderer;

    // uniforms
    _shader->Bind();
    int width, height;
    GetWindowSize(width, height);
    _shader->SetUniform2f( "u_Size", static_cast<float>(width), static_cast<float>(height) );
    double x, y;
    GetCursorPosition( x, y );
    _shader->SetUniform2f( "u_MousePos", static_cast<float>(x), static_cast<float>(y) );
    _shader->SetUniform3f( "u_Color", 1.0f, 1.0f, 1.0f );

    _camera.SetPosition( _cameraPos );

    float angle = _lightAngle;
    float xl = -4.0f * std::sin( angle );
    float zl = -4.0f * std::cos( angle );
    _shader->SetUniform3f( "u_LightPos", xl, _lightY, zl );

    glm::mat4 model = glm::mat4( 1.0f );
    glm::mat4 view = _camera.GetViewMatrix();
    glm::mat4 projection = glm::perspective( glm::radians( 45.0f ),
                                         static_cast<float>( width ) / static_cast<float>( height ),
                                         0.1f,
                                         100.0f );
    _shader->SetUniformMat4f( "u_M", model );
    _shader->SetUniformMat4f( "u_V", view );
    _shader->SetUniformMat4f( "u_P", projection );
    _shader->SetUniform1i( "u_Emission", 0 );
    _shader->SetUniform1i( "u_Texture", 0 );

    // draw
    renderer.Draw( *_vao, *_ibo, *_shader );
}

// -----------------------------------------------------------------------------
// -----------------------------------------------------------------------------
void PBRApp::MakeSphereMesh( unsigned int segments,
                             unsigned int rings,
                             float radius )
{
   _vertices.clear();
   _indices.clear();

   for (unsigned int y = 0; y <= rings; ++y)
   {
       for (unsigned int x = 0; x <= segments; ++x)
       {
           float u = static_cast<float>(x) / segments;
           float v = static_cast<float>(y) / rings;

           // Spherical coordinates
           float theta = u * 2.0f * M_PI;
           float phi = v * M_PI;

           // Convert to Cartesian coordinates
           float sinPhi = sin(phi);
           float cosPhi = cos(phi);
           float sinTheta = sin(theta);
           float cosTheta = cos(theta);

           _vertices.push_back(radius * sinPhi * cosTheta);   // x
           _vertices.push_back(radius * cosPhi);              // y
           _vertices.push_back(radius * sinPhi * sinTheta);   // z

           // Normals (same as positions for a sphere)
           _vertices.push_back(sinPhi * cosTheta);
           _vertices.push_back(cosPhi);
           _vertices.push_back(sinPhi * sinTheta);

           // Texture coordinates
           _vertices.push_back(u);
           _vertices.push_back(v);
       }
   }

   // Generate indices
   for (unsigned int y = 0; y < rings; ++y)
   {
       for (unsigned int x = 0; x < segments; ++x)
       {
           unsigned int i0 = y * segments + x;
           unsigned int i1 = y * segments + x + 1;
           unsigned int i2 = (y + 1) * segments + x + 1;
           unsigned int i3 = (y + 1) * segments + x;

           // Two triangles per quad
           _indices.push_back( i0 );
           _indices.push_back( i1 );
           _indices.push_back( i2 );
           _indices.push_back( i2 );
           _indices.push_back( i3 );
           _indices.push_back( i0 );
       }
   }

   // write obj file for debugging
   std::ofstream out("sphere.obj");
   for (size_t i = 0; i < _vertices.size(); i += 8)
   {
       out << "v " << _vertices[i] << " " << _vertices[i + 1] << " " << _vertices[i + 2] << "\n";
       out << "vn " << _vertices[i + 3] << " " << _vertices[i + 4] << " " << _vertices[i + 5] << "\n";
       out << "vt " << _vertices[i + 6] << " " << _vertices[i + 7] << "\n";
   }
   for (size_t i = 0; i < _indices.size(); i += 3)
   {
       out << "f " << _indices[i] + 1 << " " << _indices[i + 1] + 1 << " " << _indices[i + 2] + 1 << "\n";
   }
   out.close();
}

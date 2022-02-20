from conans import ConanFile, CMake, tools
from os import path

package_project_name = "MathLibrary"
repo_root_dir = path.join("..", "..")

class MathLibraryConan(ConanFile):
    name = package_project_name
    version = "0.0.1"
    license = "MIT"
    author = "David Yair yair.david@elbitsystems.com"
    url = "http://gitlab/DP99662/conan-test.git"
    description = "Testing package for Conan"
    topics = ("Test", "Math", package_project_name)
    settings = "os", "compiler", "build_type", "arch"
    options = {"shared": [True, False], "fPIC": [True, False]}
    default_options = {"shared": False, "fPIC": True}
    generators = "cmake"
    exports_sources = f"{repo_root_dir}/*"

    def config_options(self):
        if self.settings.os == "Windows":
            del self.options.fPIC

    # def build(self):
        # print(f"Build started")
        # cmake = CMake(self)
        # print(f"Setting 'source_folder' attrib to path: {package_sources_dir}")
        # cmake.configure(source_folder=package_sources_dir)
        # print(f"Building..")
        # cmake.build()

        # Explicit way:
        # self.run('cmake %s/hello %s'
        #          % (self.source_folder, cmake.command_line))
        # self.run("cmake --build . %s" % cmake.build_config)

    def package(self):
        self.copy("*.h",        dst="include")
        self.copy(f"*{package_project_name}.lib", dst="lib",  keep_path=False)
        self.copy("*.dll",      dst="bin",  keep_path=False)
        self.copy("*.so",       dst="lib",  keep_path=False)
        self.copy("*.dylib",    dst="lib",  keep_path=False)
        self.copy("*.a",        dst="lib",  keep_path=False)

    def package_info(self):
        self.cpp_info.libs = [package_project_name]


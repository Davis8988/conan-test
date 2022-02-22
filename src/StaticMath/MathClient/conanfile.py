from conans import ConanFile, CMake, tools
import os
import shutil

package_project_name = "MathClient"
# repo_root_dir = os.path.join("..", "..")
# project_sources_dir = os.path.join(repo_root_dir, "src")
project_build_dir = "build"

class MathClientConan(ConanFile):
    name = package_project_name
    version = "0.0.1"
    license = "MIT"
    author = "David Yair yair.david@elbitsystems.com"
    url = "http://gitlab/DP99662/conan-test.git"
    description = "Testing package for Conan"
    topics = ("Test", "Math", package_project_name)
    # settings = "os", "compiler", "build_type", "arch"
    settings = "os", "compiler", "arch"
    options = {"shared": [True, False], "fPIC": [True, False]}
    default_options = {"shared": False, "fPIC": True}
    build_policy = "missing"  # "always"
    generators = "cmake"
    requires = ["MathLibrary/0.0.1@testing/anycpu" , "Printings/0.0.1@testing/anycpu"]
    # exports_sources = [f"{repo_root_dir}/*"]
    
    
    # Copy sources since they are located next to conanfile.py
    def export_sources(self):
        self.copy(f"*", excludes="**/*CMakeCache.txt")
    
    def config_options(self):
        if self.settings.os == "Windows":
            del self.options.fPIC
            
    def configure(self):
        if self.settings.compiler == "Visual Studio":
            del self.settings.compiler.runtime  # Necessary for Debug & Release configuration packages
        
    def conan_info(self):
        self.info.settings.clear()

    def build(self):
        self.output.warn(f"Build procedure started")
        project_cmake_generator = "Visual Studio 16 2019"
        self.output.info(f"CD={os.getcwd()}")
        # build_dir = os.path.join(os.getcwd(), 'build')
        self.output.info(f"Setting 'generator' attrib to: {project_cmake_generator}")
        cmake = CMake(self, generator=project_cmake_generator)
        # with tools.chdir(build_dir):
        for config in ("Debug", "Release"):
            self.output.info(f"Setting CMake build type to: {config}")
            cmake.build_type = config
            cmake.configure()
            self.output.warn(f"Cleaning..")
            cmake.build(target="clean")
            self.output.warn(f"Building conf: '{config}'")
            cmake.build()
            self.output.info(f"CD={os.getcwd()}")
            self.output.info(f"Done")
            self.output.success(f"Success - Finished building in '{config}'")
            self.output.warn(f"Cleaning..")
            shutil.rmtree("CMakeFiles")
            os.remove("CMakeCache.txt")
                
            # Explicit way:
            # self.run(f"cmake \"{cmake.source_folder}\" ")
            # self.run("cmake --build . %s" % cmake.build_config)

    def package(self):
        self.output.info(f"Copying from: {os.getcwd()}")
        self.copy("*.h",        dst="include")
        self.copy("*.lib",      src="build_out", dst="lib",  keep_path=True)
        self.copy("*.dll",      src="build_out", dst="bin",  keep_path=False)
        self.copy("*.so",       src="build_out", dst="lib",  keep_path=False)
        self.copy("*.dylib",    src="build_out", dst="lib",  keep_path=False)
        self.copy("*.a",        src="build_out", dst="lib",  keep_path=False)

    def package_info(self):
        self.cpp_info.name = package_project_name
        self.cpp_info.libdirs = ["lib"]
        self.cpp_info.includedirs = ["include"]
        self.cpp_info.bindirs = ["bin"]
        self.cpp_info.libs = [package_project_name]


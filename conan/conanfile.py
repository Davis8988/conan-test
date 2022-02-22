from conans import ConanFile, CMake, tools
import os

package_project_name = "StaticMath"
repo_root_dir = os.path.join("..")
project_sources_dir = os.path.join(repo_root_dir, "src")
project_build_dir = "build"

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
    build_policy = "missing"  # "always"
    generators = "cmake"
    # exports_sources = [f"{repo_root_dir}/*"]
    
    def export_sources(self):
        self.copy(f"{repo_root_dir}/*", excludes="**/*CMakeCache.txt")
    
    def config_options(self):
        self.settings.clear()
    
    def conan_info(self):
        self.info.settings.clear()

    def config_options(self):
        if self.settings.os == "Windows":
            del self.options.fPIC

    def build(self):
        print(f"Build procedure started")
        project_cmake_generator = "Visual Studio 16 2019"
        sources_dir = os.getcwd()
        print(f"CD={sources_dir}")
        build_dir = os.path.join(sources_dir, 'build')
        print(f"Creating dir: {build_dir}")
        tools.mkdir(build_dir)
        print("OK")
        print(f"CD into dir: {build_dir}")
        print(f"CD={os.getcwd()}")
        print(f"Setting 'generator' attrib to: {project_cmake_generator}")
        cmake = CMake(self, generator=project_cmake_generator)
        cmake.configure(source_dir=sources_dir, build_dir=build_dir)
        with tools.chdir(build_dir):
            print(f"Cleaning..")
            cmake.build(target="clean")
            print(f"Building..")
            cmake.build()
            print(f"CD={os.getcwd()}")
            print(f"Done")
            # Explicit way:
            # self.run(f"cmake \"{cmake.source_folder}\" ")
            # self.run("cmake --build . %s" % cmake.build_config)

    def package(self):
        print(f"Copying from: {os.getcwd()}")
        self.copy("*.h",        src="src", dst="include")
        self.copy("*.lib",      src="build/build_out", dst="lib",  keep_path=False)
        self.copy("*.dll",      src="build/build_out", dst="bin",  keep_path=False)
        self.copy("*.so",       src="build/build_out", dst="lib",  keep_path=False)
        self.copy("*.dylib",    src="build/build_out", dst="lib",  keep_path=False)
        self.copy("*.a",        src="build/build_out", dst="lib",  keep_path=False)

    def package_info(self):
        self.cpp_info.name = package_project_name
        self.cpp_info.libdirs = ["lib"]
        self.cpp_info.includedirs = ["include"]
        self.cpp_info.bindirs = ["bin"]
        self.cpp_info.libs = ["MathLibrary", "Printings"]


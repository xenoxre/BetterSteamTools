cmake -S src -B build\Release -G "MinGW Makefiles" -DCMAKE_BUILD_TYPE=Release
cmake --build build\Release --parallel

cmake_minimum_required(VERSION 3.14)
project(asynctask C ASM)

set(CMAKE_C_STANDARD 99)
SET(CMAKE_ASM_FLAGS "${CFLAGS} -x assembler-with-cpp")

add_executable(asynctask main.c task.h task.c task.s)
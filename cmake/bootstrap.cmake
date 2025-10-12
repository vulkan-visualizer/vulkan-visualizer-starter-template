set(REPO https://github.com/vulkan-visualizer/vulkan-visualizer.git)
set(BRANCH master)
set(SRC ${CMAKE_CURRENT_BINARY_DIR}/_src/vulkan-visualizer)
set(BIN ${CMAKE_CURRENT_BINARY_DIR}/_build/vulkan-visualizer)
set(PREFIX ${CMAKE_CURRENT_BINARY_DIR}/vulkan-visualizer-sdk)

execute_process(COMMAND git clone --depth 1 --branch ${BRANCH} ${REPO} ${SRC} RESULT_VARIABLE R1)
if (NOT R1 EQUAL 0)
    message(FATAL_ERROR "git clone failed")
endif ()

execute_process(COMMAND ${CMAKE_COMMAND} -S ${SRC} -B ${BIN} -DCMAKE_BUILD_TYPE=Release RESULT_VARIABLE R2)
if (NOT R2 EQUAL 0)
    message(FATAL_ERROR "cmake configure failed")
endif ()

execute_process(COMMAND ${CMAKE_COMMAND} --build ${BIN} --config Release --parallel RESULT_VARIABLE R3)
if (NOT R3 EQUAL 0)
    message(FATAL_ERROR "cmake build failed")
endif ()

execute_process(COMMAND ${CMAKE_COMMAND} --install ${BIN} --config Release --prefix ${PREFIX} RESULT_VARIABLE R4)
if (NOT R4 EQUAL 0)
    message(FATAL_ERROR "cmake install failed")
endif ()

execute_process(COMMAND "${CMAKE_COMMAND}" -E remove_directory "${SRC}" RESULT_VARIABLE R5)
if (NOT R5 EQUAL 0)
    message(FATAL_ERROR "cleanup SRC failed")
endif ()

execute_process(COMMAND "${CMAKE_COMMAND}" -E remove_directory "${BIN}" RESULT_VARIABLE R6)
if (NOT R6 EQUAL 0)
    message(FATAL_ERROR "cleanup BIN failed")
endif ()

message(STATUS "success: installed to ${PREFIX}")
cmake_minimum_required(VERSION 3.0)


project(ptime)


add_executable(
  ${PROJECT_NAME}
  
  ptime.cpp
)


target_link_libraries(
    ${PROJECT_NAME}
    Winmm
)


install(TARGETS ${PROJECT_NAME} RUNTIME DESTINATION .)


find_package(SelfPackers)
if(SELF_PACKER_FOR_EXECUTABLE)
  set(release $<CONFIG:Release>)
  add_custom_command(
    TARGET ${PROJECT_NAME}
    POST_BUILD
    COMMAND "$<${release}:${SELF_PACKER_FOR_EXECUTABLE}>" "$<${release}:-9>" "$<${release}:$<TARGET_FILE:${PROJECT_NAME}>>"
  )
endif()


set(CPACK_PACKAGE_NAME "${PROJECT_NAME}")
set(CPACK_PACKAGE_VENDOR "Salvania")
set(CPACK_GENERATOR "ZIP")
set(CPACK_PACKAGE_DIRECTORY "${CMAKE_SOURCE_DIR}")
set(CPACK_VERBATIM_VARIABLES true)
set(CPACK_PACKAGE_VERSION_MAJOR 1)
set(CPACK_PACKAGE_VERSION_MINOR 0)
set(CPACK_PACKAGE_VERSION_PATCH 0)
include(CPack)

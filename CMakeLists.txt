cmake_minimum_required(VERSION 3.15)
project(sensors_description)

# ==============================================================================
# Calculate correct project version number
# ==============================================================================
# Read in the current version
file(READ version.txt PROJECT_VERSION)

# create array of version strings
string(REPLACE "." ";" VERSION_ARRAY ${PROJECT_VERSION})
# ------------------------------------------------------------------------------
# Major, Minor, Patch numbers
# ------------------------------------------------------------------------------
# set corresponding cmake version variables
list(POP_FRONT VERSION_ARRAY
        PROJECT_VERSION_MAJOR
        PROJECT_VERSION_MINOR
        PROJECT_VERSION_PATCH
)
# Remove the trailing newline from the patch number
string(REPLACE "\n" "" PROJECT_VERSION_PATCH ${PROJECT_VERSION_PATCH})

# ------------------------------------------------------------------------------
# Full version number
# ------------------------------------------------------------------------------
# Rebuild the project version including the current commit hash
string(JOIN "." PROJECT_VERSION
        ${PROJECT_VERSION_MAJOR}
        ${PROJECT_VERSION_MINOR}
        ${PROJECT_VERSION_PATCH}
)
unset(VERSION_ARRAY) # delete aray of version strings
message(STATUS "SENSORS DESCRIPTION PROJECT VERSION ${PROJECT_VERSION}")

# ==============================================================================
# Setup the repository
# ==============================================================================
# This will perfom task such as setting up the git hooks for anyone who uses
# this project
execute_process(
	COMMAND           ./setup.sh
	WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}
)

install(
    DIRECTORY   launch meshes urdfs
    DESTINATION /usr/include/${PROJECT_NAME}
    COMPONENT   sensors_desc
    PATTERN     ".svn" EXCLUDE
)

list(APPEND SCRIPTS
  ./scripts/enableVelodyne.sh
  ./scripts/getVelodyneDiag.sh
  ./scripts/getVelodyneInfo.sh
  ./scripts/getVelodyneSettings.sh
  ./scripts/getVelodyneSnapshot.sh
  ./scripts/setVelodyneFOV.sh
  ./scripts/setVelodyneLaser.sh
  ./scripts/setVelodyneReturns.sh
  ./scripts/setVelodyneRPM.sh
  ./scripts/startVelodyne.sh
)

install(
  FILES ${SCRIPTS}
  DESTINATION /usr/lib/${PROJECT_NAME}
  PERMISSIONS OWNER_READ OWNER_WRITE OWNER_EXECUTE GROUP_READ GROUP_EXECUTE WORLD_READ WORLD_EXECUTE
  COMPONENT   sensors_desc
)

set(CPACK_PACKAGE_VERSION_MAJOR                 ${PROJECT_VERSION_MAJOR})
set(CPACK_PACKAGE_VERSION_MINOR                 ${PROJECT_VERSION_MINOR})
set(CPACK_PACKAGE_VERSION_PATCH                 ${PROJECT_VERSION_PATCH})
set(CPACK_DEBIAN_PACKAGE_VERSION                ${PROJECT_VERSION})
set(CPACK_PACKAGE_VENDOR                        "dlslab")
set(CPACK_PACKAGE_CONTACT                       "dlslab")
set(CPACK_DEBIAN_PACKAGE_MAINTAINER             "dlslab")
set(CPACK_VERBATIM_VARIABLES                    ON)
set(CPACK_GENERATOR                             "DEB")
set(CPACK_DEB_COMPONENT_INSTALL                 ON)

set(CPACK_DEBIAN_SENSORS_DESC_PACKAGE_NAME      "sensors-description" CACHE INTERNAL "")
set(CPACK_DEBIAN_SENSORS_DESC_FILE_NAME         "sensors-description-${PROJECT_VERSION}.deb" CACHE INTERNAL "")
set(CPACK_DEBIAN_SENSORS_DESC_PACKAGE_DEPENDS   "" CACHE INTERNAL "")

include(CPack)
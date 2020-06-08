##
## Redistribution and use in source and binary forms, with or without
## modification, are permitted provided that the following conditions
## are met:
##  * Redistributions of source code must retain the above copyright
##    notice, this list of conditions and the following disclaimer.
##  * Redistributions in binary form must reproduce the above copyright
##    notice, this list of conditions and the following disclaimer in the
##    documentation and/or other materials provided with the distribution.
##  * Neither the name of NVIDIA CORPORATION nor the names of its
##    contributors may be used to endorse or promote products derived
##    from this software without specific prior written permission.
##
## THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS ``AS IS'' AND ANY
## EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
## IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR
## PURPOSE ARE DISCLAIMED.  IN NO EVENT SHALL THE COPYRIGHT OWNER OR
## CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
## EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
## PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
## PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY
## OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
## (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
## OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
##
## Copyright (c) 2018-2019 NVIDIA Corporation. All rights reserved.

cmake_minimum_required(VERSION 3.7)
project(Snippets C CXX)

# export PM_PxShared_PATH="$PHYSX_ROOT_DIR/../pxshared"
# export PM_CMakeModules_PATH="$PHYSX_ROOT_DIR/../externals/cmakemodules"

SET(CMAKE_RUNTIME_OUTPUT_DIRECTORY "/home/eric/projects/physx/snippets_build_output")

SET(TARGET_BUILD_PLATFORM "linux")  # just used to select some linux makefiles

# SET(PX_OUTPUT_ARCH "x86")
# SET(CMAKE_C_COMPILER "clang")
# SET(CMAKE_CXX_COMPILER "clang++")
SET(CMAKE_PREFIX_PATH "/home/eric/projects/physx/PhysX/physx/../externals/opengl-linux;/home/eric/projects/physx/PhysX/physx/../externals/targa;/home/eric/projects/physx/PhysX/physx/../externals/cg-linux;/home/eric/projects/physx/PhysX/physx/../externals/glew-linux")
SET(PHYSX_ROOT_DIR "/home/eric/projects/physx/PhysX/physx")

# SET(PX_OUTPUT_LIB_DIR "/home/eric/projects/physx/PhysX/physx")
# SET(PX_OUTPUT_BIN_DIR "/home/eric/projects/physx/PhysX/physx")
# SET(PX_BUILDSNIPPETS TRUE)
# SET(PX_BUILDPUBLICSAMPLES TRUE)
# SET(PX_GENERATE_STATIC_LIBRARIES TRUE)
# SET(CMAKE_INSTALL_PREFIX "/home/eric/projects/physx/PhysX/physx/install/linux/PhysX")
SET(CMAKE_BUILD_TYPE release)

# SET(CMAKEMODULES_PATH "/home/eric/projects/physx/PhysX/externals/cmakemodules")
# SET(CMAKEMODULES_NAME "CMakeModules" CACHE INTERNAL "CMakeModules name")
# SET(CMAKEMODULES_VERSION "unknown cmakemodules version" CACHE INTERNAL "CMakeModules version from generation batch")

# SET(PHYSX_LINUX_COMPILE_DEFS "${CUDA_FLAG};${PHYSX_AUTOBUILD}" CACHE INTERNAL "Base PhysX preprocessor definitions")
SET(PHYSX_LINUX_COMPILE_DEFS "")

# SET(CLANG_WARNINGS "-ferror-limit=0 -Wall -Wextra -Werror -Wstrict-aliasing=2 -Weverything -Wno-documentation-deprecated-sync -Wno-documentation-unknown-command -Wno-gnu-anonymous-struct -Wno-undef -Wno-unused-function -Wno-nested-anon-types -Wno-float-equal -Wno-padded -Wno-weak-vtables -Wno-cast-align -Wno-conversion -Wno-missing-noreturn -Wno-missing-variable-declarations -Wno-shift-sign-overflow -Wno-covered-switch-default -Wno-exit-time-destructors -Wno-global-constructors -Wno-missing-prototypes -Wno-unreachable-code -Wno-unused-macros -Wno-unused-member-function -Wno-used-but-marked-unused -Wno-weak-template-vtables -Wno-deprecated -Wno-non-virtual-dtor -Wno-invalid-noreturn -Wno-return-type-c-linkage -Wno-reserved-id-macro -Wno-c++98-compat-pedantic -Wno-unused-local-typedef -Wno-old-style-cast -Wno-newline-eof -Wno-unused-private-field -Wno-format-nonliteral -Wno-implicit-fallthrough -Wno-undefined-reinterpret-cast -Wno-disabled-macro-expansion -Wno-zero-as-null-pointer-constant -Wno-shadow -Wno-unknown-warning-option -Wno-atomic-implicit-seq-cst -Wno-extra-semi-stmt")
SET(GCC_WARNINGS "-Wall -Werror -Wno-invalid-offsetof -Wno-uninitialized")

IF ("${CMAKE_CXX_COMPILER_ID}" STREQUAL "Clang")
	message(FATAL_ERROR "here in Clang block")
	# using Clang	  
	SET(PHYSX_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++11 -fno-rtti -fno-exceptions -ffunction-sections -fdata-sections -fstrict-aliasing ${CLANG_WARNINGS}" CACHE INTERAL "PhysX CXX")
ELSEIF ("${CMAKE_CXX_COMPILER_ID}" STREQUAL "GNU")
	SET(PHYSX_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++11 -fno-rtti -fno-exceptions -ffunction-sections -fdata-sections -fno-strict-aliasing ${GCC_WARNINGS}" CACHE INTERAL "PhysX CXX")
ENDIF()


# EJU locating snippets separately from PHYSX_ROOT_DIR in an effort to decouple the building
# of snippets from the physx libraries themselves
SET(SNIPPETS_ROOT_DIR "/home/eric/projects/physx/PhysX/physx/snippets")

################

# IF(NOT DEFINED CMAKEMODULES_VERSION)
# 	SET(CMAKEMODULES_PATH $ENV{PM_CMakeModules_PATH} CACHE INTERNAL "Path to CMakeModules")
# 	SET(CMAKEMODULES_NAME $ENV{PM_CMakeModules_NAME} CACHE INTERNAL "CMakeModules name")
# 	SET(CMAKEMODULES_VERSION $ENV{PM_CMakeModules_VERSION} CACHE INTERNAL "CMakeModules version from generation batch")
# 	#TODO: More elegance
# 	IF(NOT EXISTS ${CMAKEMODULES_PATH})
# 		MESSAGE(FATAL_ERROR "Could not find ${CMAKEMODULES_PATH}")
# 	ENDIF()
# ENDIF()

# SET(CMAKE_MODULE_PATH ${CMAKEMODULES_PATH})

# This is required to be defined by external callers!
IF(NOT DEFINED PHYSX_ROOT_DIR)
	MESSAGE(FATAL_ERROR "PHYSX_ROOT_DIR variable wasn't set.")
ENDIF()

IF(NOT EXISTS ${PHYSX_ROOT_DIR})
	MESSAGE(FATAL_ERROR "PHYSX_ROOT_DIR variable was invalid.")
ENDIF()

# INCLUDE(NvidiaBuildOptions)

IF(CMAKE_CONFIGURATION_TYPES)
	SET(CMAKE_CONFIGURATION_TYPES debug checked profile release)
	SET(CMAKE_CONFIGURATION_TYPES "${CMAKE_CONFIGURATION_TYPES}" CACHE STRING
		"Reset config to what we need" 
		FORCE)
	
	# Need to define these at least once.	
	SET(CMAKE_SHARED_LINKER_FLAGS_CHECKED "/DEBUG")
	SET(CMAKE_SHARED_LINKER_FLAGS_PROFILE "/DEBUG")

	SET(CMAKE_EXE_LINKER_FLAGS_PROFILE "/DEBUG")
	SET(CMAKE_EXE_LINKER_FLAGS_CHECKED "/DEBUG")	
ENDIF()


SET(PROJECT_CMAKE_FILES_DIR compiler/cmake)
SET(PLATFORM_CMAKELISTS ${SNIPPETS_ROOT_DIR}/${PROJECT_CMAKE_FILES_DIR}/${TARGET_BUILD_PLATFORM}/CMakeLists.txt)

IF(NOT EXISTS ${PLATFORM_CMAKELISTS})
	MESSAGE(FATAL_ERROR "Unable to find platform CMakeLists.txt for ${TARGET_BUILD_PLATFORM} at ${PLATFORM_CMAKELISTS}")
ENDIF()

# Include the platform specific CMakeLists
INCLUDE(${SNIPPETS_ROOT_DIR}/${PROJECT_CMAKE_FILES_DIR}/${TARGET_BUILD_PLATFORM}/CMakeLists.txt)

SET(SOURCE_DISTRO_FILE_LIST "")

# Include all of the projects
# SET(SNIPPETS_LIST Articulation BVHStructure ContactModification ContactReport ContactReportCCD ConvexMeshCreate
# 	CustomJoint CustomProfiler DeformableMesh HelloWorld ImmediateArticulation ImmediateMode Joint MBP MultiThreading
#	PrunerSerialization RaycastCCD Serialization SplitFetchResults 
#	SplitSim Stepper ToleranceScale TriangleMeshCreate)
# only build HelloWorld
SET(SNIPPETS_LIST HelloWorld)

LIST(APPEND SNIPPETS_LIST ${PLATFORM_SNIPPETS_LIST})
		
SET(SNIPPETS_VEHICLE_LIST NestedScene Vehicle4W VehicleContactMod VehicleMultiThreading 
	VehicleNoDrive VehicleScale VehicleTank)	

LIST(APPEND SNIPPETS_VEHICLE_LIST ${PLATFORM_SNIPPETS_VEHICLE_LIST})

IF(SNIPPET_RENDER_ENABLED)
	INCLUDE(SnippetRender.cmake)
	SET_PROPERTY(TARGET SnippetRender PROPERTY FOLDER "Snippets")
ENDIF()

INCLUDE(SnippetUtils.cmake)
SET_PROPERTY(TARGET SnippetUtils PROPERTY FOLDER "Snippets")

FOREACH(SNIPPET_NAME ${SNIPPETS_LIST})
	INCLUDE(SnippetTemplate.cmake)
	SET_PROPERTY(TARGET Snippet${SNIPPET_NAME} PROPERTY FOLDER "Snippets")
ENDFOREACH()

# FOREACH(SNIPPET_NAME ${SNIPPETS_VEHICLE_LIST})
#	INCLUDE(SnippetVehicleTemplate.cmake)
#	SET_PROPERTY(TARGET Snippet${SNIPPET_NAME} PROPERTY FOLDER "Snippets")
# ENDFOREACH()

IF(PX_GENERATE_SOURCE_DISTRO)
	FOREACH(FILE_NAME ${SOURCE_DISTRO_FILE_LIST})
		FILE(APPEND "${CMAKE_CURRENT_BINARY_DIR}/source_distro_list.txt" "${FILE_NAME}\n")
	ENDFOREACH()
ENDIF()
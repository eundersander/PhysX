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

#
# Build Snippet common template
#

# Include here after the directories are defined so that the platform specific file can use the variables.
INCLUDE(${SNIPPETS_ROOT_DIR}/${PROJECT_CMAKE_FILES_DIR}/${TARGET_BUILD_PLATFORM}/SnippetTemplate.cmake)

STRING(TOLOWER ${SNIPPET_NAME} SNIPPET_NAME_LOWER)
FILE(GLOB SnippetSources ${SNIPPETS_ROOT_DIR}/snippet${SNIPPET_NAME_LOWER}/*.cpp)
FILE(GLOB SnippetHeaders ${SNIPPETS_ROOT_DIR}/snippet${SNIPPET_NAME_LOWER}/*.h)

ADD_EXECUTABLE(Snippet${SNIPPET_NAME} ${SNIPPET_BUNDLE}
	${SNIPPET_PLATFORM_SOURCES}

	${SnippetSources}
	${SnippetHeaders}
)

TARGET_INCLUDE_DIRECTORIES(Snippet${SNIPPET_NAME}
	PRIVATE ${SNIPPET_PLATFORM_INCLUDES}
	
	PRIVATE ${PHYSX_ROOT_DIR}/include/
	PRIVATE ${PHYSX_ROOT_DIR}/source/physxextensions/src
)

TARGET_COMPILE_DEFINITIONS(Snippet${SNIPPET_NAME}
	PRIVATE ${SNIPPET_COMPILE_DEFS}
)

IF(NV_USE_GAMEWORKS_OUTPUT_DIRS)
	message(FATAL ERROR "using gameworks; this is wrong")
	SET_TARGET_PROPERTIES(Snippet${SNIPPET_NAME} PROPERTIES 
		RUNTIME_OUTPUT_DIRECTORY_DEBUG ${PX_EXE_OUTPUT_DIRECTORY_DEBUG}${EXE_PLATFORM_DIR}
		RUNTIME_OUTPUT_DIRECTORY_PROFILE ${PX_EXE_OUTPUT_DIRECTORY_PROFILE}${EXE_PLATFORM_DIR}
		RUNTIME_OUTPUT_DIRECTORY_CHECKED ${PX_EXE_OUTPUT_DIRECTORY_CHECKED}${EXE_PLATFORM_DIR}
		RUNTIME_OUTPUT_DIRECTORY_RELEASE ${PX_EXE_OUTPUT_DIRECTORY_RELEASE}${EXE_PLATFORM_DIR}

		OUTPUT_NAME Snippet${SNIPPET_NAME}${EXE_SUFFIX}
	)
ELSE()
	IF(APPEND_CONFIG_NAME)
		SET_TARGET_PROPERTIES(Snippet${SNIPPET_NAME} PROPERTIES
			DEBUG_OUTPUT_NAME Snippet${SNIPPET_NAME}DEBUG
			PROFILE_OUTPUT_NAME Snippet${SNIPPET_NAME}PROFILE
			CHECKED_OUTPUT_NAME Snippet${SNIPPET_NAME}CHECKED
			RELEASE_OUTPUT_NAME Snippet${SNIPPET_NAME}
		)
	ENDIF()
ENDIF()

TARGET_LINK_LIBRARIES(Snippet${SNIPPET_NAME} 
#	PUBLIC PhysXExtensions PhysX PhysXPvdSDK PhysXVehicle PhysXCharacterKinematic PhysXCooking PhysXCommon PhysXFoundation SnippetUtils
	PUBLIC SnippetUtils
	PUBLIC ${SNIPPET_PLATFORM_LINKED_LIBS})

foreach(lib PhysXExtensions PhysX PhysXPvdSDK PhysXVehicle PhysXCharacterKinematic PhysXCooking PhysXCommon PhysXFoundation )
# foreach(lib PhysXExtensions PhysX PhysXPvdSDK PhysXVehicle PhysXCharacterKinematic PhysXCooking PhysXCommon )
    # look for libraries with expected file suffix "_static_64".
    # look in external physx build output folder
    find_library(${lib}_LIB ${lib}_static_64 PATHS
        /home/eric/projects/physx/PhysX/physx/bin/linux.clang/release/)   
    # message("${lib}_LIB = ${${lib}_LIB}")
    list(APPEND physx_libs ${${lib}_LIB})
endforeach()

target_link_libraries(Snippet${SNIPPET_NAME} PUBLIC
    ${physx_libs}
    # rt
    pthread
    # dl
    )

IF(CUSTOM_SNIPPET_TARGET_PROPERTIES)
	SET_TARGET_PROPERTIES(Snippet${SNIPPET_NAME} PROPERTIES 
	   ${CUSTOM_SNIPPET_TARGET_PROPERTIES}
	)
ENDIF()

IF(PX_GENERATE_SOURCE_DISTRO)	
	LIST(APPEND SOURCE_DISTRO_FILE_LIST ${SNIPPET_PLATFORM_SOURCES})
	LIST(APPEND SOURCE_DISTRO_FILE_LIST ${SnippetSources})
	LIST(APPEND SOURCE_DISTRO_FILE_LIST ${SnippetHeaders})
ENDIF()
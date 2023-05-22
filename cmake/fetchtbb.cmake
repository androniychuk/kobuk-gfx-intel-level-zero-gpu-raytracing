## Copyright 2009-2021 Intel Corporation
## SPDX-License-Identifier: Apache-2.0

####################################################################
# fetch TBB and build static version of it

option(TBB_STRICT "Treat compiler warnings as errors" OFF)
option(TBB_TEST "Enable testing" OFF)
option(TBBMALLOC_BUILD "Enable tbbmalloc build" OFF)
SET(TBB_DIR OFF)
SET(BUILD_SHARED_LIBS OFF)

IF (EXISTS ${PROJECT_SOURCE_DIR}/tbb)
  add_subdirectory(${PROJECT_SOURCE_DIR}/tbb ${CMAKE_BINARY_DIR}/tbb EXCLUDE_FROM_ALL)
ELSE()

INCLUDE(FetchContent)

SET(FETCHCONTENT_QUIET OFF)

IF (NOT EMBREE_RTHWIF_TBB_GIT_REPOSITORY) # allow setting this externally
  SET(EMBREE_RTHWIF_TBB_GIT_REPOSITORY "https://github.com/oneapi-src/oneTBB.git")
ENDIF()

FetchContent_Declare(
  tbb_static
  GIT_REPOSITORY ${EMBREE_RTHWIF_TBB_GIT_REPOSITORY}
  GIT_TAG v2021.6.0
  )

FetchContent_GetProperties(tbb_static)
if(NOT tbb_static_POPULATED)
  FetchContent_Populate(tbb_static)
  # We want to build tbb_static to link it into embree_rthwif, but don't want to
  # install it as part of the Embree install targets.
  add_subdirectory(${tbb_static_SOURCE_DIR} ${tbb_static_BINARY_DIR} EXCLUDE_FROM_ALL)
endif()

ENDIF()

MARK_AS_ADVANCED(FETCHCONTENT_BASE_DIR)
MARK_AS_ADVANCED(FETCHCONTENT_FULLY_DISCONNECTED)
MARK_AS_ADVANCED(FETCHCONTENT_QUIET)
MARK_AS_ADVANCED(FETCHCONTENT_SOURCE_DIR_TBB_STATIC)
MARK_AS_ADVANCED(FETCHCONTENT_UPDATES_DISCONNECTED)
MARK_AS_ADVANCED(FETCHCONTENT_UPDATES_DISCONNECTED_TBB_STATIC)

MARK_AS_ADVANCED(TBB4PY_BUILD)
MARK_AS_ADVANCED(TBBMALLOC_BUILD)
MARK_AS_ADVANCED(TBB_BUILD)
MARK_AS_ADVANCED(TBB_CPF)
MARK_AS_ADVANCED(TBB_DISABLE_HWLOC_AUTOMATIC_SEARCH)
MARK_AS_ADVANCED(TBB_ENABLE_IPO)
MARK_AS_ADVANCED(TBB_EXAMPLES)
MARK_AS_ADVANCED(TBB_FIND_PACKAGE)
MARK_AS_ADVANCED(TBB_INSTALL_VARS)
MARK_AS_ADVANCED(TBB_NO_APPCONTAINER)
MARK_AS_ADVANCED(TBB_SANITIZE)
MARK_AS_ADVANCED(TBB_STRICT)
MARK_AS_ADVANCED(TBB_TEST)
MARK_AS_ADVANCED(TBB_TEST_SPEC)
MARK_AS_ADVANCED(TBB_VALGRIND_MEMCHECK)
MARK_AS_ADVANCED(TBB_WINDOWS_DRIVER)


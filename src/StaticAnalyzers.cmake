macro(enable_cppcheck)
  find_program(CPPCHECK cppcheck)
  if(CPPCHECK)
    set(CMAKE_CXX_CPPCHECK
        ${CPPCHECK}
        --suppress=missingInclude
        --enable=all
        --inline-suppr
        --inconclusive)
    if(${CMAKE_CXX_STANDARD})
      set(CMAKE_CXX_CPPCHECK ${CMAKE_CXX_CPPCHECK} --std=c++${CMAKE_CXX_STANDARD})
    endif()
    if(WARNINGS_AS_ERRORS)
      list(APPEND CMAKE_CXX_CPPCHECK --error-exitcode=2)
    endif()
  else()
    message(${WARNING_MESSAGE} "cppcheck requested but executable not found")
  endif()
endmacro()

macro(enable_clang_tidy)
  # https://github.com/ejfitzgerald/clang-tidy-cache
  find_program(CLANGTIDY clang-tidy)
  find_program(
    CLANGTIDY_CACHE
    NAMES "clang-tidy-cache"
          "clang-tidy-cache-windows-amd64"
          "clang-tidy-cache-linux-amd64"
          "clang-tidy-cache-darwin-amd64")
  if(CLANGTIDY)
    if(CLANGTIDY_CACHE)
      set($ENV{CLANG_TIDY_CACHE_BINARY} ${CLANGTIDY})
      set(CLANGTIDY ${CLANGTIDY_CACHE})
    endif()
    set(CMAKE_CXX_CLANG_TIDY ${CLANGTIDY} -extra-arg=-Wno-unknown-warning-option)
    if(${CMAKE_CXX_STANDARD})
      set(CMAKE_CXX_CLANG_TIDY ${CMAKE_CXX_CLANG_TIDY} -extra-arg=-std=c++${CMAKE_CXX_STANDARD})
    endif()
    if(WARNINGS_AS_ERRORS)
      list(APPEND CMAKE_CXX_CLANG_TIDY -warnings-as-errors=*)
    endif()
  else()
    message(${WARNING_MESSAGE} "clang-tidy requested but executable not found")
  endif()
endmacro()

macro(enable_include_what_you_use)
  find_program(INCLUDE_WHAT_YOU_USE include-what-you-use)
  if(INCLUDE_WHAT_YOU_USE)
    set(CMAKE_CXX_INCLUDE_WHAT_YOU_USE ${INCLUDE_WHAT_YOU_USE})
  else()
    message(${WARNING_MESSAGE} "include-what-you-use requested but executable not found")
  endif()
endmacro()

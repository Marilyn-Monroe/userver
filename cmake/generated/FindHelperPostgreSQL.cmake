# AUTOGENERATED, DON'T CHANGE THIS FILE!

set(PostgreSQL_ADDITIONAL_VERSIONS "12" "13" "14")
 
                  
 
 

include(FindPackageHandleStandardArgs)

 
 
 

if(UNIX AND NOT APPLE)
  find_program(DPKG_QUERY_BIN dpkg-query)
  if(DPKG_QUERY_BIN)
    execute_process(
      COMMAND dpkg-query --showformat=\${Version} --show libpq-dev
      OUTPUT_VARIABLE PostgreSQL_version_output
      ERROR_VARIABLE PostgreSQL_version_error
      RESULT_VARIABLE PostgreSQL_version_result
      OUTPUT_STRIP_TRAILING_WHITESPACE
    )
    if(PostgreSQL_version_result EQUAL 0)
      set(PostgreSQL_VERSION ${PostgreSQL_version_output})
      message(STATUS "Installed version libpq-dev: ${PostgreSQL_VERSION}")
    endif(PostgreSQL_version_result EQUAL 0)
  endif(DPKG_QUERY_BIN)
endif(UNIX AND NOT APPLE)
 
if(APPLE)
  find_program(BREW_BIN brew)
  if(BREW_BIN)
    execute_process(
      COMMAND brew list --versions postgres
      OUTPUT_VARIABLE PostgreSQL_version_output
      ERROR_VARIABLE PostgreSQL_version_error
      RESULT_VARIABLE PostgreSQL_version_result
      OUTPUT_STRIP_TRAILING_WHITESPACE
    )
    if(PostgreSQL_version_result EQUAL 0)
      if (PostgreSQL_version_output MATCHES "^(.*) (.*)$")
        set(PostgreSQL_VERSION ${CMAKE_MATCH_2})
        message(STATUS "Installed version postgres: ${PostgreSQL_VERSION}")
      else()
        set(PostgreSQL_VERSION "NOT_FOUND")
      endif()
    else()
      message(WARNING "Failed execute brew: ${PostgreSQL_version_error}")
    endif(PostgreSQL_version_result EQUAL 0)
  endif(BREW_BIN)
endif(APPLE)
 
 
find_package(PostgreSQL 12
 )
 
 
if(NOT PostgreSQL_FOUND)
  message(FATAL_ERROR "Could not find `PostgreSQL` package. Debian: sudo apt update && sudo apt install libpq-dev postgresql-server-dev-12 MacOS: brew install postgres Version: 12")
elseif(PostgreSQL_version_result)
  if(PostgreSQL_version_result EQUAL 0)
    if(PostgreSQL_VERSION VERSION_LESS 12)
      message(FATAL_ERROR "Found but version is PostgreSQL_VERSION. Could not find `PostgreSQL` package. Debian: sudo apt update && sudo apt install libpq-dev postgresql-server-dev-12 MacOS: brew install postgres Version: 12")
    endif()
  else()
    message(WARNING "Can not determine version. ${PostgreSQL_version_error}")
  endif()
endif()

 
if (NOT TARGET PostgreSQL)
  add_library(PostgreSQL INTERFACE IMPORTED GLOBAL)
   target_include_directories(PostgreSQL INTERFACE ${PostgreSQL_INCLUDE_DIRS})
   target_link_libraries(PostgreSQL INTERFACE ${PostgreSQL_LIBRARIES})
  endif(NOT TARGET PostgreSQL)
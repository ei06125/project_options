#
# This function will prevent in-source builds
#
function(assure_out_of_source_builds)
  # make sure the user doesn't play dirty with symlinks
  get_filename_component(srcdir "${CMAKE_SOURCE_DIR}" REALPATH)
  get_filename_component(bindir "${CMAKE_BINARY_DIR}" REALPATH)

  # disallow in-source builds
  if("${srcdir}" STREQUAL "${bindir}")
    log_warn("######################################################")
    log_warn("Warning: in-source builds are disabled")
    log_warn("Please create a separate build directory and run cmake from there")
    log_warn("######################################################")
    log_fatal("Quitting configuration")
  endif()
endfunction()

assure_out_of_source_builds()

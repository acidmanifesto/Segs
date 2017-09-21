include(ExternalProject)
function(encode_lib_name basename)
    if(UNIX)
        set(${basename}_LIBRARY_SHARED lib${basename}.so PARENT_SCOPE)
        set(${basename}_LIBRARY_SHARED_D lib${basename}.so PARENT_SCOPE)
        set(${basename}_LIBRARY_STATIC lib${basename}.a PARENT_SCOPE)
        set(${basename}_LIBRARY_STATIC_D lib${basename}.a PARENT_SCOPE)
        set(${basename}_LIBRARY_IMP ${basename}.so PARENT_SCOPE)
        set(${basename}_LIBRARY_IMP_D ${basename}.so PARENT_SCOPE)
    elseif(MSVC)
        set(${basename}_LIBRARY_SHARED ${basename}.dll PARENT_SCOPE)
        set(${basename}_LIBRARY_SHARED_D ${basename}d.dll PARENT_SCOPE)
        set(${basename}_LIBRARY_STATIC ${basename}.lib PARENT_SCOPE)
        set(${basename}_LIBRARY_STATIC_D ${basename}d.lib PARENT_SCOPE)
        set(${basename}_LIBRARY_IMP ${basename}.lib PARENT_SCOPE)
        set(${basename}_LIBRARY_IMP_D ${basename}d.lib PARENT_SCOPE)
    elseif(MINGW)
        set(${basename}_LIBRARY_STATIC lib${basename}.a PARENT_SCOPE)
        set(${basename}_LIBRARY_STATIC_D lib${basename}.a PARENT_SCOPE)
        set(${basename}_LIBRARY_SHARED lib${basename}.dll PARENT_SCOPE)
        set(${basename}_LIBRARY_SHARED_D lib${basename}.dll PARENT_SCOPE)
        set(${basename}_LIBRARY_IMP lib${basename}.dll.a PARENT_SCOPE)
        set(${basename}_LIBRARY_IMP_D lib${basename}.dll.a PARENT_SCOPE)
    endif()
endfunction()
function(libname tgt basename)
    encode_lib_name(${basename})
    set(${tgt}_LIBRARY_STATIC ${ThirdParty_Install_Dir}/lib/${${basename}_LIBRARY_STATIC} PARENT_SCOPE)
    set(${tgt}_LIBRARY_STATIC_D ${ThirdParty_Install_Dir}/lib/${${basename}_LIBRARY_STATIC_D} PARENT_SCOPE)
    if(UNIX)
        set(${tgt}_LIBRARY_SHARED ${ThirdParty_Install_Dir}/lib/${${basename}_LIBRARY_SHARED} PARENT_SCOPE)
        set(${tgt}_LIBRARY_SHARED_D ${ThirdParty_Install_Dir}/lib/${${basename}_LIBRARY_SHARED_D} PARENT_SCOPE)
    else()
        set(${tgt}_LIBRARY_SHARED ${ThirdParty_Install_Dir}/bin/${${basename}_LIBRARY_SHARED} PARENT_SCOPE)
        set(${tgt}_LIBRARY_SHARED_D ${ThirdParty_Install_Dir}/bin/${${basename}_LIBRARY_SHARED_D} PARENT_SCOPE)
    endif()
    set(${tgt}_LIBRARY_IMP ${ThirdParty_Install_Dir}/lib/${${basename}_LIBRARY_IMP} PARENT_SCOPE)
    set(${tgt}_LIBRARY_IMP_D ${ThirdParty_Install_Dir}/lib/${${basename}_LIBRARY_IMP_D} PARENT_SCOPE)
endfunction()
macro(set_shared_lib_properties basename)
    SET_PROPERTY(TARGET ${basename}_IMP APPEND PROPERTY IMPORTED_LOCATION ${${basename}_LIBRARY_SHARED} )
    SET_PROPERTY(TARGET ${basename}_IMP APPEND PROPERTY IMPORTED_LOCATION_DEBUG ${${basename}_LIBRARY_SHARED_D} )
    SET_PROPERTY(TARGET ${basename}_IMP APPEND PROPERTY IMPORTED_LOCATION_RELEASE ${${basename}_LIBRARY_SHARED} )
    SET_PROPERTY(TARGET ${basename}_IMP APPEND PROPERTY IMPORTED_IMPLIB ${${basename}_LIBRARY_IMP} )
    SET_PROPERTY(TARGET ${basename}_IMP APPEND PROPERTY IMPORTED_IMPLIB_RELEASE ${${basename}_LIBRARY_IMP} )
    SET_PROPERTY(TARGET ${basename}_IMP APPEND PROPERTY IMPORTED_IMPLIB_DEBUG ${${basename}_LIBRARY_IMP_D} )
endmacro()
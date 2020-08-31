cmake_minimum_required(VERSION 3.5)

project(relaybaton-desktop LANGUAGES CXX)

set(CMAKE_INCLUDE_CURRENT_DIR ON)

set(CMAKE_AUTOUIC ON)
set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)

set(CMAKE_CXX_STANDARD 11)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

IF (NOT APPLE AND NOT MSVC)
    SET(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -pthread")
ENDIF ()
IF (APPLE)
    SET(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -framework CoreFoundation -framework Security")
ENDIF ()

# QtCreator supports the following variables for Android, which are identical to qmake Android variables.
# Check http://doc.qt.io/qt-5/deployment-android.html for more information.
# They need to be set before the find_package(Qt5 ...) call.

#if(ANDROID)
#    set(ANDROID_PACKAGE_SOURCE_DIR "${CMAKE_CURRENT_SOURCE_DIR}/android")
#    if (ANDROID_ABI STREQUAL "armeabi-v7a")
#        set(ANDROID_EXTRA_LIBS
#            ${CMAKE_CURRENT_SOURCE_DIR}/path/to/libcrypto.so
#            ${CMAKE_CURRENT_SOURCE_DIR}/path/to/libssl.so)
#    endif()
#endif()

find_package(Qt5 COMPONENTS Core Quick LinguistTools QuickControls2 Widgets REQUIRED)
find_package(KF5IconThemes)

if (ANDROID)
    add_library(relaybaton-desktop SHARED
            main.cpp
            core.h
            config.h
            config.cpp
            qml.qrc
            )
elseif (APPLE)
    add_executable(relaybaton-desktop MACOSX_BUNDLE
            main.cpp
            core.h
            config.h
            config.cpp
            qml.qrc
            )
else ()
    add_executable(relaybaton-desktop
            main.cpp
            core.h
            config.h
            config.cpp
            qml.qrc
            )
endif ()

target_compile_definitions(relaybaton-desktop
        PRIVATE $<$<OR:$<CONFIG:Debug>,$<CONFIG:RelWithDebInfo>>:QT_QML_DEBUG>)
if (WIN32)
    set(CORE_FILE core.lib)
else ()
    set(CORE_FILE core.a)
endif ()

if (KF5IconThemes_FOUND)
    target_link_libraries(relaybaton-desktop
            PRIVATE Qt5::Core Qt5::Quick Qt5::Widgets Qt5::QuickControls2 ${CMAKE_DL_LIBS} ${CMAKE_SOURCE_DIR}/${CORE_FILE} KF5::IconThemes)
else ()
    target_link_libraries(relaybaton-desktop
            PRIVATE Qt5::Core Qt5::Quick Qt5::Widgets Qt5::QuickControls2 ${CMAKE_DL_LIBS} ${CMAKE_SOURCE_DIR}/${CORE_FILE})
endif ()

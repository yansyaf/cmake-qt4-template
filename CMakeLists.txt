#####################################################
## PROJECT SETTING 
#####################################################
CMAKE_MINIMUM_REQUIRED(VERSION 2.6)

IF(COMMAND cmake_policy)
      cmake_policy(SET CMP0003 NEW)
ENDIF(COMMAND cmake_policy)

PROJECT("MyQtApplication")

SET(CMAKE_BUILD_TYPE Release)

#####################################################
## ADD EXTERNAL LIBRARY (.dll/.so) 
#####################################################
FIND_PACKAGE(Qt4 REQUIRED)
#FIND_PACKAGE(Qt5 REQUIRED)

###############################################
## OUTPUT DIRECTORY SETUP
###############################################
SET (CMAKE_LIBRARY_OUTPUT_DIRECTORY
	${PROJECT_BINARY_DIR}/bin
	CACHE PATH
	"Single directory for all libraries"
	)
   
SET (CMAKE_RUNTIME_OUTPUT_DIRECTORY
	${PROJECT_BINARY_DIR}/bin
	CACHE PATH
	"Single directory for all executable and dll"
	)

SET (CMAKE_ARCHIVE_OUTPUT_DIRECTORY
	${PROJECT_BINARY_DIR}/lib
	CACHE PATH
	"Single directory for all static libraries"
	)

#####################################################
## CPP COMPILER
#####################################################
INCLUDE_DIRECTORIES( 
	${CMAKE_CURRENT_SOURCE_DIR}/src
)

INCLUDE_DIRECTORIES(
	${QT_INCLUDE_DIR}
)

ADD_DEFINITIONS(${QT_DEFINITIONS})

SET(MAIN_UI_SOURCES
	${CMAKE_CURRENT_SOURCE_DIR}/src/main.cpp
	${CMAKE_CURRENT_SOURCE_DIR}/src/mainui.cpp
)

SET(MAIN_UI_MOC_HDRS 
	${CMAKE_CURRENT_SOURCE_DIR}/src/mainui.h
)

INCLUDE(${QT_USE_FILE})

QT4_ADD_RESOURCES(MAIN_UI_RC_SRCS ${MAIN_UI_RC})
QT4_WRAP_CPP(MAIN_UI_MOC_SRCS ${MAIN_UI_MOC_HDRS} )

IF(WIN32)
ADD_EXECUTABLE(
	${PROJECT_NAME} 
	WIN32
	${MAIN_UI_SOURCES}
	${MAIN_UI_MOC_SRCS})
ELSE()
ADD_EXECUTABLE(
	${PROJECT_NAME} 
	${MAIN_UI_SOURCES}
	${MAIN_UI_MOC_SRCS})
ENDIF(WIN32)

TARGET_LINK_LIBRARIES(
	${PROJECT_NAME} 
	${QT_LIBRARIES}
	${QT_QTMAIN_LIBRARY}
)
	
SET_PROPERTY(TARGET ${PROJECT_NAME} PROPERTY WIN32_EXECUTABLE_DEBUG 0)

#####################################################
## PACKAGE 
#####################################################
SET(CPACK_PACKAGE_NAME ${PROJECT_NAME})
SET(CPACK_PACKAGE_VENDOR "MyQtApplication")
SET(CPACK_PACKAGE_EXECUTABLES ${PROJECT_NAME};MyQtApplication)

SET(CPACK_PACKAGE_INSTALL_REGISTRY_KEY "MyQtApplication 1.0.0")
SET(CPACK_PACKAGE_VERSION "1.0.0")
SET(CPACK_PACKAGE_VERSION_MAJOR "1")
SET(CPACK_PACKAGE_VERSION_MINOR "0")
SET(CPACK_PACKAGE_VERSION_PATCH "0")

IF(WIN32 AND NOT UNIX)
  SET(CPACK_NSIS_INSTALLED_ICON_NAME "bin\\\\MyQtApplication.exe")
  SET(CPACK_NSIS_DISPLAY_NAME "${CPACK_PACKAGE_INSTALL_DIRECTORY} MyQtApplication")
  SET(CPACK_NSIS_MODIFY_PATH ON)
ENDIF(WIN32 AND NOT UNIX)

INCLUDE(InstallRequiredSystemLibraries)

IF(UNIX AND NOT APPLE)
    INSTALL(TARGETS ${PROJECT_NAME}
        DESTINATION bin
    )

    FOREACH(LIB QtCore QtXml QtTest QtWebKit QtGui QtNetwork QtScript)
        INSTALL(FILES
            "${QT_LIBRARY_DIR}/lib${LIB}.so.${QT_VERSION_MAJOR}.${QT_VERSION_MINOR}.${QT_VERSION_PATCH}" 
            RENAME "lib${LIB}.so.${QT_VERSION_MAJOR}" 
            DESTINATION bin
        )
    ENDFOREACH(LIB)
ENDIF(UNIX AND NOT APPLE)

IF(WIN32)
    INSTALL(TARGETS ${PROJECT_NAME}
        DESTINATION bin
    )

    INSTALL(FILES
        "${QT_BINARY_DIR}/QtCore${QT_VERSION_MAJOR}.dll" 
        "${QT_BINARY_DIR}/QtXml${QT_VERSION_MAJOR}.dll" 
        "${QT_BINARY_DIR}/QtTest${QT_VERSION_MAJOR}.dll" 
        "${QT_BINARY_DIR}/QtWebKit${QT_VERSION_MAJOR}.dll" 
        "${QT_BINARY_DIR}/QtGui${QT_VERSION_MAJOR}.dll" 
        "${QT_BINARY_DIR}/QtNetwork${QT_VERSION_MAJOR}.dll" 
        "${QT_BINARY_DIR}/QtScript${QT_VERSION_MAJOR}.dll" 
        "${QT_BINARY_DIR}/QtSvg${QT_VERSION_MAJOR}.dll" 
        DESTINATION bin
    )
ENDIF(WIN32)

INCLUDE(CPack)
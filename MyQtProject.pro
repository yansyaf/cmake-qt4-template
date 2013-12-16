QT       += core gui

TARGET       = MyQtApplication
TEMPLATE     = app
UI_DIR       = .ui
MOC_DIR      = .moc
OBJECTS_DIR  = .obj
DESTDIR      =  $$PWD/bin

SOURCES      = src/main.cpp src/mainui.cpp
HEADERS      = src/mainui.h

INCLUDEPATH += $$PWD/src

TEMPLATE = lib
CONFIG += qt warn_on
QT -= gui

# The ABI version.
!win32:VERSION = 1.0.0

# 1.0.0 is the first stable ABI.
# The next binary incompatible change will be 2.0.0 and so on.
# The existing QuaZIP policy on changing ABI requires to bump the
# major version of QuaZIP itself as well. Note that there may be
# other reasons for chaging the major version of QuaZIP, so
# in case where there is a QuaZIP major version bump but no ABI change,
# the VERSION variable will stay the same.

# For example:

# QuaZIP 1.0 is released after some 0.x, keeping binary compatibility.
# VERSION stays 1.0.0.
# Then some binary incompatible change is introduced. QuaZIP goes up to
# 2.0, VERSION to 2.0.0.
# And so on.

win32 {

    QMAKE_EXT_OBJ = .obj
    CONFIG += windows
    CONFIG += debug_and_release	
greaterThan(QT_MAJOR_VERSION, 4): LIBS += -lz

}

CONFIG(debug, debug|release) {
        message("~~~ QUAZIP DEBUG build ~~~")
        DESTDIR = build/debug
        mac: TARGET = $$join(TARGET,,,_debug) 
        win32: TARGET = $$join(TARGET,,,d)
} else {
        message("~~~ QUAZIP RELEASE build ~~~")
        DESTDIR = build/release
}

OBJECTS_DIR = $$DESTDIR/.obj
MOC_DIR = $$DESTDIR/.moc

# You'll need to define this one manually if using a build system other
# than qmake or using QuaZIP sources directly in your project.
# Be sure to add CONFIG+=staticlib in Additional Arguments of qmake build steps
CONFIG(staticlib): DEFINES += QUAZIP_STATIC
staticlib {
    message("~~~ QUAZIP STATIC build ~~~")
    CONFIG += staticlib # this is needed if you create a static library
} else {
    # This one handles dllimport/dllexport directives.
    message("~~~ QUAZIP SHARED build ~~~")
    DEFINES += QUAZIP_BUILD
}

# Input
include(quazip.pri)
include(../LPub3DPlatformSpecific.pri)


unix:!symbian {
    headers.path=$$PREFIX/include/quazip
    headers.files=$$HEADERS
    target.path=$$PREFIX/lib/$${LIB_ARCH}
    INSTALLS += headers target

    OBJECTS_DIR=.obj
    MOC_DIR=.moc
	
}

win32 {
    headers.path=$$PREFIX/include/quazip
    headers.files=$$HEADERS
    target.path=$$PREFIX/lib
    INSTALLS += headers target
    # workaround for qdatetime.h macro bug
    DEFINES += NOMINMAX
}


symbian {

    # Note, on Symbian you may run into troubles with LGPL.
    # The point is, if your application uses some version of QuaZip,
    # and a newer binary compatible version of QuaZip is released, then
    # the users of your application must be able to relink it with the
    # new QuaZip version. For example, to take advantage of some QuaZip
    # bug fixes.

    # This is probably best achieved by building QuaZip as a static
    # library and providing linkable object files of your application,
    # so users can relink it.

    CONFIG += staticlib
    CONFIG += debug_and_release

    LIBS += -lezip

    #Export headers to SDK Epoc32/include directory
    exportheaders.sources = $$HEADERS
    exportheaders.path = quazip
    for(header, exportheaders.sources) {
        BLD_INF_RULES.prj_exports += "$$header $$exportheaders.path/$$basename(header)"
    }
}


import qbs

QtGuiApplication {
    name: "radeon-profile"

    Depends { name: 'Qt'; submodules: ['widgets', 'network', 'charts'] }

    property stringList commonDefines: ["QT_USE_QSTRINGBUILDER"]

    cpp.cxxLanguageVersion: "c++14"
    cpp.debugInformation: qbs.buildVariant == "debug" ? true : false
    cpp.defines: commonDefines.concat(qbs.buildVariant == "debug" ? 'DEBUG' : ['QT_NO_DEBUG_OUTPUT', 'QT_NO_DEBUG'])
    cpp.includePaths: [product.sourceDirectory]
    cpp.dynamicLibraries: ['Xrandr', 'X11']

    Group {
        name: 'Sources'
        files: ['*.cpp', 'components/*.cpp', 'dialogs/*.cpp']
    }
    Group {
        name: 'Includes'
        files: ['*.h', 'components/*.h', 'dialogs/*.h']
    }
    Group {
        name: 'Forms'
        files: ['*.ui', 'components/*.ui', 'dialogs/*.ui']
    }
    Group {
        name: 'Resources'
        files: '*.qrc'
    }

    Group {
        name: "App"
        fileTagsFilter: "application"
        qbs.install: qbs.buildVariant == "release" ? true : false
        qbs.installDir: "bin"
    }
 }

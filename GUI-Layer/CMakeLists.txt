add_library(GUILayer
    MainWindow.h
    MainWindow.cpp
    MainWindow.ui
)

target_include_directories(GUILayer
    PUBLIC
        ${CMAKE_CURRENT_SOURCE_DIR}
)

target_link_libraries(GUILayer
    PUBLIC
        Qt6::Widgets
        DataLayer
)
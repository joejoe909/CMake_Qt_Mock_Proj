add_executable(MyQtProject
    main.cpp
)

target_link_libraries(MyQtProject
    PRIVATE
        Qt6::Widgets
        GUILayer
        DataLayer
)
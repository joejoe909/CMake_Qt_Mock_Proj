add_library(DataLayer
    DataStore.h
    DataStore.cpp
)

target_include_directories(DataLayer
    PUBLIC
        ${CMAKE_CURRENT_SOURCE_DIR}
)

target_link_libraries(DataLayer
    PUBLIC
        Qt6::Widgets
)
cmake_minimum_required(VERSION 3.2)

project(sqlite3 VERSION 3.26.0 LANGUAGES C CXX)


# Cтандарт C++
set(CMAKE_CXX_STANDARD 11)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

set(SOURCES sqlite3.c shell.c)
add_library(sqlite3 SHARED ${SOURCES})

# Указываем необходимые флаги и библиотеки для компиляции
target_compile_definitions(sqlite3 PRIVATE SQLITE_ENABLE_FTS4 SQLITE_ENABLE_FTS5 SQLITE_ENABLE_JSON1 
SQLITE_ENABLE_RTREE SQLITE_ENABLE_EXPLAIN_COMMENTS)
target_link_libraries(sqlite3 dl m pthread)

# Создаем исполняемый файл для CLI
add_executable(sqlite3_cli shell.c sqlite3.c)
target_link_libraries(sqlite3_cli sqlite3 dl m pthread readline ncurses)

# Устанавливаем пути для включения заголовочных файлов
target_include_directories(
  sqlite3 PRIVATE
  $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}>
  INTERFACE
  $<INSTALL_INTERFACE:include>
)

# Устанавливаем конфигурационные файлы для пакета
include(CMakePackageConfigHelpers)
write_basic_package_version_file(
  ${CMAKE_CURRENT_BINARY_DIR}/sqlite3-config-version.cmake
  VERSION ${PROJECT_VERSION}
  COMPATIBILITY AnyNewerVersion
)

install(TARGETS sqlite3 EXPORT sqlite3
  RUNTIME DESTINATION bin
  ARCHIVE DESTINATION lib
  LIBRARY DESTINATION lib
)

install(FILES
  ${CMAKE_CURRENT_SOURCE_DIR}/sqlite3.h
  DESTINATION include
)

install(EXPORT sqlite3
  FILE
    sqlite3.cmake
  NAMESPACE
    sqlite3::
  DESTINATION
    lib/cmake/sqlite3
)

install(
  FILES
    ${CMAKE_CURRENT_BINARY_DIR}/sqlite3-config-version.cmake
  DESTINATION
    lib/cmake/sqlite3
)
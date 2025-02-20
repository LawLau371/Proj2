CXX := g++
CXXFLAGS := -std=c++17 -Wall -Wextra -Iinclude -lgtest -lgtest_main -pthread -lexpat
SRC_DIR := src
TEST_SRC_DIR := testsrc
BIN_DIR := bin
OBJ_DIR := obj

# Ensure directories exist
$(shell mkdir -p $(BIN_DIR) $(OBJ_DIR) string_utils driver)

# Source and object files
SRC_FILES := $(wildcard $(SRC_DIR)/*.cpp)
TEST_FILES := $(wildcard $(TEST_SRC_DIR)/*.cpp)
OBJ_FILES := $(patsubst $(SRC_DIR)/%.cpp, $(OBJ_DIR)/%.o, $(SRC_FILES))
TEST_OBJ_FILES := $(patsubst $(TEST_SRC_DIR)/%.cpp, $(OBJ_DIR)/%.o, $(TEST_FILES))

# Executables
TEST_EXEC_STRUTILS := ./string_utils/teststrutils.exe
TEST_EXEC_STRDATASINK := ./driver/teststrdatasink.exe
TEST_EXEC_STRDATASOURCE := ./driver/teststrdatasource.exe
TEST_EXEC_DSV := ./driver/testdsv.exe
TEST_EXEC_XML := ./driver/testxml.exe

all: teststrutils teststrdatasink teststrdatasource testdsv testxml

teststrutils: $(TEST_EXEC_STRUTILS)
teststrdatasink: $(TEST_EXEC_STRDATASINK)
teststrdatasource: $(TEST_EXEC_STRDATASOURCE)
testdsv: $(TEST_EXEC_DSV)
testxml: $(TEST_EXEC_XML)

$(TEST_EXEC_STRUTILS): $(OBJ_DIR)/StringUtils.o $(OBJ_DIR)/StringUtilsTest.o
	$(CXX) $(CXXFLAGS) $^ -o $@

$(TEST_EXEC_STRDATASINK): $(OBJ_DIR)/StringDataSink.o $(OBJ_DIR)/StringDataSinkTest.o
	$(CXX) $(CXXFLAGS) $^ -o $@

$(TEST_EXEC_STRDATASOURCE): $(OBJ_DIR)/StringDataSource.o $(OBJ_DIR)/StringDataSourceTest.o
	$(CXX) $(CXXFLAGS) $^ -o $@

$(TEST_EXEC_DSV): $(OBJ_DIR)/DSVReader.o $(OBJ_DIR)/DSVWriter.o $(OBJ_DIR)/DSVTest.o
	$(CXX) $(CXXFLAGS) $^ -o $@

$(TEST_EXEC_XML): $(OBJ_DIR)/XMLReader.o $(OBJ_DIR)/XMLWriter.o $(OBJ_DIR)/XMLTest.o
	$(CXX) $(CXXFLAGS) $^ -o $@

$(OBJ_DIR)/%.o: $(SRC_DIR)/%.cpp
	$(CXX) $(CXXFLAGS) -c $< -o $@

$(OBJ_DIR)/%.o: $(TEST_SRC_DIR)/%.cpp
	$(CXX) $(CXXFLAGS) -c $< -o $@

# run_tests: all
# 	./string_utils/teststrutils
# 	./driver/teststrdatasink
# 	./driver/teststrdatasource
# 	./driver/testdsv
# 	.driver/testxml

clean:
	rm -rf $(BUILD_DIR) $(BIN_DIR) $(OBJ_DIR) ./driver ./string_utils

.PHONY: all clean teststrutils teststrdatasink teststrdatasource testdsv testxml run_tests

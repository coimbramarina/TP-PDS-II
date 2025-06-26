# Compilador
CXX = g++
CXXFLAGS = -std=c++11 -Wall -Iinclude

# Diretórios
SRC_DIR = src
BIN_DIR = bin
TEST_DIR = tests

# Arquivos
SOURCES = $(wildcard $(SRC_DIR)/*.cpp)
OBJECTS = $(patsubst $(SRC_DIR)/%.cpp, $(BIN_DIR)/%.o, $(SOURCES))
EXECUTABLE = $(BIN_DIR)/twitter

# Testes
TEST_SOURCES = $(wildcard $(TEST_DIR)/*.cpp)
TEST_EXECUTABLE = $(BIN_DIR)/twitter_test

.PHONY: all clean run test

all: $(EXECUTABLE)

$(EXECUTABLE): $(OBJECTS)
	$(CXX) $(CXXFLAGS) $^ -o $@

$(BIN_DIR)/%.o: $(SRC_DIR)/%.cpp
	@mkdir -p $(BIN_DIR)
	$(CXX) $(CXXFLAGS) -c $< -o $@

run: $(EXECUTABLE)
	./$(EXECUTABLE)

test: $(TEST_EXECUTABLE)
	./$(TEST_EXECUTABLE)

$(TEST_EXECUTABLE): $(filter-out $(BIN_DIR)/main.o, $(OBJECTS)) $(TEST_SOURCES)
	$(CXX) $(CXXFLAGS) $^ -o $@

clean:
	rm -rf $(BIN_DIR)/*

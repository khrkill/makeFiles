# Project config
TARGET = testCppApp
SRCDIR = src
OBJDIR = obj
INCDIR = include

# Compiler and flags
CXX = g++
CSSFLAGS = -Wall -Wextra -std=c++17 -O2
LIBS = #can add libraries as I need them
INCLUDES = -I$(INCDIR)

# Source and object files
SOURCES = $(wildcard $(SRCDIR)/*.cpp)
OBJECTS = $(SOURCES:$(SRCDIR)/%.cpp=$(OBJDIR)/%.o)

#default
all: $(TARGET)

# Link target
$(TARGET): $(OBJECTS)
	$(CXX) $(OBJECTS) $(LIBS) -o $(TARGET)

# Compile source files
$(OBJDIR)/%.o: $(SRCDIR)/%.cpp | $(OBJDIR)
	$(CXX) $(CSSFLAGS) $(INCLUDES) -c $< -o $@

# Create object directory
$(OBJDIR):
	mkdir $(OBJDIR)

# Debug Makefile
debug_info:
	@echo "INCDIR   $(INCDIR)"
	@echo "SRCDIR   $(SRCDIR)"
	@echo "OBJDIR   $(OBJDIR)"
	@echo "INCLUDES $(INCLUDES)"
	@echo "SOURCES: $(SOURCES)"
	@echo "OBJECTS: $(OBJECTS)"
	@echo "TARGET:  $(TARGET)"

# Clean build fiiles
clean:
	rm -rf $(OBJDIR) $(TARGET)

# Rebuild everything
rebuild: clean all

# Debug build
debug: CXXFLAGS += -g -DDEBUG
debug: $(TARGET)

help:
	@echo "$(TARGET) - Build options"
	@echo ""
	@echo "Usage: make [Target]"
	@echo ""
	@echo "Targets:"
	@echo ""
	@echo " all        Build the project (default)"
	@echo " clean      Remove all the build files"
	@echo " debug      Build with debug (-g -DDEBUG)"
	@echo " rebuild    Clean then Build"
	@echo " debug_info Show build config"
	@echo " help       Show this help"

# Phony targets
.PHONY: all clean rebuild debug debug_info help


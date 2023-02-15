# Based on https://gist.github.com/samuelsmal/e43f2001cfc81fee18b6
#
# Requires the following project directory structure:
#  /bin
#  /obj
#  /src

# Use 'make remove' to clean up the hole project

# Name of target file
TARGET     = main

# CXX        = clang++
CXX        = nvcc

CXXFLAGS   = -std=c++20 \
             -I/usr/local/cuda/include

LD         = nvcc -o
LDFLAGS    =

SRCDIR     = src
OBJDIR     = obj
BINDIR     = bin

SOURCES   := $(wildcard $(SRCDIR)/*.cu)
INCLUDES  := $(wildcard $(SRCDIR)/*.h)
OBJECTS   := $(SOURCES:$(SRCDIR)/%.cu=$(OBJDIR)/%.o)

RM         = rm -f

$(BINDIR)/$(TARGET): $(OBJECTS)
	$(LD) $@ $(LDFLAGS) $(OBJECTS)
	@echo "Linking complete!"

$(OBJECTS): $(OBJDIR)/%.o : $(SRCDIR)/%.cu
	$(CXX) $(CXXFLAGS) -c $< -o $@
	@echo "Compiled "$<" successfully!"

.PHONY: clean
clean:
	$(RM) $(OBJECTS)
	$(RM) $(BINDIR)/$(TARGET)
	@echo "Cleanup complete!"

.PHONY: run
run:
	@$(BINDIR)/$(TARGET)

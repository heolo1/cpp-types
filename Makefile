CXX=g++
CXXFLAGS=-g -pedantic -std=c++20
BF=build/
SF=src/
SRC=$(patsubst ./$(SF)%.cpp,%,$(shell find . -name "*.cpp"))

define ADD_DEPENDENCY
-include $(BF)$1.d
$(BF)$1.o: $(SF)$1.cpp
	$(CXX) $(CXXFLAGS) -c -MMD -MF $${@:%.d=%.o} -o $$@ $$<
endef

$(foreach NAME,$(SRC),$(eval $(call ADD_DEPENDENCY,$(NAME))))

all: main

main: ${SRC:%=$(BF)%.o}
	$(CXX) $(CXXFLAGS) ${SRC:%=$(BF)%.o} -o main

.PHONY: clean run

clean:
	- find . | perl -nle "print if /\.(o|d)\W/ and not /\/\./" | xargs rm

run: main
	@ ./main
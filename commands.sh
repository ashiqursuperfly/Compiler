echo 'Parsing ...'
bison -d -y 1605103.y
echo 'Compiling Parser Generated Files ...'
cp y.tab.c out/ 
cp y.tab.h out/
rm y.tab.c
rm y.tab.h 
g++ -w -c -o out/y.o out/y.tab.c
echo 'Scanning ...' 
flex 1605103.l
echo 'Compiling Scanner Generated Files ...'
cp lex.yy.c out/
rm lex.yy.c 
g++ -w -c -o out/l.o out/lex.yy.c
# if the above command doesn't work try g++ -fpermissive -w -c -o l.o lex.yy.c
echo 'Linking Scanner and Parser Files ...'
g++ -o out/a.out out/y.o out/l.o -ly
echo 'Generating Assembly Code ...'
#./a.out 'tests/code_generation/if_else_loops.c' 'tests/code_generation/function_call.c' 'tests/code_generation/arrays.c' 'tests/code_generation/func.c' 'tests/code_generation/exp.c' 'tests/code_generation/loop.c'
./out/a.out 'tests/syntax_analyser/input0.c'

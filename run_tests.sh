sh bin/base.sh
echo 'Running Syntax Analysis Tests...'
./out/a.out 'tests/syntax_analyser/input0.c' 'tests/syntax_analyser/input1.c' 'tests/syntax_analyser/input2.c' 'tests/syntax_analyser/input3.c' 'tests/syntax_analyser/input4.c' 'tests/syntax_analyser/input5.c'
echo 'Running Code Generation Tests ...'
./out/a.out 'tests/code_generation/if_else_loops.c' 'tests/code_generation/function_call.c' 'tests/code_generation/arrays.c' 'tests/code_generation/func.c' 'tests/code_generation/exp.c' 'tests/code_generation/loop.c'

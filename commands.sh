echo 'enter C filename (inside input folder)'
read filename
cd base
bash base.sh
echo '::---->Generating Assembly Code ...'
cd ..
# ./out/a.out 'input/input.c'
./out/a.out "input/$filename"

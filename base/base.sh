echo '::---->Installing Flex & Bison'
sudo apt-get install flex bison
echo '::---->Installed Flex & Bison'
which flex
which bison
echo '::---->Parsing ...'
bison -d -y 1605103.y
echo '::---->Compiling Parser Generated Files ...'
cp y.tab.c ../out/ 
cp y.tab.h ../out/
rm y.tab.c
rm y.tab.h 
g++ -w -c -o ../out/y.o ../out/y.tab.c
echo '::---->Scanning ...' 
flex 1605103.l
echo '::---->Compiling Scanner Generated Files ...'
cp lex.yy.c ../out/
rm lex.yy.c 
g++ -w -c -o ../out/l.o ../out/lex.yy.c
# if the above command doesn't work try g++ -fpermissive -w -c -o l.o lex.yy.c
echo '::---->Linking Scanner and Parser Files ...'
g++ -o ../out/a.out ../out/y.o ../out/l.o -ly
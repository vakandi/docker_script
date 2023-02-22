mkdir libft
rm -rf libft/* && cp *.c libft.h Makefile libft && rm -rf libft-unit-test && rm -rf libft-war-machine

rm -rf libftTester
git clone https://github.com/alelievr/libft-unit-test.git
cd libft-unit-test
make && ./run_test
cd ..
git clone https://github.com/y3ll0w42/libft-war-machine.git
cd libft-war-machine
./grademe.sh 
cat my_config.sh | grep "PATH_LIBFT"
#echo $(cat my_config.sh | perl -p -e 's#PATH_LIBFT="../"#PATH_LIBFT="../libft"#') > my_config.sh
perl -i.bkp -pe 's#PATH_LIBFT="../"#PATH_LIBFT="../libft"#' my_config.sh
echo "Path of Libft has been changed ...\n\n\n"
./grademe.sh
cd .. && git clone https://github.com/Tripouille/libftTester.git && cd libftTester
make

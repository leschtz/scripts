export amount_file=$(ls | sed -e s/[^0-9]//g | wc -l)
export pre=$(printf %02d $amount_file)

if [ -z $1 ]; then
	echo "Enter a Coursename!"
	exit 1
fi

if [ ! $(find . -type d -name "*-$1") ]; then
	mkdir $pre-$1
	cd $pre-$1
	mkdir exam presentations
fi

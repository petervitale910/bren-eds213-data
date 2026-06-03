Be sure to cd to the class data GitHub repository, for_bash_essentials subdirectory, before answering these!!

1. Compare the output of these three commands:

ls
ls .
ls "$(pwd)/../for_bash_essentials"

Explain why you see what you see, and explain what processing Bash is doing in the third command.

All three of these output the same things in this context. Ls gives you everything in the directory, where the `.` makes it explicit to look at the current directory. Even more explicitly `$(pwd)/../for_bash_essentials` goes out of this directory and then back into it. This would work with other directories as well such as the `database directory`

2. Try the following two commands:

wc -l *.csv
cat *.csv | wc -l

The first prints filenames and line counts. The second prints a bare number. Why does it print that number, and why does it not print any filenames?

cat cocatinates all the csv files together and then counts the lines. You lose the filenames in this 


3. You want to count the total number of lines in all CSV files and try this command:

cat *.csv | wc -l a.csv

What happens and why?

It only outputs the length of `a.csv`. This is because you specify that you want the `wc -l` to be performed along `a.csv`. Essentially it ignores the pipe. 

4. You’re given

name=Moe

and you’d like to print “Moe_Howard”. You try this:

echo "$name_Howard"

but that doesn’t quite work. What fix can you apply to $name, while keeping it inside the quotation marks, to make this command give the desired effect? (Refer back to section 3.)

It doesnt work because it is ambiguous. I got it working with ${name}_howard.

5. You create a script and run it like so:

bash myscript.sh *.csv

What are the values of variables $1 and $#? Explain why the script does not see just one argument passed to it.

$1 is the first csv file while $# is the total number of csv's present. The *.csv command is expanded to all the csv's so it doesn't just see one file. 

6. You create a script and run it like so:

bash myscript.sh "$(date)" $(date)

In your script, what are the values of variables $1 and $3?

The value of $1 is the entire date and $3 is the second value of the date (may). This is because $3 is the absolute third value of the quoted date (the whole string) and then the date, making it may (the second value in $(date))


7. Create a file you don’t care about (because you’re about to destroy it):

echo "yo ho a line of text" > junk_file.txt
echo "another line" >> junk_file.txt

You want to sort the lines in this file, so you try:

sort junk_file.txt

Well that prints the lines in sorted order, but it doesn’t actually change the file. You recall section 7 and try:

sort junk_file.txt > junk_file.txt

What happens and why? How can you sort the lines in your file? (Hint: it involves creating a second file and using mv.)

The file is empty :(. This is because when we > junk_file.txt it becomes empty to get it ready to write things into it. To do it correctly you:

sort junk_file.txt > sorted_tmp.txt
mv sorted_tmp.txt junk_file.txt

8. You want to delete all files ending in .csv, so you type (don’t actually try this):

rm * .csv

but as can be seen, your thumb accidentally hit the space bar and you got an extra space in there. What will rm do in this case?

This will remove everything in your current directory. (Honestly tempted to run it and then git restore) 
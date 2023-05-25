CPATH='.:lib/hamcrest-core-1.3.jar:lib/junit-4.13.2.jar'

rm -rf student-submission
rm -rf grading-area
# removing recursively, to start from scratch

mkdir grading-area
#making a new directory
git clone $1 student-submission
echo 'Finished cloning'



if [[ -e student-submission/ListExamples.java ]]
then 
    echo 'File found'
else
    echo 'File not found'
    echo 'Score 0/4'
    exit 1
fi

cp -r lib grading-area
cp TestListExamples.java grading-area 
cd student-submission
cp ListExamples.java ../grading-area
cd ../grading-area

javac -cp .:lib/hamcrest-core-1.3.jar:lib/junit-4.13.2.jar *.java 2> error.txt
if [[  $? -ne 0 ]]
then 
    echo 'Not compiled'
    echo 'Score 0/4'
    exit 1
fi

java -cp .:lib/hamcrest-core-1.3.jar:lib/junit-4.13.2.jar org.junit.runner.JUnitCore TestListExamples >testout.txt 2>&1
if [[ $(grep "OK" testout.txt) ]]
then 
    echo 'Passed'
else
    echo 'Failed'
fi


# Draw a picture/take notes on the directory structure that's set up after
# getting to this point

# Then, add here code to compile and run, and do any post-processing of the
# tests
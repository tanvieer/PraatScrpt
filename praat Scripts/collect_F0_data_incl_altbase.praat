#
# This script is distributed under the GNU General Public License.
#
# by Jonas Lindh, 2005-2006
#
#########################################################################

form Analyze pitch in files
	comment Directory of sound files
	text sound_directory C:\Users\Tanvir\Desktop\dataset\All Clean Data Infant Cry\Mixed\
	sentence Sound_file_extension .wav
	comment Full path of the resulting text file:
	text resultfile C:\Users\Tanvir\Desktop\downloadedscript.txt
	comment Pitch analysis parameters
	positive Time_step 0.01
	positive Minimum_pitch_(Hz) 70
	positive Maximum_pitch_(Hz) 400
endform

# Here, you make a listing of all the sound files in a directory.

Create Strings as file list... list 'sound_directory$'*'sound_file_extension$'
numberOfFiles = Get number of strings


writeInfoLine: "NUMBER OF FILES = ", numberOfFiles

#writeInfoLine: "DIR = ", sound_directory



# Check if the result file exists:
if fileReadable (resultfile$)
	pause The resultfile 'resultfile$' already exists! Overwrite?
	filedelete 'resultfile$'
endif

# Write a row with column titles to the result file:
# (remember to edit this if you add or change the analyses!)

titleline$ = "Filename'tab$'Min'tab$'Max'tab$'Mean'tab$'Median'tab$'Std'tab$'Base'tab$'Alt_base'tab$'Dur'tab$'F0_points'newline$'"
fileappend "'resultfile$'" 'titleline$'



# Go through all the sound files, one by one:

for ifile to numberOfFiles
	filename$ = Get string... ifile
	# A sound file is opened...
	Read from file... 'sound_directory$''filename$'
	# Starting from here, you can add everything that should be repeated...
	soundname$ = selected$ ("Sound", 1)
	dur = Get total duration
	To Pitch... time_step minimum_pitch maximum_pitch
	max = Get maximum... 0 0 Hertz None
	min = Get minimum... 0 0 Hertz None
	mean = Get mean... 0 0 Hertz
	median = Get quantile... 0 0 0.5 Hertz
	stdev = Get standard deviation... 0 0 Hertz
	altqb = Get quantile... 0 0 0.0764 Hertz
	baseline = mean - (1.43 * stdev)
	To PointProcess
	points = Get number of points
	Remove

	# Save result to the text file you chose...
	resultline$ = "'soundname$''tab$''min:2''tab$''max:2''tab$''mean:2''tab$''median:2''tab$''stdev:2''tab$''baseline:2''tab$''altqb:2''tab$''dur:2''tab$''points''newline$'"
	fileappend "'resultfile$'" 'resultline$'

	# Remove the temp objects from the object's list
	select Sound 'soundname$'
	plus Pitch 'soundname$'
	Remove
	select Strings list
	# continue with next sound file...
endfor
Remove
#######################

form Process files...
  #sentence Path C:\Users\Tanvir\Desktop\Infant\Datasets\baby emotion\HungerInfantClean
  #sentence Path C:\Users\Tanvir\Desktop\Infant\donateacry-corpus-master\test

	#sentence Path C:\Users\Tanvir\Desktop\dataset\All Clean Data Infant Cry\Dont know\dkInfantClean
	#sentence Path C:\Users\Tanvir\Desktop\dataset\All Clean Data Infant Cry\Hunger\HungerInfantClean
	#sentence Path C:\Users\Tanvir\Desktop\dataset\All Clean Data Infant Cry\Mixed
	sentence Path C:\Users\Tanvir\Desktop\dataset\All Clean Data Infant Cry\Not Hunger\NhuInfantClean
endform

#Optional: make sure the path has a trailing slash
path$ = if right$(path$) = "/" then path$ else path$ + "/" fi

output = Create Table with column names: "output", 0,
  ... "fileName pitch_med pitch_mean pitch_SD pitch_max pitch_min jitter_local jitter_local_abs jitter_rap jitter_ppq5 jitter_ddp shimmer_local shimmer_local_dB shimmer_apq3 shimmer_apq5 shimmer_apq11 shimmer_dda voicing_fractunvoicedframes voicing_numbreaks voicing_degbreaks gender age class"

files = Create Strings as file list: "files", path$ + "*wav"
total_files = Get number of strings
for i to total_files
  selectObject: files
  filename$ = Get string: i
  sound = Read from file: path$ + filename$

  # Run whatever kind of analysis you want here
  # For example, get the mean pitch for each file


filename$ = left$ (filename$, length(filename$)-4)


class$ = right$ (filename$, 2)

filename$ = left$ (filename$,length(filename$)-3)

age$ = right$ (filename$, 2)

filename$ = left$ (filename$,length(filename$)-3)

gender$ = right$ (filename$, 1)

filename$ = left$ (filename$,length(filename$)-6)

#recordedTime$ = right$ (filename$, 13)

#filename$ = left$ (filename$,length(filename$)-14)



#writeInfoLine: "Name = ", gender$
  

  pitch = To Pitch: 0, 10, 800

  

    tmin = 0
    tmax = 0
    #mean = Get mean: tmin, tmax, "Hertz"
    #minimum = Get minimum: tmin, tmax, "Hertz", "Parabolic"
    #maximum = Get maximum: tmin, tmax, "Hertz", "Parabolic"
    #stdev = Get standard deviation: tmin, tmax, "Hertz"

	selectObject: sound, pitch
	pulses = To PointProcess (cc)

	selectObject: sound, pulses, pitch
  voiceReport$ = Voice report: tmin, tmax, 10, 800, 1.3, 1.6, 0.03, 0.45


  #jitter = extractNumber (voiceReport$, "Jitter (local): ");
  #shimmer = extractNumber (voiceReport$, "Shimmer (local): ");


  pitch_med = extractNumber(voiceReport$, "Median pitch: ")	
  pitch_mean = extractNumber(voiceReport$, "Mean pitch: ")
  pitch_SD = extractNumber(voiceReport$, "Standard deviation: ")
  pitch_max = extractNumber(voiceReport$, "Maximum pitch: ")						
  pitch_min = extractNumber(voiceReport$, "Minimum pitch: ")
  jitter_local = extractNumber(voiceReport$, "Jitter (local): ")
  jitter_local_abs = extractNumber(voiceReport$, "Jitter (local, absolute): ")
  jitter_rap = extractNumber(voiceReport$, "Jitter (rap): ")
  jitter_ppq5 = extractNumber(voiceReport$, "Jitter (ppq5): ")
  jitter_ddp = extractNumber(voiceReport$, "Jitter (ddp): ")
  shimmer_local = extractNumber(voiceReport$, "Shimmer (local): ")
  shimmer_local_dB = extractNumber(voiceReport$, "Shimmer (local, dB): ")
  shimmer_apq3 = extractNumber(voiceReport$, "Shimmer (apq3): ")
  shimmer_apq5 = extractNumber(voiceReport$, "Shimmer (apq5): ")
  shimmer_apq11 = extractNumber(voiceReport$, "Shimmer (apq11): ")
  shimmer_dda = extractNumber(voiceReport$, "Shimmer (dda): ")
  voicing_fractunvoicedframes = extractNumber(voiceReport$, "Fraction of locally unvoiced frames: ")
  voicing_numbreaks = extractNumber(voiceReport$, "Number of voice breaks: ")
  voicing_degbreaks = extractNumber(voiceReport$, "Degree of voice breaks: ")






#writeInfoLine: "Jitter = ", percent$ (jitter, 3), ", shimmer = ", percent$ (shimmer, 3);


  selectObject: output
  Append row
  row = Get number of rows
  Set string value: row, "fileName", filename$
  Set numeric value: row, "pitch_med", pitch_med
  Set numeric value: row, "pitch_mean", pitch_mean
  Set numeric value: row, "pitch_SD", pitch_SD
  Set numeric value: row, "pitch_max", pitch_max
  Set numeric value: row, "pitch_min", pitch_min


  #Set string value: row, "jitter_local", percent$(jitter_local,3)
  #Set string value: row, "jitter_local_abs", percent$(jitter_local_abs,3)
  #Set string value: row, "jitter_rap",  percent$(jitter_rap,3)
  #Set string value: row, "jitter_ppq5", percent$(jitter_ppq5 ,3)
  #Set string value: row, "jitter_ddp", percent$(jitter_ddp,3)
  #Set string value: row, "shimmer_local",percent$(shimmer_local,3)
  #Set string value: row, "shimmer_local_dB",  percent$(shimmer_local_dB,3)
  #Set string value: row, "shimmer_apq3",  percent$(shimmer_apq3,3)
  #Set string value: row, "shimmer_apq5", percent$(shimmer_apq5 ,3)
  #Set string value: row, "shimmer_apq11", percent$(shimmer_apq11 ,3)
  #Set string value: row, "shimmer_dda", percent$(shimmer_dda,3)



  Set numeric value: row, "jitter_local", jitter_local*100
  Set numeric value: row, "jitter_local_abs", jitter_local_abs*100
  Set numeric value: row, "jitter_rap",  jitter_rap*100
  Set numeric value: row, "jitter_ppq5", jitter_ppq5*100
  Set numeric value: row, "jitter_ddp", jitter_ddp*100
  Set numeric value: row, "shimmer_local", shimmer_local*100
  Set numeric value: row, "shimmer_local_dB", shimmer_local_dB * 100
  Set numeric value: row, "shimmer_apq3", shimmer_apq3*100
  Set numeric value: row, "shimmer_apq5", shimmer_apq5*100
  Set numeric value: row, "shimmer_apq11", shimmer_apq11*100
  Set numeric value: row, "shimmer_dda", shimmer_dda*100


  Set numeric value: row, "voicing_fractunvoicedframes", voicing_fractunvoicedframes
  Set numeric value: row, "voicing_numbreaks", voicing_numbreaks
  Set numeric value: row, "voicing_degbreaks", voicing_degbreaks
  #Set string value: row, "recordedTime", recordedTime$
  Set string value: row, "age", age$
  Set string value: row, "gender", gender$
  Set string value: row, "class", class$






  removeObject: sound, pitch, pulses
endfor

selectObject: output
#Save as comma-separated file: "C:\Users\Tanvir\Desktop\dataset\All Clean Data Infant Cry\DontKnow.csv"
#Save as comma-separated file: "C:\Users\Tanvir\Desktop\dataset\All Clean Data Infant Cry\Hunger.csv"
#Save as comma-separated file: "C:\Users\Tanvir\Desktop\dataset\All Clean Data Infant Cry\Mixed.csv"
Save as comma-separated file: "C:\Users\Tanvir\Desktop\dataset\All Clean Data Infant Cry\NotHunger.csv"

removeObject: files, output

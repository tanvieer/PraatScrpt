#########################################################################################
#											#
#	Voxalys a Plug-in for Praat (www.praat.org) for more information see		#
#	http://www.voxalys.se								#
#	Copyright (C) 2007  Jonas Lindh							#	
#											#
#	This program is free software; you can redistribute it and/or			#
#	modify it under the terms of the GNU General Public License			#
#	as published by the Free Software Foundation; either version 2			#
#	of the License, or (at your option) any later version.				#
#											#
#	This program is distributed in the hope that it will be useful,			#
#	but WITHOUT ANY WARRANTY; without even the implied warranty of			#
#	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the			#
#	GNU General Public License for more details.					#
#											#
#	You should have received a copy of the GNU General Public License		#
#	along with this program; if not, write to the Free Software			#
#	Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.	#
#											#
#########################################################################################
first_name$ = selected$("Sound")
string$ = "silent"

# delimit and mark silence intervals
To TextGrid (silences)... 50 0 -25 0.1 0.1 silent sounding

temp_label$ = Get label of interval... 1 1

if temp_label$ = string$
	Set interval text... 1 1 temp
endif

plus Sound 'first_name$'
#plus TextGrid 'first_name$'

# extract voiced intervals into one Sound object per interval and concatenate
# these Sound object into one Sound object

Extract all intervals... 1 no
name$ = selected$ ("Sound")
bottom_name$ = selected$ ("Sound", -1)

numberOfSelectedSounds = numberOfSelected ("Sound") + 1

if bottom_name$ = string$
minus Sound 'bottom_name$'
endif

if name$ = "temp"
minus Sound 'name$'
endif

Concatenate

select all

#bort_fil$ = selected$ ("Sound", -2)

for i from 2 to 'numberOfSelectedSounds'
sound'i' = selected ("Sound", -i)
endfor

for i from 2 to 'numberOfSelectedSounds'
	select sound'i'
	Remove
endfor

select Sound 'first_name$'
plus TextGrid 'first_name$'
	Remove

select Sound chain
Rename... 'first_name$'

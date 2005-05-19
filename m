From: jon@jonrkc.com (Jon Rutherford)
Date: Thu, 19 May 2005 06:25:24 +0000
Subject: Ticket no. 1817
Message-Id: <41A4C939.8050404@jonrkc.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Here is the output of sensors:

root@bodhisattva jon]# sensors
via686a-isa-6000
Adapter: ISA adapter
2.0V:      +1.69 V  (min =  +0.33 V, max =  +1.51 V)   ALARM
2.5V:      +2.51 V  (min =  +2.33 V, max =  +3.00 V)
3.3V:      +3.31 V  (min =  +4.01 V, max =  +2.56 V)   ALARM
5.0V:      +5.13 V  (min =  +2.85 V, max =  +1.76 V)   ALARM
12V:      +12.06 V  (min = +15.36 V, max = +11.59 V)   ALARM
fan1:     3000 RPM  (min = 2667 RPM, div = 2)
fan2:        0 RPM  (min = 3260 RPM, div = 2)
temp1:     +28.6?C  (high =   +47?C, hyst =   +21?C)
temp2:     +26.6?C  (high =   +41?C, hyst =  +101?C)
temp3:     +22.6?C  (high =   +48?C, hyst =   +70?C)
-------------------------------------------------------------------------------------------
I got the above sensors data after running sensors -s and 
then running
sensors twice separated by at least five seconds, as 
recommended in the
service response to another ticket with a similar problem 
reported.


And here is the via686 section of /etc/sensors.conf.



chip "via686a-*"

# VIA is very specific about the voltage sensor inputs, and 
our labels
# reflect what they say.  Unfortunately, they are not at all 
specific about
# how to convert any of the register values to real units. 
Fortunately,
# Jonathan Yew <j.teh@iname.com> and Alex van Kaam 
<darkside@chello.nl>
# came through with some data for temp conversion and 
formulae for voltage
# conversion. However, the conversions should be regarded as 
our best guess-
# YMMV.

# On the Tyan S1598, the 2.5V sensor reads 0 and is not 
displayed in the BIOS.
# Linas Vepstas <linas@linas.org> reports that this sensor 
shows nothing of
# interest on the Abit KA7 (Athlon), and is also not 
displayed in the BIOS.
# Likewise, Johannes Drechsel-Burkhard <jdb@chello.at> 
reports that this
# sensor is unavailable in the BIOS of his MSI K7T Pro 
(Thunderbird).  So,
# if you have one of these boards you may want to uncomment 
the 'ignore 2.5V'
# line below.

     label "2.0V" "CPU core"
     label "2.5V" "+2.5V"
     #ignore "2.5V"
     label "3.3V" "I/O"
     label "5.0V" "+5V"
     label "12V" "+12V"

     label fan1  "CPU Fan"
     label fan2  "P/S Fan"

# VIA suggests that temp3 is an internal temp sensor for the 
686a.  However,
# on the Tyan S1598 as well as the Abit KA7 (Athalon), the 
absolute values
# of the readings from that sensor are not valid.  The 
readings do seem to
# correlate with temp changes, but the conversion factor may 
be quite
# different from temp1 & temp2 (as noted above, VIA has not 
provided
# conversion info).  So, you may wish to 'ignore temp3'.

# Johannes Drechsel-Burkhard <jdb@chello.at> notes that on 
his MSI K7T Pro,
# temp1 is the CPU temp and temp2 is the SYS temp. Hugo van 
der Merwe notes
# the same for his Gigabyte GA-7DXC, and Olivier Martin for 
his Gigabyte
# GA-7ZM.

     label temp1 "CPU Temp"
     label temp2 "SYS Temp"
     label temp3 "SBr Temp"
     #ignore temp3

# Set your CPU core limits here.  For the other voltage 
sensors, the
# built-in defaults should be fine.

     set in0_min 2.0
     set in0_max 2.5

# Set your temp limits here.  Remember, 'tempX_over' is the 
temp at which an
# alarm is triggered, and 'tempX_hyst' is the temp at which 
an alarm turns off.
# Setting tempX_hyst to a few degrees below the 
corresponding tempX_over
# prevents an oscillation between alarm on and off states. 
This kind of
# oscillation is known as hyteresis, thus the name.  (You 
typically get the
# most serious and troublesome hysteresis when a sensor 
triggers something to
# reduce the temp, thus creating a negative feedback loop. 
Even without that,
# we would still get some oscillation when the temp hovers 
around the limit
# due to noise.)

     set temp1_hyst 40
     set temp1_over 45
     set temp2_hyst 55
     set temp2_over 60
     set temp3_hyst 60
     set temp3_over 65

# You could set your fan limits too, but the defaults should 
be fine.
chip "via686a-*"

# VIA is very specific about the voltage sensor inputs, and 
our labels
# reflect what they say.  Unfortunately, they are not at all 
specific about
# how to convert any of the register values to real units. 
Fortunately,
# Jonathan Yew <j.teh@iname.com> and Alex van Kaam 
<darkside@chello.nl>
# came through with some data for temp conversion and 
formulae for voltage
# conversion. However, the conversions should be regarded as 
our best guess-
# YMMV.

# On the Tyan S1598, the 2.5V sensor reads 0 and is not 
displayed in the BIOS.
# Linas Vepstas <linas@linas.org> reports that this sensor 
shows nothing of
# interest on the Abit KA7 (Athlon), and is also not 
displayed in the BIOS.
# Likewise, Johannes Drechsel-Burkhard <jdb@chello.at> 
reports that this
# sensor is unavailable in the BIOS of his MSI K7T Pro 
(Thunderbird).  So,
# if you have one of these boards you may want to uncomment 
the 'ignore 2.5V'
# line below.

     label "2.0V" "CPU core"
     label "2.5V" "+2.5V"
     #ignore "2.5V"
     label "3.3V" "I/O"
     label "5.0V" "+5V"
     label "12V" "+12V"

     label fan1  "CPU Fan"
     label fan2  "P/S Fan"

# VIA suggests that temp3 is an internal temp sensor for the 
686a.  However,
# on the Tyan S1598 as well as the Abit KA7 (Athalon), the 
absolute values
# of the readings from that sensor are not valid.  The 
readings do seem to
# correlate with temp changes, but the conversion factor may 
be quite
# different from temp1 & temp2 (as noted above, VIA has not 
provided
# conversion info).  So, you may wish to 'ignore temp3'.

# Johannes Drechsel-Burkhard <jdb@chello.at> notes that on 
his MSI K7T Pro,
# temp1 is the CPU temp and temp2 is the SYS temp. Hugo van 
der Merwe notes
# the same for his Gigabyte GA-7DXC, and Olivier Martin for 
his Gigabyte
# GA-7ZM.

     label temp1 "CPU Temp"
     label temp2 "SYS Temp"
     label temp3 "SBr Temp"
     #ignore temp3

# Set your CPU core limits here.  For the other voltage 
sensors, the
# built-in defaults should be fine.

     set in0_min 2.0
     set in0_max 2.5

# Set your temp limits here.  Remember, 'tempX_over' is the 
temp at which an
# alarm is triggered, and 'tempX_hyst' is the temp at which 
an alarm turns off.
# Setting tempX_hyst to a few degrees below the 
corresponding tempX_over
# prevents an oscillation between alarm on and off states. 
This kind of
# oscillation is known as hyteresis, thus the name.  (You 
typically get the
# most serious and troublesome hysteresis when a sensor 
triggers something to
# reduce the temp, thus creating a negative feedback loop. 
Even without that,
# we would still get some oscillation when the temp hovers 
around the limit
# due to noise.)

     set temp1_hyst 40
     set temp1_over 45
     set temp2_hyst 55
     set temp2_over 60
     set temp3_hyst 60
     set temp3_over 65

# You could set your fan limits too, but the defaults should 
be fine.

     #set fan1_min 5000
     #set fan2_min 5000

     #set fan1_min 5000
     #set fan2_min 5000

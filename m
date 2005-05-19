From: w.newell@verizon.net (Wes Newell)
Date: Thu, 19 May 2005 06:25:06 +0000
Subject: Temps on S755MAX IT8705F
Message-Id: <40F8D579.6020401@verizon.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <40F5A42D.9070301@verizon.net>
In-Reply-To: <40F5A42D.9070301@verizon.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean Delvare wrote:

>>Well, I tried  to install the 2.8.7 with make user and make
>>user_install and it hosed up and to top that My new drive is about
>>dead. Already got an rma for it, so I may have to put this on the back
>>burner for a little while. It's taking 10-20 minutes to boot every
>>time with fsck running every time on several partitions.
>>    
>>
>
>Iirk :( That's no good news for certain. What brand/model is it?
>  
>

WD1200JB

>Ah. I completely missed the fact that you could be using a 2.6 kernel.
>2.6.2 or 2.6.3 from Mandrake I guess? The trick is that in early 2.6 we
>changed the interface, so each kernel needs a specific version of
>lm_sensors. With lm_sensors 2.8.7 you'll need a 2.6.5-rc1 or later
>kernel.
>
>  
>
Then this will definately have to wait til I get a new drive tomorrow I 
hope. I've never installed a raw kernel before, but I don't think 
Mnadrake has any beyond 2.6.3. Any thing special I should know, or just 
do it.:-)

>>     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
>>00: 11 06 67 00 00 00 00 00 00 00 00 09 00 c7 ff ff
>>10: e1 e1 e1 70 00 00 00 00 00 00 00 00 00 00 00 00
>>20: 5d 5f cb b9 b8 c6 46 bb c5 46 6c 17 00 00 00 00
>>30: 75 60 ac 8d 71 5d cc a8 d8 b2 72 5e 3d 33 cc a8
>>40: 3c 14 3c 14 3c 14 00 00 2d 00 00 00 00 00 00 00
>>50: ff 2a 7f 7f 7f 00 00 00 90 56 02 00 00 00 00 00
>>    
>>
>         ^^
>Sensor types. 0x2A means temp2 is a diode while temp1 and temp3 are
>thermistors. Not quite what you tried to do, is it?
>
>  
>
Well, this was run after I tried installing 2.8.7 so I was pretty sure 
it was screwed up. Here's a dump using the 2.8.4 and sensors set to CPU 
1=diode, MB 2=thermistor, and unused 3=thermistor. And the output of 
sensors.

     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00: 11 06 00 00 00 00 00 00 00 00 00 09 00 c7 ff ff
10: e1 fe e1 70 00 00 00 00 00 00 00 00 00 00 00 00
20: 5d 5f cb ba b8 c6 46 bb c5 46 1b 23 00 00 00 00
30: 77 51 77 51 d8 c4 c3 b0 c5 b2 d9 bc 4c 42 c3 b0
40: 69 37 2d 19 3c 0f 00 00 2d 00 00 00 00 00 00 00
50: ff 30 7f 7f 7f 00 00 00 90 56 02 00 00 00 00 00
60: 7f 7f 7f 7f 7f 00 00 00 7f 7f 7f 7f 7f 00 00 00
70: 7f 7f 7f 7f 7f 00 00 00 00 00 00 00 00 00 00 00
80: 11 00 00 00 00 00 00 00 00 00 00 09 00 c7 ff ff
90: e1 fe e1 70 00 00 00 00 00 00 00 00 00 00 00 00
a0: 5d 5f cb ba b8 c6 46 bb c5 46 1b 23 00 00 00 00
b0: 77 51 77 51 d8 c4 c3 b0 c5 b2 d9 bc 4c 42 c3 b0
c0: 69 37 2d 19 3c 0f 00 00 2d 00 00 00 00 00 00 00
d0: ff 30 7f 7f 7f 00 00 00 90 56 02 00 00 00 00 00
e0: 7f 7f 7f 7f 7f 00 00 00 7f 7f 7f 7f 7f 00 00 00
f0: 7f 7f 7f 7f 7f 00 00 00 00 00 00 00 00 00 00 00
[root@wes2 wes]# sensors
it87-isa-0290
Adapter: ISA adapter
VCore 1:   +1.48 V  (min =  +1.29 V, max =  +1.90 V)  
VCore 2:   +1.52 V  (min =  +1.29 V, max =  +1.90 V)  
+3.3V:     +3.24 V  (min =  +3.13 V, max =  +3.45 V)  
+5V:       +4.97 V  (min =  +4.72 V, max =  +5.24 V)  
+12V:     +11.76 V  (min = +11.36 V, max = +12.60 V)  
-12V:     -11.69 V  (min = -11.10 V, max = -12.84 V)  
-5V:       -4.93 V  (min =  -4.62 V, max =  -5.32 V)  
Stdby:     +5.02 V  (min =  +4.72 V, max =  +5.24 V)  
VBat:      +3.15 V
fan1:     3409 RPM  (min = 3000 RPM, div = 2)         
CPU:         +35?C  (low  =   +20?C, high =   +70?C)   sensor = invalid  
MB:          +27?C  (low  =   +25?C, high =   +45?C)   sensor = 
thermistor  




>It could be interesting to try changing the sensor type values with
>"sensors -s" and check this value so as to make sure it changes
>accordingly. The fact that reported temperatures didn't change at all
>when changing types is suspect, and I wouldn't be surprised if it did
>never change actually.
>
>  
>
Well, I chnaged sensor type from 2 to 3 several times and ran sensors-s 
in between changes. I assume it changed, as the sensors out would show 
thermistor when it was set for thermistor, and invalid when it was set 
for the diode. I had the ame problem with an earlier version (that came 
with mdk 9.2) but with it I had to set the type during driver 
installation. Yep, I've changed them a bunch.:-)

>Bonus question, did you try changing voltage or temperature limits, and
>did it work?
>
>  
>
Had to do some compute lines for voltages and change voltage limts in 
sensors.conf if that's what you mean. Before that most fo them were off 
a lot. Didn't I email you the IT87 part of sensors.conf? I thought I 
did. Oh, I added this for temp1;
compute temp1 @-35 , @+35, because at default it shows 70C and 35C is 
about right for idle.

>Sure, don't do anything before your drive is back in good health. I just
>hope that your drive didn't die of overheating because lm_sensors missed
>to tell you...
>
>  
>
Well, it wouldn't even boot last time I tried so I booted with Knoppix 
and fscked all the partitions and I'm back running from the HD now. But 
my lost & found folders are full of crap so I've got my fingers crossed 
that it'll hold out for just another day.

From: w.newell@verizon.net (Wes Newell)
Date: Thu, 19 May 2005 06:25:19 +0000
Subject: Temps on S755MAX IT8705F
Message-Id: <416E17BB.5070307@verizon.net>
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
>
>>>Yes, please try 2.8.7. Some of the changes made to the it87 driver,
>>>most notably in the init part, may have fixed your problem as a side
>>>effect.
>>>
>>>If it still doesn't work, please provide a dump of your it87 chip
>>>(with"isadump 0x295 0x296").
>>>      
>>>
>>Here's where I'm at now.:-)
>>[wes@wes2 wes]$ sensors
>>it87-isa-0290
>>Adapter: ISA adapter
>>ERROR: Can't get IN0 data!
>>(...)
>>    
>>
>
>Ah. I completely missed the fact that you could be using a 2.6 kernel.
>2.6.2 or 2.6.3 from Mandrake I guess? The trick is that in early 2.6 we
>changed the interface, so each kernel needs a specific version of
>lm_sensors. With lm_sensors 2.8.7 you'll need a 2.6.5-rc1 or later
>kernel.
>
>Second, this means that my comments on "changes on the it87 driver of
>the lm_sensors package may help you" are irrelevant. The it87 driver you
>use is from the kernel tree, so the changes I was monitoring do not
>affect you. OTOH, the 2.6 driver has had changes too, most notably in
>2.6.5, but actually in almost all versions since 2.6.1. This, upgrading
>kernels may bring some insight as well.
>
>
>  
>
>>But here's the dump.
>>
>>[root@wes2 wes]# isadump 0x295 0x296
>>  WARNING! Running this program can cause system crashes, data loss
>>  and 
>>worse!
>>  I will probe address register 0x0295 and data register 0x0296.
>>  You have five seconds to reconsider and press CTRL-C!
>>
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
>It could be interesting to try changing the sensor type values with
>"sensors -s" and check this value so as to make sure it changes
>accordingly. The fact that reported temperatures didn't change at all
>when changing types is suspect, and I wouldn't be surprised if it did
>never change actually.
>
>Bonus question, did you try changing voltage or temperature limits, and
>did it work?
>
>  
>
>>Until I get the drive replaced, I'm going to do as little as possible 
>>with the file system and hopefully I can recover most of my setup. If 
>>you don't hear from me for a while, you'll know why.:-)
>>    
>>
>
>Sure, don't do anything before your drive is back in good health. I just
>hope that your drive didn't die of overheating because lm_sensors missed
>to tell you...
>
>  
>
It's been a while, but I finally installed Mdk 10.1 with kernel 2.6.8 
and I've got everything configured to work fine. Here's the output and 
changes I've made to the sensors.conf file to get it like this.
[wes@wes2 wes]$ sensors
it87-isa-0290
Adapter: ISA adapter
VCore 1:   +1.49 V  (min =  +1.12 V, max =  +1.79 V)  
VCore 2:   +1.52 V  (min =  +1.41 V, max =  +1.70 V)  
+3.3V:     +3.25 V  (min =  +2.98 V, max =  +3.63 V)  
+5V:       +4.97 V  (min =  +4.49 V, max =  +5.51 V)  
+12V:     +11.78 V  (min = +10.82 V, max = +13.18 V)  
-12V:     -11.40 V  (min = -10.83 V, max = -13.19 V)  
-5V:       -4.97 V  (min =  -4.54 V, max =  -5.47 V)  
Stdby:     +5.00 V  (min =  +4.49 V, max =  +5.51 V)  
VBat:      +3.15 V
fan1:     2311 RPM  (min =    0 RPM, div = 8)         
fan2:        0 RPM  (min =    0 RPM, div = 8)         
fan3:        0 RPM  (min =    0 RPM, div = 8)         
CPU Temp:    +34?C  (low  =   +15?C, high =   +40?C)   sensor = diode  
M/B Temp:    +25?C  (low  =   +15?C, high =   +45?C)   sensor = 
thermistor  

-----------
chip "it87-*"

# The values below have been tested on Asus CUSI, CUM motherboards.

# Voltage monitors as advised in the It8705 data sheet

    label in0 "VCore 1"
    label in1 "VCore 2"
    label in2 "+3.3V"
    label in3 "+5V"
    label in4 "+12V"
    label in5 "-12V"
    label in6 "-5V"
    label in7 "Stdby"
    label in8 "VBat"

#nothing changed above, but changed most of the sets. Particularly for 
the minus voltages.

    set in0_min 1.5 * 0.75
    set in0_max 1.7 * 1.05
    set in1_min 1.4
    set in1_max 1.7
    set in2_min 3.3 * 0.90
    set in2_max 3.3 * 1.10
    set in3_min 5.0 * 0.90
    set in3_max 5.0 * 1.10
    set in4_min 12 * 0.90
    set in4_max 12 * 1.10
    set in5_max -12 * 1.10
    set in5_min -12 * 0.90
    set in6_max -5 * 1.10
    set in6_min -5 * 0.90
    set in7_min 5 * 0.90
    set in7_max 5 * 1.10

    compute in3 ((6.8/10)+1)*@ ,  @/((6.8/10)+1)
    compute in4 ((30/10) +1)*@  , @/((30/10) +1)

    compute in5 -(36/10)*@, -@/(36/10)
    compute in6 -(45/10)*@, -@/(45/10)

# left in5 alone, but had to mod compute in6 from 56/10 to 45/10 toget 
proper reading

   compute in7 ((6.8/10)+1)*@ ,  @/((6.8/10)+1)

# Had to reverse cpu/mb temps. Temp3 isn't used.

    label temp1       "CPU Temp"
    set   temp1_over  40
    set   temp1_low   15
    label temp2       "M/B Temp"
    set   temp2_over  45
    set   temp2_low   15
    ignore temp3
    label temp3       "Temp3"
    set   temp3_over  45
    set   temp3_low   15

    set fan1_min 0
    set fan2_min 0
#   ignore fan3
    set fan3_min 0

That's it. Thanks for your help a while back. This is a Jetway S755MAX 
board.
sensors version 2.8.7 with libsensors version 2.8.7

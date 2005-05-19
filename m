From: TheOneAndOnlySM@hot.rr.com (Sandeep Mehta)
Date: Thu, 19 May 2005 06:24:55 +0000
Subject: pc87360 sensor-driver results
Message-Id: <408F17FC.6050308@hot.rr.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <408B1888.8050802@hot.rr.com>
In-Reply-To: <408B1888.8050802@hot.rr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

lm_sensors2 cvs 04/27/04 @ 7:00 pm EST

I am definitely agreeing with the idea that temp3 is the National 
Semiconductor's internet temperature. I left my bios on for about half 
an hour, and noticed that it reported the cpu temperature to be at 66 
degrees celcius (which is definitely hotter than I expected). Doing 
"sensors" still yielded the 53 - 56 degree range (varying within that 
range), even though the bios was reporting a constant increase in 
temperature.

Here are the isadump outputs:

isadump -f 0xecd0 16 11
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00: 00 00 00 00 00 00 1f 05 02 0b 81 59 ff 00 ff 00

isadump -f 0xecd0 16 12
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00: 00 00 00 00 00 00 1f 05 02 0c 81 64 ff 00 ff 00

isadump -f 0xecd0 16 13
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00: 00 00 00 00 00 00 1f 05 02 0d 81 5d ff 00 ff 00

isadump -f 0xecf0 16 0
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00: 05 00 00 00 00 00 00 00 02 00 83 80 7f c9 7f 00

isadump -f 0xecf0 16 1
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00: 05 00 00 00 00 00 00 00 02 01 83 80 7f c9 7f 00

isadump -f 0xecf0 16 2
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00: 05 00 00 00 00 00 00 00 02 02 81 37 7f c9 7f 00

Also, I did echo "50 -55 50" > temp3 to set the high and critical 
temperatures. It reports a temperature of 54 C, but I didn't see an 
alarm flag (I assumed there should be one). (ouput of sensors at the end 
of text)

The fans seem to be working with pwmconfig a lot better, though still 
some quirks exist. It can be run (shutting off the fans) and there are 
no longer overflow flags and the readings remain accurate (no longer 
changing to -1).

Here is the pwmconfig output (the main strangeness is in the testing of 
pwm3, to which I still have not attached a fan):

Found the following PWM controls:
   pc87366-isa-ecc0/pwm1
   pc87366-isa-ecc0/pwm2
   pc87366-isa-ecc0/pwm3

Found the following fan sensors:
   pc87366-isa-ecc0/fan1     current speed: 3692 RPM
   pc87366-isa-ecc0/fan2     current speed: 2162 RPM
   pc87366-isa-ecc0/fan3     current speed: 0 ... skipping!

Warning!!! This program will stop your fans, one at a time,
for approximately 5 seconds each!!!
This may cause your processor temperature to rise!!!
If you do not want to do this hit control-C now!!!
Hit return to continue:

Testing pwm control pc87366-isa-ecc0/pwm1 ...
  pc87366-isa-ecc0/fan1 ... speed was 3692 now 3692
    no correlation
  pc87366-isa-ecc0/fan2 ... speed was 2162 now 2162
    no correlation

No correlations were detected.
There is either no fan connected to the output of pc87366-isa-ecc0/pwm1,
or the connected fan has no rpm-signal connected to one of
the tested fan sensors. (Note: not all motherboards have
the pwm outputs connected to the fan connectors,
check out the hardware database on http://www.almico.com/forumindex.php)

Did you see/hear a fan stopping during the above test (n)? y

Testing pwm control pc87366-isa-ecc0/pwm2 ...
  pc87366-isa-ecc0/fan1 ... speed was 3692 now 3692
    no correlation
  pc87366-isa-ecc0/fan2 ... speed was 2162 now 2162
    no correlation

No correlations were detected.
There is either no fan connected to the output of pc87366-isa-ecc0/pwm2,
or the connected fan has no rpm-signal connected to one of
the tested fan sensors. (Note: not all motherboards have
the pwm outputs connected to the fan connectors,
check out the hardware database on http://www.almico.com/forumindex.php)

Did you see/hear a fan stopping during the above test (n)? y

Testing pwm control pc87366-isa-ecc0/pwm3 ...
  pc87366-isa-ecc0/fan1 ... speed was 3692 now 3692
    no correlation
  pc87366-isa-ecc0/fan2 ... speed was 2162 now 1153
    It appears that fan pc87366-isa-ecc0/fan2
    is controlled by pwm pc87366-isa-ecc0/pwm3
Would you like to generate a detailed correlation (y)?
Would you like to generate a graphical plot using gnuplot (y)?
    PWM 255 FAN 2162
    PWM 240 FAN 2162
    PWM 225 FAN 2162
    PWM 210 FAN 2162
    PWM 195 FAN 2162
    PWM 180 FAN 2162
    PWM 165 FAN 2162
    PWM 150 FAN 2162
    PWM 135 FAN 2162
    PWM 120 FAN 2162
    PWM 105 FAN 2162
    PWM 90 FAN 2162
    PWM 75 FAN 2162
    PWM 60 FAN 2162
    PWM 45 FAN 2162
    PWM 30 FAN 2162
    PWM 15 FAN 2162
    PWM 0 FAN 2162
Warning: empty y range [2162:2162], adjusting to [2140.38:2183.62]
    Hit return to continue...

I have not played with fanconfig yet, but I will do so once I am sure I 
have a cpu temperature monitor.

However, I did do some pwm changes by echoing values to the pwm files in 
the proc entry. The fans did successfully change speed (I opened the 
case to see them slow down), but there was no change in speed reported 
in "sensors". I got overflow flags after echoing a value below a certain 
point.
For example:
echo 200 > pwm2 gives me in sensors
fan2:     2181 RPM  (min = 2000 RPM, div = 2)          OVERFLOW
which won't go away until I echo at least 228 and run the "sensors" 
command at least twice.
Hmm, this problem also exists with echoing values lower than 228 to 
pwm1. This time, I echo a value above or equal to 228 and I have to run 
sensors three times before the flag goes away.
I am guess this has to do with the the drivers need to refresh itself 
(note: in dmesg I get a lot of "pc87360.o: Data update" messages).

The flags for the fans get updated (both the overflow and alert flags) 
only after running "sensors" a few times.

output of sensors:
pc87366-isa-ecc0
Adapter: ISA adapter
in0:       +1.58 V  (min =  +0.00 V, max =   0.00 V)
in1:       +1.25 V  (min =  +0.00 V, max =   2.97 V)
in2:       +1.32 V  (min =  +0.00 V, max =   2.97 V)
in3:       +0.09 V  (min =  +0.00 V, max =   0.00 V)
in4:       +1.58 V  (min =  +0.00 V, max =   0.00 V)
in4:       +1.58 V  (min =  +0.00 V, max =   0.00 V)
in5:       +1.36 V  (min =  +0.00 V, max =   2.97 V)
in6:       +1.40 V  (min =  +0.00 V, max =   2.97 V)
in7:       +1.65 V  (min =  +0.00 V, max =   2.97 V)
in8:       +2.33 V  (min =  +0.00 V, max =   0.00 V)
in9:       +0.00 V  (min =  +0.05 V, max =   0.00 V)
in10:      +1.63 V  (min =  +0.00 V, max =   2.97 V)
fan1:     3692 RPM  (min = 3000 RPM, div = 1)          ALARM
fan2:     2162 RPM  (min = 2000 RPM, div = 2)          OVERFLOW
fan3:       -1 RPM  (min =    0 RPM, div = 8)          OVERFLOW
temp1:      -128 C  (low  =   -55 C, high =  +127 C)
temp1_crit:
            +127 C
temp2:      -128 C  (low  =   -55 C, high =  +127 C)
temp2_crit:
            +127 C
temp3:       +54 C  (low  =   -55 C, high =   +50 C)
temp3_crit:
             +50 C

*brief summary of what I did to get that status:
for fan1, echoed 3800 as min, then 3000 as min, but flag goes away after 
doing sensors twice
for fan2, echoed 200 for pwm2, then 255 for pwm2, and flag goes away 
after doing sensors twice

sensors -u
pc87366-isa-ecc0
Adapter: ISA adapter
alarms_in: 0.00 (alarms_in)
alarms_temp: 0.00 (alarms_temp)
fan1: 3692.00 (fan1)
  fan1_min: 3000.00 (fan1_min)
  fan1_div: 1.00 (fan1_div)
  fan1_status: 1.00 (fan1_status)
fan2: 2162.00 (fan2)
  fan2_min: 2000.00 (fan2_min)
  fan2_div: 2.00 (fan2_div)
  fan2_status: 1.00 (fan2_status)
fan3: -1.00 (fan3)
  fan3_min: 0.00 (fan3_min)
  fan3_div: 8.00 (fan3_div)
  fan3_status: 4.00 (fan3_status)
in0: 1.58 (in0)
  in0_min: 0.00 (in0_min)
  in0_max: 0.00 (in0_max)
  in0_status: 0.00 (in0_status)
in1: 1.23 (in1)
  in1_min: 0.00 (in1_min)
  in1_max: 2.97 (in1_max)
  in1_status: 129.00 (in1_status)
in2: 1.32 (in2)
  in2_min: 0.00 (in2_min)
  in2_max: 2.97 (in2_max)
  in2_status: 129.00 (in2_status)
in3: 0.09 (in3)
  in3_min: 0.00 (in3_min)
  in3_max: 0.00 (in3_max)
  in3_status: 0.00 (in3_status)
in4: 1.58 (in4)
  in4_min: 0.00 (in4_min)
  in4_max: 0.00 (in4_max)
  in4_status: 0.00 (in4_status)
in5: 1.36 (in5)
  in5_min: 0.00 (in5_min)
  in5_max: 2.97 (in5_max)
  in5_status: 129.00 (in5_status)
in6: 1.40 (in6)
  in6_min: 0.00 (in6_min)
  in6_max: 2.97 (in6_max)
  in6_status: 129.00 (in6_status)
in7: 1.65 (in7)
  in7_min: 0.00 (in7_min)
  in7_max: 2.97 (in7_max)
  in7_status: 129.00 (in7_status)
in8: 2.33 (in8)
  in8_min: 0.00 (in8_min)
  in8_max: 0.00 (in8_max)
  in8_status: 0.00 (in8_status)
in9: 0.00 (in9)
  in9_min: 0.05 (in9_min)
  in9_max: 0.00 (in9_max)
  in9_status: 0.00 (in9_status)
in10: 1.64 (in10)
  in10_min: 0.00 (in10_min)
  in10_max: 2.97 (in10_max)
  in10_status: 129.00 (in10_status)
temp1: -128.00 (temp1)
  temp1_min: -55.00 (temp1_min)
  temp1_max: 127.00 (temp1_max)
  temp1_crit: 127.00 (temp1_crit)
  temp1_status: 131.00 (temp1_status)
temp2: -128.00 (temp2)
  temp2_min: -55.00 (temp2_min)
  temp2_max: 127.00 (temp2_max)
  temp2_crit: 127.00 (temp2_crit)
  temp2_status: 131.00 (temp2_status)
temp3: 54.00 (temp3)
  temp3_min: -55.00 (temp3_min)
  temp3_max: 50.00 (temp3_max)
  temp3_crit: 50.00 (temp3_crit)
  temp3_status: 141.00 (temp3_status)

(the following are the proc entries so you know what I have echoed for 
values)
ls -l /proc/sys/dev/sensors/pc87366-isa-ecc0
total 0
-r--r--r--    1 root     root            0 Apr 27 21:26 alarms
-rw-r--r--    1 root     root            0 Apr 27 21:26 fan1
-r--r--r--    1 root     root            0 Apr 27 21:26 fan1_status
-rw-r--r--    1 root     root            0 Apr 27 21:26 fan2
-r--r--r--    1 root     root            0 Apr 27 21:26 fan2_status
-rw-r--r--    1 root     root            0 Apr 27 21:26 fan3
-r--r--r--    1 root     root            0 Apr 27 21:26 fan3_status
-rw-r--r--    1 root     root            0 Apr 27 21:26 fan_div
-rw-r--r--    1 root     root            0 Apr 27 21:26 in0
-r--r--r--    1 root     root            0 Apr 27 21:26 in0_status
-rw-r--r--    1 root     root            0 Apr 27 21:26 in1
-rw-r--r--    1 root     root            0 Apr 27 21:26 in10
-r--r--r--    1 root     root            0 Apr 27 21:26 in10_status
-r--r--r--    1 root     root            0 Apr 27 21:26 in1_status
-rw-r--r--    1 root     root            0 Apr 27 21:26 in2
-r--r--r--    1 root     root            0 Apr 27 21:26 in2_status
-rw-r--r--    1 root     root            0 Apr 27 21:26 in3
-r--r--r--    1 root     root            0 Apr 27 21:26 in3_status
-rw-r--r--    1 root     root            0 Apr 27 21:26 in4
-r--r--r--    1 root     root            0 Apr 27 21:26 in4_status
-rw-r--r--    1 root     root            0 Apr 27 21:26 in5
-r--r--r--    1 root     root            0 Apr 27 21:26 in5_status
-rw-r--r--    1 root     root            0 Apr 27 21:26 in6
-r--r--r--    1 root     root            0 Apr 27 21:26 in6_status
-rw-r--r--    1 root     root            0 Apr 27 21:26 in7
-r--r--r--    1 root     root            0 Apr 27 21:26 in7_status
-rw-r--r--    1 root     root            0 Apr 27 21:26 in8
-r--r--r--    1 root     root            0 Apr 27 21:26 in8_status
-rw-r--r--    1 root     root            0 Apr 27 21:26 in9
-r--r--r--    1 root     root            0 Apr 27 21:26 in9_status
-rw-r--r--    1 root     root            0 Apr 27 21:26 pwm1
-rw-r--r--    1 root     root            0 Apr 27 21:26 pwm2
-rw-r--r--    1 root     root            0 Apr 27 21:26 pwm3
-rw-r--r--    1 root     root            0 Apr 27 21:26 temp1
-rw-r--r--    1 root     root            0 Apr 27 21:26 temp1_status
-rw-r--r--    1 root     root            0 Apr 27 21:26 temp2
-rw-r--r--    1 root     root            0 Apr 27 21:26 temp2_status
-rw-r--r--    1 root     root            0 Apr 27 21:26 temp3
-rw-r--r--    1 root     root            0 Apr 27 21:26 temp3_status

cat /proc/sys/dev/sensors/pc87366-isa-ecc0/*
0 0
3000 3404
1
2000 2162
1
0 -1
4
1 2 8
0.00 0.00 1.58
0
0.00 2.97 1.23
0.00 2.97 1.64
129
129
0.00 2.97 1.32
129
0.00 0.00 0.09
0
0.00 0.00 1.58
0
0.00 2.97 1.37
129
0.00 2.97 1.40
129
0.00 2.97 1.65
129
0.00 0.00 2.33
0
0.05 0.00 0.00
0
255 0
255 0
255 1
127 -55 127 -128
131
127 -55 127 -128
131
50 -55 50 55
141

One question: there is an enormous difference (by sound of fans) going 
from pwm 255 to 220 (or even 230 to 220), and going from 220 to anything 
lower is sometimes not even noticeable. Is this because there is an 
exponential relation between pwm and rpm?

Thanks

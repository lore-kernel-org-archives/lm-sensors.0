From: TheOneAndOnlySM@hot.rr.com (Sandeep Mehta)
Date: Thu, 19 May 2005 06:24:55 +0000
Subject: pc87360 sensor-driver results
Message-Id: <408DC0AD.6010704@hot.rr.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <408B1888.8050802@hot.rr.com>
In-Reply-To: <408B1888.8050802@hot.rr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

lm_sensors2 cvs 04/26/04 @ 6 pm EST

Awesome. Temp3 appears to be reporting accurate readings (in celcius) of 
what my bios says is the cpu temperature. The high and low temperatures 
are also stated correctly (with the default values, according to the 
pc87366 data sheet). The temperature is also slowly rising for temp3, so 
there there is definitely constant measurement happening.

However, temp1 and temp2 still display negative -128 instead of zero. 
I'll look into my board and see if this chip is trying to measure other 
temperatures, but I doubt it.

Also, I tried looking for information about what temp3 should be 
reporting (the nat.semi. ship temp or the cpu temp) but was unable to 
locate anything. I'll have a closer look.

I will do some environment changing this weekend. Every four months I 
clean out my cpu fan because it gets bogged with dust, and my bios 
reports a significantly lower temperature. If this change is shown on 
temp3, then I can confirm that the temp3 value is indeed the cpu 
temperature.

Fans are working as they have. I can set minimum values without a 
problem. However I noticed 2 oddities:
1:) echoing a value that is greater than the current fan rotation speed 
will yield a different number for minimum in "sensors" or in the proc entry.
2:) the alarm flags don't wear off even if I set the minimum value under 
the current fans speed (after having a previous setting that was higher 
than the fan speed)

Pwmconfig still appears to be confused about the fans. After running it 
(and after it has shut down both my fans and restarted them), I get the 
overflow flags in "sensors" and the speeds are reported as -1.

(the following output is after I did
echo "1 2" > /proc/sys/dev/sensors/pc87366-isa-ecc0/fan_div
echo 3000 > /proc/sys/dev/sensors/pc87366-isa-ecc0/fan1
echo 1500 > /proc/sys/dev/sensors/pc87366-isa-ecc0/fan2
echo 3500 > /proc/sys/dev/sensors/pc87366-isa-ecc0/fan1
echo 2170 > /proc/sys/dev/sensors/pc87366-isa-ecc0/fan2
echo 2400 > /proc/sys/dev/sensors/pc87366-isa-ecc0/fan1)

output of sensors
pc87366-isa-ecc0
Adapter: ISA adapter
in0:       +0.00 V  (min =  +0.00 V, max =   0.00 V)
in1:       +1.25 V  (min =  +0.00 V, max =   2.97 V)
in2:       +1.32 V  (min =  +0.00 V, max =   2.97 V)
in3:       +0.00 V  (min =  +0.00 V, max =   0.00 V)
in4:       +0.00 V  (min =  +0.00 V, max =   0.00 V)
in4:       +0.00 V  (min =  +0.00 V, max =   0.00 V)
in5:       +1.36 V  (min =  +0.00 V, max =   2.97 V)
in6:       +1.41 V  (min =  +0.00 V, max =   2.97 V)
in7:       +1.65 V  (min =  +0.00 V, max =   2.97 V)
in8:       +0.00 V  (min =  +0.00 V, max =   0.00 V)
in9:       +0.00 V  (min =  +0.00 V, max =   0.00 V)
in10:      +1.63 V  (min =  +0.00 V, max =   2.97 V)
fan1:     3404 RPM  (min = 2400 RPM, div = 1)          ALARM
fan2:     2162 RPM  (min = 2181 RPM, div = 2)          ALARM
fan3:       -1 RPM  (min =    0 RPM, div = 8)          OVERFLOW
temp1:      -128 C  (low  =   -55 C, high =  +127 C)
temp1_crit:
            +127 C
temp2:      -128 C  (low  =   -55 C, high =  +127 C)
temp2_crit:
            +127 C
temp3:       +53 C  (low  =   -55 C, high =  +127 C)
temp3_crit:
            +127 C

For he above, even though I echoed fan2 to have a min value of 2170, it 
is reporting 2181. I had a similar problem with fan1's min, but echoing 
2400 gave no problems.

output of sensors -u
pc87366-isa-ecc0
Adapter: ISA adapter
alarms_in: 0.00 (alarms_in)
alarms_temp: 0.00 (alarms_temp)
fan1: 3404.00 (fan1)
  fan1_min: 2400.00 (fan1_min)
  fan1_div: 1.00 (fan1_div)
  fan1_status: 2.00 (fan1_status)
fan2: 2162.00 (fan2)
  fan2_min: 2181.00 (fan2_min)
  fan2_div: 2.00 (fan2_div)
  fan2_status: 2.00 (fan2_status)
fan3: -1.00 (fan3)
  fan3_min: 0.00 (fan3_min)
  fan3_div: 8.00 (fan3_div)
  fan3_status: 4.00 (fan3_status)
in0: 0.00 (in0)
  in0_min: 0.00 (in0_min)
  in0_max: 0.00 (in0_max)
  in0_status: 0.00 (in0_status)
in1: 1.25 (in1)
  in1_min: 0.00 (in1_min)
  in1_max: 2.97 (in1_max)
  in1_status: 129.00 (in1_status)
in2: 1.32 (in2)
  in2_min: 0.00 (in2_min)
  in2_max: 2.97 (in2_max)
  in2_status: 129.00 (in2_status)
in3: 0.00 (in3)
  in3_min: 0.00 (in3_min)
  in3_max: 0.00 (in3_max)
  in3_status: 0.00 (in3_status)
in4: 0.00 (in4)
  in4_min: 0.00 (in4_min)
  in4_max: 0.00 (in4_max)
  in4_status: 0.00 (in4_status)
in5: 1.37 (in5)
  in5_min: 0.00 (in5_min)
  in5_max: 2.97 (in5_max)
  in5_status: 129.00 (in5_status)
in6: 1.41 (in6)
  in6_min: 0.00 (in6_min)
  in6_max: 2.97 (in6_max)
  in6_status: 129.00 (in6_status)
in7: 1.64 (in7)
  in7_min: 0.00 (in7_min)
  in7_max: 2.97 (in7_max)
  in7_status: 129.00 (in7_status)
in8: 0.00 (in8)
  in8_min: 0.00 (in8_min)
  in8_max: 0.00 (in8_max)
  in8_status: 0.00 (in8_status)
in9: 0.00 (in9)
  in9_min: 0.00 (in9_min)
  in9_max: 0.00 (in9_max)
  in9_status: 0.00 (in9_status)
in10: 1.63 (in10)
  in10_min: 0.00 (in10_min)
  in10_max: 2.97 (in10_max)
  in10_status: 129.00 (in10_status)
temp1: -128.00 (temp1)
  temp1_min: -55.00 (temp1_min)
  temp1_max: 127.00 (temp1_max)
  temp1_crit: 127.00 (temp1_crit)
  temp1_status: 127.00 (temp1_status)
temp2: -128.00 (temp2)
  temp2_min: -55.00 (temp2_min)
  temp2_max: 127.00 (temp2_max)
  temp2_crit: 127.00 (temp2_crit)
  temp2_status: 127.00 (temp2_status)
temp3: 53.00 (temp3)
  temp3_min: -55.00 (temp3_min)
  temp3_max: 127.00 (temp3_max)
  temp3_crit: 127.00 (temp3_crit)
  temp3_status: 127.00 (temp3_status)

ls -l /proc/sys/dev/sensors/pc87366-isa-ecc0
-r--r--r--    1 root     root            0 Apr 26 21:01 alarms
-rw-r--r--    1 root     root            0 Apr 26 21:01 fan1
-r--r--r--    1 root     root            0 Apr 26 21:01 fan1_status
-rw-r--r--    1 root     root            0 Apr 26 21:01 fan2
-r--r--r--    1 root     root            0 Apr 26 21:01 fan2_status
-rw-r--r--    1 root     root            0 Apr 26 21:01 fan3
-r--r--r--    1 root     root            0 Apr 26 21:01 fan3_status
-rw-r--r--    1 root     root            0 Apr 26 21:01 fan_div
-rw-r--r--    1 root     root            0 Apr 26 21:01 in0
-r--r--r--    1 root     root            0 Apr 26 21:01 in0_status
-rw-r--r--    1 root     root            0 Apr 26 21:01 in1
-rw-r--r--    1 root     root            0 Apr 26 21:01 in10
-r--r--r--    1 root     root            0 Apr 26 21:01 in10_status
-r--r--r--    1 root     root            0 Apr 26 21:01 in1_status
-rw-r--r--    1 root     root            0 Apr 26 21:01 in2
-r--r--r--    1 root     root            0 Apr 26 21:01 in2_status
-rw-r--r--    1 root     root            0 Apr 26 21:01 in3
-r--r--r--    1 root     root            0 Apr 26 21:01 in3_status
-rw-r--r--    1 root     root            0 Apr 26 21:01 in4
-r--r--r--    1 root     root            0 Apr 26 21:01 in4_status
-rw-r--r--    1 root     root            0 Apr 26 21:01 in5
-r--r--r--    1 root     root            0 Apr 26 21:01 in5_status
-rw-r--r--    1 root     root            0 Apr 26 21:01 in6
-r--r--r--    1 root     root            0 Apr 26 21:01 in6_status
-rw-r--r--    1 root     root            0 Apr 26 21:01 in7
-r--r--r--    1 root     root            0 Apr 26 21:01 in7_status
-rw-r--r--    1 root     root            0 Apr 26 21:01 in8
-r--r--r--    1 root     root            0 Apr 26 21:01 in8_status
-rw-r--r--    1 root     root            0 Apr 26 21:01 in9
-r--r--r--    1 root     root            0 Apr 26 21:01 in9_status
-rw-r--r--    1 root     root            0 Apr 26 21:01 pwm1
-rw-r--r--    1 root     root            0 Apr 26 21:01 pwm2
-rw-r--r--    1 root     root            0 Apr 26 21:01 pwm3
-rw-r--r--    1 root     root            0 Apr 26 21:01 temp1
-rw-r--r--    1 root     root            0 Apr 26 21:01 temp1_status
-rw-r--r--    1 root     root            0 Apr 26 21:01 temp2
-rw-r--r--    1 root     root            0 Apr 26 21:01 temp2_status
-rw-r--r--    1 root     root            0 Apr 26 21:01 temp3
-rw-r--r--    1 root     root            0 Apr 26 21:01 temp3_status

cat /proc/sys/dev/sensors/pc87366-isa-ecc0/*
0 0
2400 3404
2
2181 2162
2
0 -1
4
1 2 8
0.00 0.00 0.00
0
0.00 2.97 1.25
0.00 2.97 1.63
129
129
0.00 2.97 1.32
129
0.00 0.00 0.00
0
0.00 0.00 0.00
0
0.00 2.97 1.36
129
0.00 2.97 1.40
129
0.00 2.97 1.65
129
0.00 0.00 0.00
0
0.00 0.00 0.00
0
255 0
255 0
255 1
127 -55 127 -128
131
127 -55 127 -128
131
127 -55 127 53
129

Sad news is that my motherboard is a "custom" HP-Asus motherboard 
(P4B-LA) not supported by Asus themselves. HP doesn't seem to have any 
intrust in bios upgrades, so for now I am still without voltage readings 
in bios. I will keep trying to see if I can call into a higher level 
technician to see if they have any info on getting information from the 
nat.semi. chip through the bios.

Thanks for your continuing work on this driver!

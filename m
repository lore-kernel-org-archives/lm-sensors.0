From: TheOneAndOnlySM@hot.rr.com (Sandeep Mehta)
Date: Thu, 19 May 2005 06:24:55 +0000
Subject: pc87360 sensor-driver results
Message-Id: <40906895.5040705@hot.rr.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <408B1888.8050802@hot.rr.com>
In-Reply-To: <408B1888.8050802@hot.rr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

first, in relation to yesterday's lm_sensors (04/27 @ 7 pm)

Even the proc entries for fan speed don't get updated after echoing new 
pwm values; the fan#_status files say "4" and sensors will output an 
overflow flag, no matter how many times I cat the proc entries, run 
sensors, or leave the computer idle.

I re-ran pwmconfig, an this time, no correlation was detected with pwm3; 
the ouput it gave was:

Testing pwm control pc87366-isa-ecc0/pwm3 ...
  pc87366-isa-ecc0/fan1 ... speed was 3529 now 3529
    no correlation
  pc87366-isa-ecc0/fan2 ... speed was 2222 now 2222
    no correlation

No correlations were detected.
There is either no fan connected to the output of pc87366-isa-ecc0/pwm3,
or the connected fan has no rpm-signal connected to one of
the tested fan sensors. (Note: not all motherboards have
the pwm outputs connected to the fan connectors,
check out the hardware database on http://www.almico.com/forumindex.php)

So perhaps yesterday's incident was just a rare glitch based on a very 
specific configuration I had at that very moment I ran pwmconfig (though 
I don't know what it could be... I have the exact same modules loaded in 
the same desktop...).

Onto lm_sensors cvs 04/28/04 @ 7:15 pm EST

The alarms for the temperatures seem to be working fine. From what I 
gather in the last e-mail is that the alarm flag will be displayed one 
time after the alarm has gone away, and then get cleared. This is 
exactly what happened here. (note: doing cat on the temp3_status file 
produced the same effect as having to run sensors before the flag was 
cleared).

As for the cpu temperature, it seems as though windows programs are also 
unable to detect it. Here is a link to screenshots of two windows 
programs I tried (both available online; the first is called speedfans 
and is freeware, the other is simply called hardware monitor and is 
shareware)
http://themastermind3000.tripod.com/index.html

The first shot shows that the other temperatures are definitely a 
problem. It also shows some voltages, so hopefully that will aide in 
that aspect.
The second shot calls the only reportable temperature the mainboard 
temperature, and it reports about 51 degrees...
So it seems that this cpu temperature problem is common.

As for fans, this cvs is reporting 0 pwm to be the highest and 255 to be 
the lowest. For this reason, immediately after I execute pwmconfig, my 
fans turn off, and when the program tries to really turn off the fans, 
it turns them back on.

Other than that, the fans' pwm altering is in good working order. All 
the pwm files have the "1" bit.
However, the speeds will still not get updated. There is an overflow 
flag if I echo anything above 27 (or 228 if pwm was used normally). I 
ran sensors several times (giving the computer about a minute of idle 
time) and cat'ed the fan#_status files several times. When pwm values 
above 27 were echoed, the status files stated "4". After echoing 27 or 
lower, the flags would wear off only after I either ran sensors or 
cat'ed the respective status file and waited at least 4 seconds.

Something similar happens with echoing minimum values. After echoing a 
minimum value higher than the reported speed, an alarm flag comes on 
normally. Then, after echoing a value lower than the fan speed, only 
after cat'ing the respective fan#_status file (which stated "3") or 
running sensors and then waiting 4 seconds will the flags go away.

For both temperatures and fans, the flags also are removed if gkrellm is 
running (I suppose since it is continuously querying the driver and 
forcing it to update); but even while gkrellm ran, the speeds would not 
get updated with pwm changes.

(the outputs after doing
echo 3800 > fan1
echo 40 > pwm2
echo 3000 > fan1
echo 45 > temp3)

output of sensors:
pc87366-isa-ecc0
Adapter: ISA adapter
in0:       +1.58 V  (min =  +0.00 V, max =   0.00 V)
in1:       +1.29 V  (min =  +0.00 V, max =   2.97 V)
in2:       +1.34 V  (min =  +0.00 V, max =   2.97 V)
in3:       +0.09 V  (min =  +0.00 V, max =   0.00 V)
in4:       +1.58 V  (min =  +0.00 V, max =   0.00 V)
in5:       +1.39 V  (min =  +0.00 V, max =   2.97 V)
in6:       +1.42 V  (min =  +0.00 V, max =   2.97 V)
in7:       +1.65 V  (min =  +0.00 V, max =   2.97 V)
in8:       +2.33 V  (min =  +0.00 V, max =   0.00 V)
in9:       +0.00 V  (min =  +0.05 V, max =   0.00 V)
in10:      +1.63 V  (min =  +0.00 V, max =   2.97 V)
fan1:     3404 RPM  (min = 3000 RPM, div = 1)          ALARM
fan2:     2162 RPM  (min = 2000 RPM, div = 2)          OVERFLOW
fan3:       -1 RPM  (min =    0 RPM, div = 8)          OVERFLOW
temp1:      -128 C  (low  =   -55 C, high =  +127 C)  ALARM
temp1_crit:
            +127 C
temp2:      -128 C  (low  =   -55 C, high =  +127 C)  ALARM
temp2_crit:
            +127 C
temp3:       +52 C  (low  =   -55 C, high =   +45 C)  ALARM
temp3_crit:
            +127 C

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
  fan2_status: 4.00 (fan2_status)
fan3: -1.00 (fan3)
  fan3_min: 0.00 (fan3_min)
  fan3_div: 8.00 (fan3_div)
  fan3_status: 4.00 (fan3_status)
in0: 1.58 (in0)
  in0_min: 0.00 (in0_min)
  in0_max: 0.00 (in0_max)
  in0_status: 0.00 (in0_status)
in1: 1.28 (in1)
  in1_min: 0.00 (in1_min)
  in1_max: 2.97 (in1_max)
  in1_status: 129.00 (in1_status)
in2: 1.34 (in2)
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
in5: 1.39 (in5)
  in5_min: 0.00 (in5_min)
  in5_max: 2.97 (in5_max)
  in5_status: 129.00 (in5_status)
in6: 1.42 (in6)
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
temp3: 52.00 (temp3)
  temp3_min: -55.00 (temp3_min)
  temp3_max: 45.00 (temp3_max)
  temp3_crit: 127.00 (temp3_crit)
  temp3_status: 133.00 (temp3_status)

By the way, what are the temp#_status files reporting?

I will see what I can dig up about those other special channels for this 
chip, most likely this weekend.

From: TheOneAndOnlySM@hot.rr.com (Sandeep Mehta)
Date: Thu, 19 May 2005 06:24:56 +0000
Subject: pc87360 sensor-driver results
Message-Id: <409570BD.3070107@hot.rr.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <408B1888.8050802@hot.rr.com>
In-Reply-To: <408B1888.8050802@hot.rr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Sorry about not responding for the last few days; I was unaware that I 
would be unavailable during the weekend, and was thus unable to get in 
contact with HP, Asustek, or National Semiconductor. I don't think I'll 
have time today, but it will certainly be on my agenda for this week.

lm_sensors2 cvs 05/02/04 @ 5:20 EST

*Attached are the isadumps from the previous e-mail. If you need me to 
just write them into an e-mail, let me know.

The output of sensors has an overall better look and feeling; it is much 
cleaner.

Fan speeds are still causing the same problem when pwm is changed
here are the outputs of isadump -f 0xecc0 16 during pwm changing:

pwm1 and pwm2 is 255
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00: 00 ff 00 ff 00 ff ff 0f 60 ff 00 64 ff 00 64 00

pwm2 is 200
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00: 00 ff 00 c8 00 ff ff 0f 60 ff 00 64 ff 00 64 00

pwm2 is 230
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00: 00 ff 00 e6 00 ff ff 0f 60 ff 00 64 ff 00 64 00

pwm2 is 255 and pwm1 is 200
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00: 00 c8 00 ff 00 ff ff 00 64 ff 1b 60 ff 00 64 00

pwm 1 is 230
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00: 00 e6 00 ff 00 ff ff 00 64 ff 1b 60 ff 00 64 00

pwm1 is 240
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00: 00 f0 00 ff 00 ff ff 00 64 ff 1c 60 ff 00 64 00

pwm1 is 245 and pwm2 is 215
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00: 00 f5 00 d7 00 ff ff 00 64 ff 00 64 ff 00 64 00


The voltage alarms are also working. I can echo a min or max value and 
an alarm flag will be displayed. Setting a value to take away the alarm 
will remove the alarm flag after sensors has been run once (or the 
status file cat'ed) and then run once again after waiting a few seconds.
Also, for voltages that either aren't used or aren't monitored, setting 
a min or max value sets no flag (but sensors does report the updated value).

The sensors.conf file also correctly sets min and max values for the 
specified voltages, and hides unused values in readings from showing in 
"sensors."

output of sensors:
pc87366-isa-ecc0
Adapter: ISA adapter
in0:       +0.00 V  (min =  +0.99 V, max =   0.00 V)
in1:       +1.31 V  (min =  +0.00 V, max =   0.99 V)       ALARM
in2:       +0.82 V  (min =  +2.99 V, max =   3.02 V)       ALARM
in3:       +0.00 V  (min =  +0.00 V, max =   0.00 V)
in4:       +0.00 V  (min =  +0.00 V, max =   0.00 V)
in5:       +1.49 V  (min =  +0.00 V, max =   3.02 V)
in6:       +1.49 V  (min =  +0.00 V, max =   3.02 V)
Vsb:       +3.36 V  (min =  +3.12 V, max =   3.46 V)
Vdd:       +3.34 V  (min =  +0.00 V, max =   6.04 V)
AVdd:      +3.32 V  (min =  +3.12 V, max =   3.46 V)
fan1:     3779 RPM  (min =    0 RPM, div = 1)
fan2:     2162 RPM  (min =    0 RPM, div = 2)
S-IO Temp:   +47 C  (low  =   -55 C, high =  +127 C)
S-IO Crit:  +127 C

sensors -u
pc87366-isa-ecc0
Adapter: ISA adapter
alarms_in: 0.00 (alarms_in)
alarms_temp: 0.00 (alarms_temp)
fan1: 3503.00 (fan1)
  fan1_min: 0.00 (fan1_min)
  fan1_div: 1.00 (fan1_div)
  fan1_status: 1.00 (fan1_status)
fan2: 2162.00 (fan2)
  fan2_min: 0.00 (fan2_min)
  fan2_div: 2.00 (fan2_div)
  fan2_status: 1.00 (fan2_status)
in0: 0.00 (in0)
  in0_min: 0.99 (in0_min)
  in0_max: 0.00 (in0_max)
  in0_status: 0.00 (in0_status)
in1: 1.33 (in1)
  in1_min: 0.00 (in1_min)
  in1_max: 0.99 (in1_max)
  in1_status: 133.00 (in1_status)
in2: 0.82 (in2)
  in2_min: 2.99 (in2_min)
  in2_max: 3.02 (in2_max)
  in2_status: 131.00 (in2_status)
in3: 0.00 (in3)
  in3_min: 0.00 (in3_min)
  in3_max: 0.00 (in3_max)
  in3_status: 0.00 (in3_status)
in4: 0.00 (in4)
  in4_min: 0.00 (in4_min)
  in4_max: 0.00 (in4_max)
  in4_status: 0.00 (in4_status)
in5: 1.47 (in5)
  in5_min: 0.00 (in5_min)
  in5_max: 3.02 (in5_max)
  in5_status: 129.00 (in5_status)
in6: 1.50 (in6)
  in6_min: 0.00 (in6_min)
  in6_max: 3.02 (in6_max)
  in6_status: 129.00 (in6_status)
Vsb: 3.36 (in7)
  in7_min: 3.12 (in7_min)
  in7_max: 3.46 (in7_max)
  in7_status: 129.00 (in7_status)
Vdd: 3.34 (in8)
  in8_min: 0.00 (in8_min)
  in8_max: 6.04 (in8_max)
  in8_status: 129.00 (in8_status)
AVdd: 3.32 (in10)
  in10_min: 3.12 (in10_min)
  in10_max: 3.46 (in10_max)
  in10_status: 129.00 (in10_status)
S-IO Temp: 48.00 (temp3)
  temp3_min: -55.00 (temp3_min)
  temp3_max: 127.00 (temp3_max)
  S-IO Crit: 127.00 (temp3_crit)
  temp3_status: 129.00 (temp3_status)


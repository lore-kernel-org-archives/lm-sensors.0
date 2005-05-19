From: dimitrios@michelinakis.gr (Dimitrios 'sehh' Michelinakis)
Date: Thu, 19 May 2005 06:24:53 +0000
Subject: ticket# 1650 - ERROR: Can__t get TEMP1 data!
Message-Id: <20040416083039.067ffb03@ekolaptis.>
List-Id: <lm-sensors.vger.kernel.org>
References: <1082040645.407ea145eedf3@imp.gcu.info>
In-Reply-To: <1082040645.407ea145eedf3@imp.gcu.info>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Fri, 16 Apr 2004 08:54:40 +0200 Jean Delvare <khali@linux-fr.org> wrote:

> [PLEASE REPLY TO THE LIST, NOT TO ME ONLY]
> 
> > i've made sure all files are the current version, i do not have any
> > old libraries, or any other old files from older versions.
> > 
> > the only interesting fact which i've just discovered, is that i can
> > read temperatures if i do this:
> > 
> > [root@ekolaptis it87-isa-0290]# cat temp1
> > 40.0 15.0 52.0
> > [root@ekolaptis it87-isa-0290]# cat temp2
> > 45.0 15.0 -28.0
> > [root@ekolaptis it87-isa-0290]# cat temp3
> > 45.0 15.0 127.0
> > 
> > i found a bunch of files under /proc/sys/dev/sensors/it87-isa-0290
> > which i can read without any problem.
> > 
> > doing 'sensors' still results in this error:
> > it87-isa-0290
> > Adapter: ISA adapter
> > VCore 1:   +1.72 V  (min =  +1.42 V, max =  +1.56 V)   ALARM
> > VCore 2:   +0.00 V  (min =  +2.40 V, max =  +2.60 V)   ALARM
> > +3.3V:     +6.42 V  (min =  +3.12 V, max =  +3.44 V)   ALARM
> > +5V:       +4.89 V  (min =  +4.72 V, max =  +5.24 V)
> > +12V:     +12.08 V  (min = +11.36 V, max = +12.60 V)
> > -12V:     -27.36 V  (min = -12.63 V, max = -11.41 V)   ALARM
> > -5V:      -13.64 V  (min =  -5.28 V, max =  -4.81 V)   ALARM
> > Stdby:     +4.97 V  (min =  +4.72 V, max =  +5.24 V)
> > VBat:      +4.08 V
> > fan1:        0 RPM  (min =    0 RPM, div = 2)
> > fan2:        0 RPM  (min = 3000 RPM, div = 2)          ALARM
> > fan3:        0 RPM  (min = 3000 RPM, div = 2)          ALARM
> > ERROR: Can't get TEMP1 data!
> > ERROR: Can't get TEMP2 data!
> > ERROR: Can't get TEMP3 data!
> > 
> > i'm out of ideas :(
> 
> A still have a few ones, don't panic ;)
> 
> First of all, please provide the output of:
> sensors -v
> sensors -u

sensors -v:
sensors version 2.8.6

sensors -u:
it87-isa-0290
Adapter: ISA adapter
VCore 1: 1.72 (in0)
  in0_min: 1.42 (in0_min)
  in0_max: 1.56 (in0_max)
VCore 2: 0.00 (in1)
  in1_min: 2.40 (in1_min)
  in1_max: 2.60 (in1_max)
+3.3V: 6.46 (in2)
  in2_min: 3.12 (in2_min)
  in2_max: 3.44 (in2_max)
+5V: 4.91 (in3)
  in3_min: 4.72 (in3_min)
  in3_max: 5.24 (in3_max)
+12V: 12.00 (in4)
  in4_min: 11.36 (in4_min)
  in4_max: 12.60 (in4_max)
-12V: -27.36 (in5)
  in5_min: -12.63 (in5_min)
  in5_max: -11.41 (in5_max)
-5V: -13.64 (in6)
  in6_min: -5.28 (in6_min)
  in6_max: -4.81 (in6_max)
Stdby: 4.97 (in7)
  in7_min: 4.72 (in7_min)
  in7_max: 5.24 (in7_max)
VBat: 4.08 (in8)
fan1: 0.00 (fan1)
  fan1_min: 0.00 (fan1_min)
  fan1_div: 2.00 (fan1_div)
fan2: 0.00 (fan2)
  fan2_min: 3000.00 (fan2_min)
  fan2_div: 2.00 (fan2_div)
fan3: 0.00 (fan3)
  fan3_min: 3000.00 (fan3_min)
  fan3_div: 2.00 (fan3_div)
M/B Temp: 51.00 (temp1)
  temp1_low: 15.00 (temp1_low)
  temp1_over: 40.00 (temp1_over)
CPU Temp: -39.00 (temp2)
  temp2_low: 15.00 (temp2_low)
  temp2_over: 45.00 (temp2_over)
Temp3: 127.00 (temp3)
  temp3_low: 15.00 (temp3_low)
  temp3_over: 45.00 (temp3_over)
alarms: 26390.00 (alarms)
ERROR: Can't get feature `sensor1' data!
ERROR: Can't get feature `sensor2' data!
ERROR: Can't get feature `sensor3' data!


> Second, do you see files named "sensor1", "sensor2" and "sensor3" in the
> same place you saw "temp1", "temp2" and "temp3"?

nope, here is what i found (/proc/sys/dev/sensors/it87-isa-0290/):

-r--r--r--  1 root root 0 Apr 16 08:29 alarms
-rw-r--r--  1 root root 0 Apr 16 08:29 fan1
-rw-r--r--  1 root root 0 Apr 16 08:29 fan2
-rw-r--r--  1 root root 0 Apr 16 08:29 fan3
-rw-r--r--  1 root root 0 Apr 16 08:29 fan_div
-rw-r--r--  1 root root 0 Apr 16 08:29 in0
-rw-r--r--  1 root root 0 Apr 16 08:29 in1
-rw-r--r--  1 root root 0 Apr 16 08:29 in2
-rw-r--r--  1 root root 0 Apr 16 08:29 in3
-rw-r--r--  1 root root 0 Apr 16 08:29 in4
-rw-r--r--  1 root root 0 Apr 16 08:29 in5
-rw-r--r--  1 root root 0 Apr 16 08:29 in6
-rw-r--r--  1 root root 0 Apr 16 08:29 in7
-rw-r--r--  1 root root 0 Apr 16 08:29 in8
-rw-r--r--  1 root root 0 Apr 16 08:29 temp1
-rw-r--r--  1 root root 0 Apr 16 08:29 temp2
-rw-r--r--  1 root root 0 Apr 16 08:29 temp3
-r--r--r--  1 root root 0 Apr 16 08:29 vid


-- 
Dimitrios Michelinakis
www.ionos.gr Web Services

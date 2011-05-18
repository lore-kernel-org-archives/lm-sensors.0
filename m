From: Jeff Rickman <jrickman@myamigos.us>
Date: Wed, 18 May 2011 00:07:45 +0000
Subject: [lm-sensors] EMC6W201 module - Dell Sensors Testing
Message-Id: <4DD30DD1.4080909@myamigos.us>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: lm-sensors@vger.kernel.org



-------- Original Message --------
Date: 	Tue, 17 May 2011 19:50:00 -0400


Download emc6w201 files.
Did not need "i2c-compat.h" file since my kernel > 2.6.32

Output of "uname -a"
Linux XX.xx.xx.xx 2.6.35.12-90.fc14.x86_64 #1 SMP Fri Apr 22 16:01:29
UTC 2011 x86_64 x86_64 x86_64 GNU/Linux
Platform is Dell Precision 670 Workstation with A07 BIOS

CPU info
vendor_id : GenuineIntel
cpu family : 15
model : 4
model name : Intel(R) Xeon(TM) CPU 3.00GHz
stepping : 1
cpu MHz : 750.000 ("cpuspeed" package is enabled)
cache size : 1024 KB

Compile the emc6w201 module
Copy provided "emc6w201.conf" file to "/etc/sensors.d" directory

Run "modprobe -v emc6w201"
No faults on Console. No faults captured to Syslog
Run "sensors". System kicks me out.
Reboot required
Unable to duplicate issue with "sensors"
Reboot

Run "modprobe -v emc6w201" without using "i8k" module
No errors on Console. No errors in Syslog.
"emc6w201" module installs

Selected "lsmod" output
Module Size Used by
emc6w201 8742 0
~SNIP~
i2c_core 27212 6 emc6w201,i2c_i801,nouveau,drm_kms_helper,drm,i2c_algo_bit

Output from "sensors"
emc6w201-i2c-2-2e
Adapter: SMBus I801 adapter at ece0
in0: +1.80 V (min = +1.64 V, max = +1.98 V)
in1: +1.36 V (min = +0.78 V, max = +1.70 V)
+3.3V: +3.38 V (min = +3.08 V, max = +3.52 V)
+5V: +5.08 V (min = +4.66 V, max = +5.34 V)
in4: +1.51 V (min = +1.40 V, max = +1.60 V)
in5: +1.35 V (min = +0.78 V, max = +1.70 V)
fan1: 1498 RPM (min = 300 RPM)
fan2: 1795 RPM (min = 300 RPM)
fan3: 1899 RPM (min = 200 RPM)
fan4: 0 RPM (min = 82 RPM)
fan5: 0 RPM (min = 82 RPM)
temp1: +46.0°C (low = -127.0°C, high = +88.0°C)
temp2: +48.0°C (low = -127.0°C, high = +88.0°C)
temp3: +45.0°C (low = -127.0°C, high = +60.0°C)
temp4: +41.0°C (low = -127.0°C, high = +55.0°C)
temp5: +44.0°C (low = -127.0°C, high = +75.0°C)
Case Temp: +42.0°C (low = -127.0°C, high = +80.0°C)

My own guesses at voltages since I am not near this machine right now...
in0 could be VDIMM since "lshw" reports 400MHz DDR memory
in4 could be +12V and requires a *8 scaling factor.
in1 & in5 could be Vcore lines??

If time permits, I need to carefully check voltage lines inside the 
system with a digital VOM to compare to "sensors" output. Next, I want 
to pull a memory stick or two to see if they are DDR or DDR2. Then I 
need to do "load" experiments in an attempt to identify the physical 
CPUs in the "sensors" output.

Since this system has 2 physical CPU packages and each CPU has
hyperthreading enabled, I wonder which temp sensors from [1-5] would be
useful?

I noticed that "coretemp" does not load on this platform. Perhaps the
platform/CPU/whatever is too old or not instrumented for "coretemp", or 
"coretemp" isn't instrumented for this Intel CPU family?

I will have to inspect this system to see if the physical fans are
3-wire or PWM and what fan headers are on the motherboard and how/if 
they are identified.


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

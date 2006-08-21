From: jim.cromie@gmail.com (Jim Cromie)
Date: Mon, 21 Aug 2006 17:01:07 +0000
Subject: [lm-sensors] [patch 0/3] pc87360 - fix unchecked
Message-Id: <44E9E6D3.3070105@gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <44E72DE7.10907@gmail.com>
In-Reply-To: <44E72DE7.10907@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean Delvare wrote:

< Ive dropped Mark from cc, Im sure he's seen enough from me already ;->

> Jim,
>
>   
>> FWIW -
>> The patchset survived this stress-test:
>>      for i in `seq 1000`; do { rmmod pc87360;  modprobe pc87360;  
>> sensors -s; sensors; }  done
>> It takes about 3.5 secs to re-mod, and about 0.3 sec to reset and query 
>> sensors.
>>     
>
> Given that we aren't suspecting a race condition, this type of test
> isn't really helpful.
Ok, it aint worth much, but it was free ;-)


>  More interesting would be a comparison of the
> contents of /sys/class/hwmon/hwmon0/device before and after the
> patches. If the contents differ, something's wrong, else everything
> should be OK - or at least there is no regression.
>
> Thanks,
>   

Your choice of words leaves me unsure whether this is an observation,
or a requirement.  In any case, its easy, so here it is, plus some other 
observations.

By contents, I assume you mean the files within the dir:

 diff sys-files-2.6.1*
51a52
 > subsystem@


The files contents change each sample, usually on VPWR, but others too.
diffs are always in small fractions of a volt.

Forex:  these 2 samples show some milli-volt noise,
and these are from a 2.6.17 kernel.

pc87366-isa-6620
Adapter: ISA adapter
avi0:      +3.01 V  (min =  +0.00 V, max =  +3.01 V)
VCORE:     +1.99 V  (min =  +0.00 V, max =  +3.01 V)
VCC:       +4.96 V  (min =  +0.00 V, max =  +6.03 V)
VPWR:     +11.88 V  (min =  +5.93 V, max = +28.02 V)
+12V:     +11.74 V  (min =  +0.00 V, max = +14.46 V)
-12V:     -12.97 V  (min = -60.61 V, max =  -2.76 V)
GND:       +0.00 V  (min =  +0.00 V, max =  +3.01 V)
Vsb:       +3.31 V  (min =  +3.00 V, max =  +3.59 V)
Vdd:       +2.93 V  (min =  +3.00 V, max =  +3.59 V)       ALARM
Vbat:      +3.01 V  (min =  +2.40 V, max =  +3.01 V)
AVdd:      +3.28 V  (min =  +3.00 V, max =  +3.59 V)
Temp:       +103 C  (low  =    +0 C, high =  +125 C)
Critical:   +126 C

soekris:/sys/class/hwmon/hwmon0/device# sensors; sensors
pc87366-isa-6620
Adapter: ISA adapter
avi0:      +3.01 V  (min =  +0.00 V, max =  +3.01 V)
VCORE:     +1.99 V  (min =  +0.00 V, max =  +3.01 V)
VCC:       +4.96 V  (min =  +0.00 V, max =  +6.03 V)
VPWR:     +12.12 V  (min =  +5.93 V, max = +28.02 V)
+12V:     +11.74 V  (min =  +0.00 V, max = +14.46 V)
-12V:     -12.97 V  (min = -60.61 V, max =  -2.76 V)
GND:       +0.00 V  (min =  +0.00 V, max =  +3.01 V)
Vsb:       +3.28 V  (min =  +3.00 V, max =  +3.59 V)
Vdd:       +2.95 V  (min =  +3.00 V, max =  +3.59 V)       ALARM
Vbat:      +3.01 V  (min =  +2.40 V, max =  +3.01 V)
AVdd:      +3.28 V  (min =  +3.00 V, max =  +3.59 V)
Temp:       +102 C  (low  =    +0 C, high =  +125 C)
Critical:   +126 C


One other thing / oddity I note (again on old kernel, and new/patched).
Datestamps on the 'files' is not uniform.

soekris:/sys/class/hwmon/hwmon0/device# ll -tr
total 0
< partly snipped >
lrwxrwxrwx 1 root root    0 Aug 20 23:39 driver -> 
../../../../bus/i2c/drivers/pc87360/
lrwxrwxrwx 1 root root    0 Aug 20 23:39 bus -> ../../../../bus/i2c/
-r--r--r-- 1 root root 4096 Aug 20 23:39 name
-r--r--r-- 1 root root 4096 Aug 20 23:39 alarms_in
-r--r--r-- 1 root root 4096 Aug 20 23:39 alarms_temp
-r--r--r-- 1 root root 4096 Aug 20 23:39 in1_input
-r--r--r-- 1 root root 4096 Aug 20 23:39 in10_input
-r--r--r-- 1 root root 4096 Aug 20 23:39 temp1_input
-r--r--r-- 1 root root 4096 Aug 20 23:39 temp6_input
-rw-r--r-- 1 root root 4096 Aug 20 23:39 vrm
-r--r--r-- 1 root root 4096 Aug 20 23:39 cpu0_vid
-r--r--r-- 1 root root 4096 Aug 21 08:04 temp6_status
-rw-r--r-- 1 root root 4096 Aug 21 08:04 temp6_min
-rw-r--r-- 1 root root 4096 Aug 21 08:04 temp5_min
-r--r--r-- 1 root root 4096 Aug 21 08:04 temp4_status

IOW, there are 2 datestamps : Aug 20 23:39  and Aug 21 08:04

After a reboot (to 2.6.17) shows the same 2 sets of files, this time 
with closer stamps.
-r--r--r-- 1 root root 4096 Aug 21 08:42 temp6_input
-r--r--r-- 1 root root 4096 Aug 21 08:42 cpu0_vid
-rw-r--r-- 1 root root 4096 Aug 21 08:42 vrm
-r--r--r-- 1 root root 4096 Aug 21 08:46 temp6_status
-rw-r--r-- 1 root root 4096 Aug 21 08:46 temp6_max

Also, 8:42 is near the bootup time, but not exactly the same.
# uptime
 08:50:13 up 10 min,  1 user,  load average: 3.00, 2.72, 1.54

rmmod & modprobing recreates the files with current & uniform timestamps.




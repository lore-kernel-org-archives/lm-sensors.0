From: grant_lkml@dodo.com.au (Grant Coady)
Date: Sat, 28 May 2005 10:17:35 +0000
Subject: [lm-sensors] Help diagnose ds1780 (adm9240) problem with sensord
Message-Id: <o5ag91pllev4i0aagmp4vg6raus0raal74@4ax.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi there,

Story so far, test user with a pair of ds1780 chips, patch posted 
early today fixed main issue, (user patched/install 2.9.1) another 
issue:

>sensors -u gives:
>ERROR: Can't get feature `vid' data!
>alarms: 4096.00 (alarms)
>ERROR: Can't get feature `analog_out' data!

is already fixed in CVS lm_sensors2, referred user to that download,

o o o

third issue is with sensord, and I'm lost -- where to start?:

quoting from test user:

   I edited chips.c  in the lmsensors lib, and rebuilt.
   Cleaned out the distro (Mandrake 10.1) libsensors and sensors stuff.
   Installed the rebuilt 2.9.1
   
    sensors ds1780-* produces

    ds1780-i2c-0-2d
Adapter: SMBus I801 adapter at ccd0
2.5v:      +0.99 V  (min =  +0.00 V, max =  +2.00 V)   
V1:        +1.48 V  (min =  +1.41 V, max =  +1.60 V)   
3.3v:      +3.30 V  (min =  +3.08 V, max =  +3.52 V)   
5v:        +3.33 V  (min =  +3.10 V, max =  +3.52 V)   
12v:      +11.94 V  (min = +10.25 V, max = +13.75 V)   
V2:        +1.79 V  (min =  +1.69 V, max =  +1.91 V)   
F1:          0 RPM  (min =    0 RPM, div = 8)          
F2:          0 RPM  (min =    0 RPM, div = 8)          
T1:        +38.0?C  (high =  +127?C, hyst =   +13?C)   
alarms:   Chassis intrusion detection                  ALARM

ds1780-i2c-0-2c
Adapter: SMBus I801 adapter at ccd0
2.5v:      +2.51 V  (min =  +2.33 V, max =  +2.67 V)   
V1:        +1.67 V  (min =  +1.57 V, max =  +1.80 V)   
3.3v:      +1.50 V  (min =  +1.39 V, max =  +1.60 V)   
5v:        +5.00 V  (min =  +4.66 V, max =  +5.34 V)   
12v:      +11.88 V  (min = +10.25 V, max = +13.75 V)   
V2:        +1.98 V  (min =  +0.00 V, max =  +3.59 V)   
F1:       1940 RPM  (min =  703 RPM, div = 8)          
F2:       1896 RPM  (min =  703 RPM, div = 8)          
T1:        +43.0?C  (high =  +127?C, hyst =   +10?C)   
alarms:   Chassis intrusion detection                  ALARM

  Much better.

sensord stll fails with:

May 27 20:01:54 harpo sensord: Chip: ds1780-i2c-0-2d
May 27 20:01:54 harpo sensord: Adapter: SMBus I801 adapter at ccd0
May 27 20:01:54 harpo sensord: Algorithm: Unavailable from sysfs
May 27 20:01:54 harpo sensord:   2.5v: +1.00 V (min = +0.00 V, max = +2.00 V)
May 27 20:01:54 harpo sensord:   V1: +1.48 V (min = +1.41 V, max = +1.60 V)
May 27 20:01:54 harpo sensord:   3.3v: +3.30 V (min = +3.08 V, max = +3.52 V)
May 27 20:01:54 harpo sensord:   5v: +3.33 V (min = +3.10 V, max = +3.52 V)
May 27 20:01:54 harpo sensord:   12v: +11.94 V (min = +10.25 V, max = +13.75 V)
May 27 20:01:54 harpo sensord:   V2: +1.79 V (min = +1.69 V, max = +1.91 V)
May 27 20:01:54 harpo sensord:   F1: 0 RPM (min = 0 RPM, div = 8)
May 27 20:01:54 harpo sensord:   F2: 0 RPM (min = 0 RPM, div = 8)
May 27 20:01:54 harpo sensord:   T1: 38.0 C (limit = 127 C, hysteresis = 13 C)
May 27 20:01:54 harpo sensord: Error getting sensor data: ds1780/#61: Can't access procfs/sysfs file
May 27 20:01:54 harpo sensord: sensord failed
unquote

I'm stuck on this one at the moment.  Any clues?

Thanks,
--Grant.


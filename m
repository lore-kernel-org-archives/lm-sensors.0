From: baileych@mail.med.upenn.edu (Charles Bailey)
Date: Thu, 19 May 2005 06:24:12 +0000
Subject: Ticket 1288
Message-Id: <2740000.1060888347@abrmsn274.med.upenn.edu>
List-Id: <lm-sensors.vger.kernel.org>
References: <2147483647.1056216687@abrmsn288.med.upenn.edu>
In-Reply-To: <2147483647.1056216687@abrmsn288.med.upenn.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

--On Wednesday, August 13, 2003 01:20:30 AM +0200 Jean Delvare 
<khali@linux-fr.org> wrote:

>
>> This does get a sensor running; it reports CPU temps of ~60 C.  When
>> I finally had a chance to take the server down and check via the
>> BIOS, it reported temps in the mid-30s.
>>
>> The voltages and fan speeds reported via i2c seem to be reasonable
>> numbers.
>
> If you aren't using 2.8.0 yet, upgrading could help (and at least we'll
> make sure we aren't trying to fix a bug that was already corrected).

OK, I've installed 2.8.0, which auto-detects the sensor, but still seems to 
have problems with the temp:

[root@xxx rc.d]# /usr/local/bin/sensors
eeprom-i2c-0-50
Adapter: SMBus AMD75x adapter at 06e0
Algorithm: Non-I2C SMBus adapter

eeprom-i2c-0-51
Adapter: SMBus AMD75x adapter at 06e0
Algorithm: Non-I2C SMBus adapter
Machine name:
H
Serial number:
H

w83627hf-isa-0290
Adapter: ISA adapter
Algorithm: ISA algorithm
VCore 1:   +1.71 V  (min =  +1.74 V, max =  +1.93 V)       ALARM
VCore 2:   +2.49 V  (min =  +1.74 V, max =  +1.93 V)
+3.3V:     +3.28 V  (min =  +3.13 V, max =  +3.45 V)
+5V:       +4.94 V  (min =  +4.72 V, max =  +5.24 V)
+12V:     +12.27 V  (min = +10.79 V, max = +13.19 V)
-12V:     -12.70 V  (min = -13.21 V, max = -10.90 V)
-5V:       -5.01 V  (min =  -5.26 V, max =  -4.76 V)
V5SB:      +5.39 V  (min =  +4.72 V, max =  +5.24 V)       ALARM
VBat:      +3.48 V  (min =  +2.40 V, max =  +3.60 V)       ALARM
fan1:        0 RPM  (min = 3000 RPM, div = 2)
fan2:     4500 RPM  (min = 3000 RPM, div = 2)
fan3:     5400 RPM  (min = 3000 RPM, div = 2)
temp1:       +25C  (limit =  +60C)                       sensor = thermistor
temp2:     +58.5C  (limit =  +60C, hysteresis =  +50C) sensor = PII/Celeron 
diode   ALARM
temp3:     +60.0C  (limit =  +60C, hysteresis =  +50C) sensor = PII/Celeron 
diode   ALARM
vid:      +1.850 V
alarms:
beep_enable:
          Sound alarm disabled

[root@xxx rc.d]# uname -a
Linux xxx.med.upenn.edu 2.4.20-19.9smp #1 SMP Tue Jul 15 16:45:28 EDT 2003 
i686 athlon i386 GNU/Linux
[root@xxx rc.d]#

The BIOS reported the CPU temps as 35 and 38 about twenty minutes previous 
when I rebooted to install a new kernel.

I'm happy to do further testing if you have any suggestions.


--
Regards,
Charles Bailey  < baileych _at_ mail _dot_ med _dot_ upenn _dot_ edu >
Fellow, Pediatric Hematology/Oncology
Children's Hospital of Philadelphia/University of Pennsylvania

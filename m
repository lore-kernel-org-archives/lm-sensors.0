From: roy@karlsbakk.net (Roy Sigurd Karlsbakk)
Date: Sun, 16 Apr 2006 17:06:17 +0000
Subject: [lm-sensors] ridicolous sensors output?
Message-Id: <5479039B-0E3D-4CAB-BBFC-336A47FB0229@karlsbakk.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <F2CFFC9F-4DC4-4DBA-BDEB-C195DBCAD479@karlsbakk.net>
In-Reply-To: <F2CFFC9F-4DC4-4DBA-BDEB-C195DBCAD479@karlsbakk.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

>> Next adapter: SMBus I801 adapter at 0500
>> (...)
>> Client found at address 0x2f
>> (...)
>> Probing for `Winbond W83792D'... Success!
>>     (confidence 7, driver `to-be-written'), other addresses: 0x4b  
>> 0x4f
>
> OK, that's your hardware monitoring chip. sensors-detect thinks there
> is no driver for it, but by now, there is. Try:
>   rmmod w83627hf
>   modprobe i2c-i801
>   modprobe w83792d
> And sensors output should be better.
>
> However, user-space support for that chip was just added in lm_sensors
> 2.9.1 and many bugs have been fixed since, so you are invited to  
> update
> lm_sensors to a later version for better results.

works like a dream :)

only, see below, I can't get fan6 data. can this be due to some other  
error? Also, temp2 shows ALARM where the data looks ok, and temp3 is  
still -48.5 degrees, and, beleive me, it's not that cold :)

# sensors
w83792d-i2c-0-2f
Adapter: SMBus I801 adapter at 0500
VCoreA:    +1.34 V  (min =  +0.00 V, max =  +2.04 V)
VCoreB:    +1.37 V  (min =  +0.00 V, max =  +2.04 V)
VIN0:      +3.38 V  (min =  +0.00 V, max =  +4.08 V)
VIN1:      +3.11 V  (min =  +0.00 V, max =  +4.08 V)
VIN2:      +1.53 V  (min =  +0.00 V, max =  +4.08 V)
VIN3:      +2.60 V  (min =  +0.00 V, max =  +4.08 V)
5VCC:      +5.07 V  (min =  +0.00 V, max =  +6.12 V)
5VSB:      +5.03 V  (min =  +0.00 V, max =  +6.12 V)
VBAT:      +3.20 V  (min =  +0.00 V, max =  +4.08 V)
Fan1:     9507 RPM  (min =    0 RPM, div = 2)
Fan2:     9642 RPM  (min =    0 RPM, div = 2)
Fan3:     6553 RPM  (min =    0 RPM, div = 2)
Fan4:     6887 RPM  (min =    0 RPM, div = 2)
Fan5:     9000 RPM  (min =    0 RPM, div = 2)
ERROR: Can't get FAN6 data!
Fan7:     9246 RPM  (min =    0 RPM, div = 2)
Temp1:     +40.0 C  (high = +127.0 C, hyst =  +0.0 C)
Temp2:     +36.5 C  (high = +80.0 C, hyst = +75.0 C)   ALARM
Temp3:     -48.5 C  (high = +80.0 C, hyst = +75.0 C)   ALARM
chassis:  Chassis intrusion detection                  ALARM

again thanks a lot

roy
--
Roy Sigurd Karlsbakk
roy at karlsbakk.net
---
In space, loud sounds, like explosions, are even louder because there  
is no air to get in the way.




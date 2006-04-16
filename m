From: khali@linux-fr.org (Jean Delvare)
Date: Sun, 16 Apr 2006 17:19:27 +0000
Subject: [lm-sensors] ridicolous sensors output?
Message-Id: <20060416191927.68834571.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <F2CFFC9F-4DC4-4DBA-BDEB-C195DBCAD479@karlsbakk.net>
In-Reply-To: <F2CFFC9F-4DC4-4DBA-BDEB-C195DBCAD479@karlsbakk.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> works like a dream :)
> 
> only, see below, I can't get fan6 data. can this be due to some other  
> error? Also, temp2 shows ALARM where the data looks ok, and temp3 is  
> still -48.5 degrees, and, beleive me, it's not that cold :)
> 
> # sensors
> w83792d-i2c-0-2f
> Adapter: SMBus I801 adapter at 0500
> VCoreA:    +1.34 V  (min =  +0.00 V, max =  +2.04 V)
> VCoreB:    +1.37 V  (min =  +0.00 V, max =  +2.04 V)
> VIN0:      +3.38 V  (min =  +0.00 V, max =  +4.08 V)
> VIN1:      +3.11 V  (min =  +0.00 V, max =  +4.08 V)
> VIN2:      +1.53 V  (min =  +0.00 V, max =  +4.08 V)
> VIN3:      +2.60 V  (min =  +0.00 V, max =  +4.08 V)
> 5VCC:      +5.07 V  (min =  +0.00 V, max =  +6.12 V)
> 5VSB:      +5.03 V  (min =  +0.00 V, max =  +6.12 V)
> VBAT:      +3.20 V  (min =  +0.00 V, max =  +4.08 V)
> Fan1:     9507 RPM  (min =    0 RPM, div = 2)
> Fan2:     9642 RPM  (min =    0 RPM, div = 2)
> Fan3:     6553 RPM  (min =    0 RPM, div = 2)
> Fan4:     6887 RPM  (min =    0 RPM, div = 2)
> Fan5:     9000 RPM  (min =    0 RPM, div = 2)
> ERROR: Can't get FAN6 data!

Some pins of the W83792D chip can be used for different purposes. In
your case, the fan6 pin is indeed used for something different so the
w83792d kernel driver did not create an interface for that fan.
"sensors" should ignore missing interface files in this case, but the
version you have did not. This was fixed in CVS recently.

You may try to add an "ignore fan6" statement in your configuration
file.

> Fan7:     9246 RPM  (min =    0 RPM, div = 2)
> Temp1:     +40.0 C  (high = +127.0 C, hyst =  +0.0 C)
> Temp2:     +36.5 C  (high = +80.0 C, hyst = +75.0 C)   ALARM

Looks like a known bug, fixed in lm_sensors 2.9.2.

> Temp3:     -48.5 C  (high = +80.0 C, hyst = +75.0 C)   ALARM

-48 degrees C is a typical value for unconnected thermal sensors. You
can probably just ignore that input ("ignore temp3").

> chassis:  Chassis intrusion detection                  ALARM

-- 
Jean Delvare


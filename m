From: cezarym@pf.pl (Cezary Morga)
Date: Thu, 19 May 2005 06:25:13 +0000
Subject: lm_sensors ain't updating cpu temp
Message-Id: <1093854285.3748.12.camel@84.xa.interkam.pl>
List-Id: <lm-sensors.vger.kernel.org>
References: <1093792983.3809.5.camel@84.xa.interkam.pl>
In-Reply-To: <1093792983.3809.5.camel@84.xa.interkam.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

W li?cie z nie, 29-08-2004, godz. 17:42, Jean Delvare pisze: 
> > I've got this problem with lm_sensors that it doesn't update my cpu
> > temperature, though my mibi temp is constantly updated, which leads to
> > mibi's temp getting bigger that cpu's.
> > 
> > I'm using lm_sensors 2.8.5 with 2.6.3-7mdk kernel.
> 
> Which driver ? Which chip ? Anything relevant in the logs? Sample output
> from "sensors" ?

I don't know what do you mean saying 'driver'. The chipset is VIA
VT8233A. I don't know where to find logs (I'm a real newbie).
Here's the sample output :

w83697hf-isa-0290
Adapter: ISA adapter
VCore:     +1.79 V  (min =  +1.71 V, max =  +1.89 V)
+3.3V:     +3.30 V  (min =  +3.14 V, max =  +3.46 V)
+5V:       +4.76 V  (min =  +4.73 V, max =  +5.24 V)       ALARM
+12V:     +12.65 V  (min = +10.82 V, max = +13.19 V)
-12V:     -12.85 V  (min = -13.18 V, max = -10.88 V)
-5V:       -5.55 V  (min =  -5.25 V, max =  -4.75 V)       ALARM
V5SB:      +5.48 V  (min =  +4.73 V, max =  +5.24 V)
VBat:      +3.25 V  (min =  +2.40 V, max =  +3.60 V)
fan1:     4245 RPM  (min =   -1 RPM, div = 2)              ALARM
fan2:        0 RPM  (min = 5273 RPM, div = 2)              ALARM
temp1:       +39?C  (high =    +0?C, hyst =  +105?C)   sensor thermistor   ALARM
temp2:     +53.5?C  (high =  +120?C, hyst =  +115?C)   sensor thermistor
alarms:
beep_enable:
          Sound alarm disabled

eeprom-i2c-0-50
Adapter: SMBus Via Pro adapter at 5000
Memory type:            DDR SDRAM DIMM
Memory size (MB):       256

Though I had to use module w83781d instead of w83697hf (which isn't
supported in my kernel version, right?)

> If you have the possibility to upgrade kernels (and lm_sensors) I would
> try that, since 2.6.3 is somewhat old now.

I was told that the latest stable kernel version for mandrake10.0
official is 2.6.3-15mdk (once again: I'm a newbie) so I don't believe
that the upgrade could change something.
-- 
Cezary Morga <cezarym@pf.pl>
Registered Linux User No. 362185 <http://counter.li.org>
GG# 169903 ICQ# 328-700-565 Jabber: thereidos@ebox.pl

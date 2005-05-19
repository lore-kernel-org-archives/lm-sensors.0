From: gilbertd@treblig.org (Dr. David Alan Gilbert)
Date: Thu, 19 May 2005 06:23:26 +0000
Subject: lm-sensors - hangs on Tyan Tiger S2460 motherboard
Message-Id: <20011125202705.A612@gallifrey>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,
  I'd like to report that the lmsensors package 2.6.1-3 (-3 is the
debian package no.) doesn't like my Tyan Tiger S2460 motherboard. It is
a dual Athlon.

sensors-detect works and detects the 'SMBus AMD7X6 adapter at 80e0'
adapter which shows up in /proc/bus/i2c.

It detects and tells me to load the w83781d module.  Unfortunatly when
this loads it hangs the machine solid (no keyboard, nothing).

At boot time when it tries to load this it gives the:

  'W83782D subclient] reg to adapter [SMBus AMD7x6 adapter' at 80e0
  (pos. 2)'

(Typed from scrawlings in my note book...) I get a message for pos.0 and
pos.1 before this. Then it hangs.

When sensors-detect runs it detects that device with a confidence of 8;
it also detects (with a confidence of 3 listing as misdetects) LM75's
at 48 and 49 on the SMBus.

/proc/sys/dev/sensors lists three eeprom's :

dg@gallifrey:/proc/sys/dev/sensors$ cat chips 
256	eeprom-i2c-0-50
257	eeprom-i2c-0-51
258	eeprom-i2c-0-54

(It gave high confidence in two of those being my two DIMMs - gave lower
confidence in the last one being a dimm; it isn't - I only have 3).

Thanks in advance for any ideas,

Dave
 ---------------- Have a happy GNU millennium! ----------------------   
/ Dr. David Alan Gilbert    | Running GNU/Linux on Alpha,68K| Happy  \ 
\ gro.gilbert @ treblig.org | MIPS,x86,ARM, SPARC and HP-PA | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/

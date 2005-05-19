From: ben@bdlow.net (Ben Low)
Date: Thu, 19 May 2005 06:23:32 +0000
Subject: ALiM1535D+ w/ i2c-ali1535.o: Error: command never completed
Message-Id: <200205041121.g44BLJD28499@Stimpy.netroedge.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hello,

I've an IWill XP333 motherboard with a ALiM1535D+ southbridge, and am
attempting to get lm_sensors-2.6.3 working.

sensors-detect probes the i2c-ali1535 driver, and goes on to pick up a
lm78 and others (see below). However:

 1) the lm78 temp never changes: /proc/sys/dev/sensors/lm78-i2c-0-2c/temp
reads "60.0 50.0 43.0" and never changes
 2) dmesg notes repeated "i2c-ali1535.o: Error: command never completed"
messages one or more times after every "access".

Also, sensors-detect seems to detect a different subset of devices each 
time; that is it always detects the lm78, but sometimes detects a lm75,
eeprom, or adm1021. "Sometimes" = different every time I run it.

It appears the ALiM1535D+ isn't supported, are there plans to? Anything I
can do to help (testing, etc?)

Regards,

--
Ben Low
"Glory is fleeting, but obscurity is forever."
	- Napoleon Bonaparte (1769-1821)

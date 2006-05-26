From: khali@linux-fr.org (Jean Delvare)
Date: Fri, 26 May 2006 10:15:18 +0000
Subject: [lm-sensors] decode-dimms.pl updated
Message-Id: <20060526121518.210a7444.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi all,

Rudolf Marek and I reworked the decode-dimms.pl script quite a lot in
the past few weeks. Now it supports DDR SDRAM and DDR2 SDRAM modules.
It's less verbose for those than for SDRAM, but this may not be a
problem (who really cares about all the details?). It has size decoding
support for Rambus too, but this is untested. As far as I know, memory
module size decoding is the last thing which was missing in our eeprom
scripts compared to "sensors". This means we are ready to drop eeprom
support from libsensors and sensors.

I also tried to improve the output a bit so that it's more
user-friendly, and we fixed a few bugs here and there too. Everyone is
invited to test and report if something doesn't look right. I've
updated our online example here:
http://secure.netroedge.com/~lm78/decode-dimms.html

Next steps:
* Test the less frequent configurations (Rambus for example.)
* Improve the non-SDRAM parts. Anyone interested can do that. We may
  want to add different levels of verbosity in the future, so that
  people can get only the more important characteristics or the full
  list, depending on their needs.
* Drop eeprom support from libsensors and sensors (lm_sensors 2.10.2)

Thanks,
-- 
Jean Delvare


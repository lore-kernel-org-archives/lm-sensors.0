From: khali@linux-fr.org (Jean Delvare)
Date: Fri, 04 Aug 2006 10:11:09 +0000
Subject: [lm-sensors] Strange problem with lm-sensors and module eeprom
Message-Id: <20060804121109.867d66ea.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <44D31A26.3000103@gmx.de>
In-Reply-To: <44D31A26.3000103@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Matthias,

> i have a strange problem with lm-sensors and the eeprom module.
> On my Tyan Mainboard (S5350) I get all values of the temperature and fan 
> sensors, but the memory modules are not listed on the output of sensors.
> 
> The problem is that in /sys/bus/i2c/drivers/eeprom for every memory 
> module an entry exists and therefore the output of decode-dimms.pl 
> delivers the correct informations about the memory.
> 
> Thus I think there should be a problem with the sensors program or maybe 
> with the config file.

No, this is a change we made on purpose. There is a note about that in
the CHANGES document for release 2.10.0:

Library: NOTE: libsensors(3) will no longer see eeprom (SPD) chips
         This is intentional.  Use decode-dimms.pl if you still
         need your memory SPD data.

The rationale is that EEPROMs are not sensors, so they didn't belong to
libsensors in the first place.

-- 
Jean Delvare


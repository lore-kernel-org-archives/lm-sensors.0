From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:23:49 +0000
Subject: help?
Message-Id: <20030228105631.46152599.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <Pine.LNX.4.44.0302252341500.5703-100000@localhost.localdomain>
In-Reply-To: <Pine.LNX.4.44.0302252341500.5703-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


[PLEASE REPLY TO THE LIST, NOT TO ME ALONE]

> > Well, it's not that wrong. The incorrect values may just mean you
> > don't have the sensor and you have to ignore the value. Having a
> > look "in the BIOS" sometimes show which sensors your motherboard is
> > supposed to have.
> 
> Thank you for the swift answer.
> The BIOS says nothing but reports quite different values for
> temperatures and fan's rpms w.r.t. the sensors command. Also some
> voltage is off limits. By the way, is it conceivable to read data
> directly from the bios or is the bios completely inactive when the
> linux kernel runs? 

As far as I know, the "BIOS" does just what we do with i2c/lm_sensors
for Linux. I don't think there's anything like "reading data directly
from the BIOS". If you don't have the same results between the BIOS and
lm_sensors, then there's somethinhg wrong and it needs fixin'. There are
two possibilities. Either the driver is OK but the resistors are
different on this motherboard, so you have to tweak the formula to get
the right value. Or the driver isn't working for you. Both cases,
there's almost nothing we can do until you investigate and give us
valuable information to start from (either from the motherboard docs or
experimental). So, if you want us to fix the problem, please gather as
much information as possible and let us know.

> > You have to edit /etc/sensors.conf. Look for "w83627hf" and you
> > should find where to change it a few dozen lines below. However, it
> > is supposed to work with 782d/783s only. You still can give it a
> > try, though.
> 
> I edited those lines but the readings do not change, including the 
> statement that sensors are  PII Celeron diodes. 

Didn't you forget to issue a "sensors -s" (as root) after editing the
config file?

> By the way, sensors-detect says it find also some eeprom chips (and
> twice with the same confidence level 8 of the w83627hf. But when I
> insert the eeprom module in the kernel, noting is read:
> 
> eeprom-i2c-0-50
> Adapter: SMBus AMD7X6 adapter at 80e0
> Algorithm: Non-I2C SMBus adapter
> 
> eeprom-i2c-0-51
> Adapter: SMBus AMD7X6 adapter at 80e0
> Algorithm: Non-I2C SMBus adapter
> 
> eeprom-i2c-0-54
> Adapter: SMBus AMD7X6 adapter at 80e0
> Algorithm: Non-I2C SMBus adapter
> 
> Does that simply mean that sensors-detect is fooled or the problem is
> that no specifications are provided in /etc/sensors.conf? I have other
> dual motherboards in a cluster where only the eeprom and no w83627hf
> are reported by sensors-detect. 

It probably means that it doesn't recognize the kind of EEPROM it found.
Usually, EEPROMS are found on memory chips. We've also seen proprietary
EEPROMs on some laptops (namely Sony Vaio). Is this system a laptop (or
a desktop of some brand)?

You may want to dump the EEPROM's contents to guess what it may be. To
do this, unload the eeprom module (rmmod eeprom), then run the following
commands:

i2cdump 0 0x50
i2cdump 0 0x51
i2cdump 0 0x54

> Thank you again.

You're welcome.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/

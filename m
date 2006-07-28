From: khali@linux-fr.org (Jean Delvare)
Date: Fri, 28 Jul 2006 13:23:53 +0000
Subject: [lm-sensors] No sensors with Lenovo 3000 v100 laptop (SMBus
Message-Id: <20060728152353.7346e51e.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Dimitar,

Moving to the sensors list, as this is not an i2c issue.

> I have Lenovo 3000 v100 laptop with Intel Core Duo T2500
> CPU, and trying to use i2c & lm_sensors for monitoring the
> CPU temperature.
> However I do not have any success so far.
> When I run sensors it says No sensors found, even though
> sensors-detect lists eeprom.

EEPROMs are data storage chips, not sensors. sensors-detect lists them
because they are on the I2C bus and sensors can live on this bus too,
and we have been hosting the eeprom driver.

It seems to confuse lots of users for years, so I'll edit
sensors-detect to make it clear that EEPROMs are not sensors.

> I do not want to believe that there is not a way to check the CPU
> temperature / there are not sensors on the motherboard... it would
> be very odd if this is the case.
> 
> Below is the output from lspci, sensors-detect and sensors.
> 
> Is there anything I can try and see why no sensors are found?
> Am I missing something?

No, there actually doesn't seem to be any hardware monitoring chip on
your system. The I2C (actually SMBus) bus driver works fine, but there
are no hardware monitoring chips connected to it. And there is no
known Super-I/O chip either. It isn't uncommon at all for laptops - in
fact most laptops don't have accessible hardware monitoring chips.

You should try ACPI instead. Load the "thermal" and "fan" drivers, and
look in the /proc/acpi/thermal_zone and /proc/acpi/fan directories,
respectively. It's nowhere next to what lm_sensors can offer on
supported systems, but better than nothing. On both laptops I have,
this is the only way to get the system temperature.

You could also contact Lenovo for technical information, just in case.

-- 
Jean Delvare


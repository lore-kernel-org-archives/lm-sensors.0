From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:30 +0000
Subject: sensors on Acer TM427LC
Message-Id: <20031217230016.1d2f7636.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <200312170127.30400.enrico_tux@yahoo.it>
In-Reply-To: <200312170127.30400.enrico_tux@yahoo.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> I've an Acer TravelMate 427LC, my acpi can't get thermal state and 
> sensors-detect recognize just an eeprom... i contacted Acer, but they
> wont tell me sensors on my pc...

What would you expect from a hardware manufacturer support? ;)

> they just told me that it implements
> acpi v1.0b... I know, it's not much pleasuring... Well, i would like
> to know if there is a way to try to detect my sensors and write driver
> for them...

Which version of lm_sensors have you been trying? If a recent version of
sensors-detect did find unknown chips, we might help. If not, there's
probably nothing we can do. If in doubt, please provide the output of
"i2cdetect 0".

On my own laptop there's no sensor chip lm_sensors can deal with. All I
have is one temperature sensors those temperature is reported by ACPI.
If you did not try this already, enable ACPI and Thermal Zone in ACPI.
If your laptop supports it, you should be able to get the temperature
from /proc/acpi/thermal_zone/XXXX/temperature (XXXX depends on the
system).

> The chipset identification from Intel says it's a i845MP/MZ...

This is the chipset that handle the bus, not the sensor chip. I too have
support for the bus, but alas nothing on it except eeproms.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/

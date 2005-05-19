From: shawn.starr@datawire.net (Shawn Starr)
Date: Thu, 19 May 2005 06:23:47 +0000
Subject: False IBM Laptop detection - PIIX4 (440BX) - IBM 300PL 6892-N2U Tower desktop - lm_sensors 2.7.0 /w
Message-Id: <200302071048.27227.shawn.starr@datawire.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


I have an IBM 300PL 6892-N2U just picked it up yesterday but lm_sensors 2.7.0 
refuses to load anything!

I am using a Tower desktop not a laptop unless this is a defunked bios?

Let me know what info you need from me.

Shawn.

--------------------------

from sensors-detect:

 BIOS vendor (ACPI): IBM
 System vendor (DMI): IBM
 BIOS version (DMI): NVKT48AUS
 Sorry, we won't let you go on. IBM systems are known to have
 serious problems with lm_sensors, resulting in hardware failures.
 For more information, see README.thinkpad or
 http://www2.lm-sensors.nu/~lm78/cvs/lm_sensors2/README.thinkpad.

---

from dmesg:

i2c-piix4.o version 2.7.0 (20021208)
i2c-piix4.o: Found PIIX4 device
dmi_scan.o version 2.7.0 (20021208)
dmi_scan.o: SM BIOS found
i2c-piix4.o: IBM Laptop detected; this module may corrupt
             your serial eeprom! Refusing to load module!
i2c-piix4.o: Module insertion failed.
-- 
Shawn Starr
UNIX Systems Administrator, Operations
Datawire Communication Networks Inc.
10 Carlson Court, Suite 300
Toronto, ON, M9W 6L2
T: 416-213-2001 ext 179  F: 416-213-2008
shawn.starr@datawire.net
"The power to Transact" - http://www.datawire.net

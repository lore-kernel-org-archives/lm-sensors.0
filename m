From: James Mills <jameswmills@gmail.com>
Date: Wed, 16 Feb 2011 15:31:12 +0000
Subject: [lm-sensors] Using dme1737 to read sensor data when an ACPI
Message-Id: <AANLkTikYuVDyhet3uT7u1Vivw908C31wsqfp=wg0qgkd@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

All,

I am working on a project with a SCH3114.  By default, when I modprobe
dme1737, it fails with an ACPI conflict.  In the short term, I have
added "acpi_enforce_resources=lax", and the module now loads and
sensors are displayed.

However, I am concerned with the dmesg:

ACPI: resource dme1737 [io  0x0a70-0x0a71] conflicts with ACPI region
RNTR [??? 0x00000a00-0x00000a7f flags 0x52]
ACPI: This conflict may cause random problems and system instability

All we want is for the sensor data provided by this module to be
polled periodically.

Can anyone tell me what the real risk is of using this module in
conjunction with "lax" ACPI?  Is there a way to put this module in
"read-only" mode or some other mode that minimizes the potential for
system instability?

Any information is appreciated!
~james

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

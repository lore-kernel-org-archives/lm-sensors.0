From: Stefan Richter <stefanr@s5r6.in-berlin.de>
Date: Sun, 05 Aug 2007 11:20:48 +0000
Subject: [lm-sensors] 2.6.23-rc1 regression: hwmon/w83627ehf: wrong fan speed
Message-Id: <46B5B290.4040907@s5r6.in-berlin.de>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@lm-sensors.org
Cc: linux-kernel@vger.kernel.org, "Mark M. Hoffman" <mhoffman@lightlink.com>, Jean Delvare <khali@linux-fr.org>

Now that I booted from 2.6.22-rc5 to 2.6.23-rc2 I noticed that ksensors
displayed 1/16 of the actual speed of the CPU fan (correct is ca. 1400
RPM under light load) and 0 for the case fan (correct is ca. 480 RPM
under light load).

I reverted patch
	hwmon/w83627ehf: No need to initialize fan_min
and the behaviour changed as follows:  ksensors displays the correct CPU
fan speed when loaded for the first time after the w83627ehf was loaded,
then drops to 1/16th the next time it refreshes the display.  (I
configured 30s update interval in ksensors.)  But the case fan's speed
is now correctly displayed all the time.  Ksensors' fan speed
multipliers are configured as 1.

I then also reverted
	hwmon/w83627ehf: Be quiet when no chip is found
	hwmon/w83627ehf: Export the thermal sensor types
	hwmon/w83627ehf: Enable VBAT monitoring
	hwmon/w83627ehf: Add support for the VID inputs
	hwmon/w83627ehf: Fix timing issues
	hwmon/w83627ehf: Add error messages for two error cases
one after another but it didn't change anything.  More surprisingly, if
I put all patches including "No need to initialize fan_min" back in, the
behaviour remains like after referting that single patch, i.e. wrong CPU
fan speed after first display update, correct case fan speed.  I didn't
reboot between tests though, I only unloaded and reloaded w83627ehf.

I wasn't able to revert
	hwmon/w83627ehf: Convert to a platform driver
to something that compiles but I didn't try very hard.

Kernel messages when I load the drivers:
w83627ehf: unsupported chip ID: 0xffff
w83627ehf: Found W83627EHG chip at 0x290
The former message is normally suppressed by patch "Be quiet when no
chip is found".  Mainboard is an MSI 945GT Speedster-A4R, userland is
Gentoo's lm_sensors-2.10.1 and ksensors-0.7.3.

Booting back into 2.6.22-rc5 (which seems identical with 2.6.22 as far
as w83627ehf is concerned) brings back the correct fan speeds.
-- 
Stefan Richter
-===-=-== =--- --=-http://arcgraph.de/sr/

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

From: aurelien@aurel32.net (Aurelien Jarno)
Date: Thu, 19 May 2005 06:25:43 +0000
Subject: 2.6 chips documentation
Message-Id: <20050313011342.GA23097@bode.aurel32.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Rudolf,

Please find below my comments about, your patch to include chips
documentation into the 2.6 kernel. I am sorry to send it only now, I
have been very busy for days. 

When I have more time, I will backport all the changes that have been 
done on the documentation to i2c/lm-sensors.

Bye,
Aurelien



diff -Naur a/Documentation/i2c/chips/adm1021 b/Documentation/i2c/chips/adm1021
--- a/Documentation/i2c/chips/adm1021	1970-01-01 01:00:00.000000000 +0100
+++ b/Documentation/i2c/chips/adm1021	2005-03-04 23:15:19.101263472 +0100
+Description
+-----------
+
+The chips supported by this driver are very similar. The Maxim MAX1617 is
+the oldest; it has the problem that it is not very well detectable. The
+MAX1617A solves that.  The ADM1021 is a straight clone of the MAX1617A.
+Ditto for the THMC10. From here on, we will refer to all these chips as
+ADM1021-clones.
+
+ADM1021-clones implement two temperature sensors. One of them is internal,
+and measures the temperature of the chip itself; the other is external and
+is realised in the form of a transistor-like device. A special alarm
+indicates whether the remote sensor is connected.
+
+Each sensor has its own low and high limits. When they are crossed, the 
+corresponding alarm is set and remains on as long as the temperature stays 
+out of range. Temperatures are measured in degrees Celcius. Measurements 
+are possible between -65 and +127 degrees, with a resolution of one degree.
+
+The ADM1021 reports a die code, which is a sort of revision code. This can
+help us pinpoint problems; it is not very useful otherwise.
Is it the ADM1021 or ADM1021-clones? Anyway, this part would be better 
two paragraphs above.

+If an alarm triggers, it will remain triggered until the hardware register
+is read at least once. This means that the cause for the alarm may already
+have disappeared!
diff -Naur a/Documentation/i2c/chips/adm1026 b/Documentation/i2c/chips/adm1026
--- a/Documentation/i2c/chips/adm1026	1970-01-01 01:00:00.000000000 +0100
+++ b/Documentation/i2c/chips/adm1026	2005-03-04 23:15:26.106198560 +0100

+Description
+-----------

+Voltage sensors (in0 to in16) report their values in volts.  An alarm is
Where the voltages could be seen in volts? AFAIK the value in /sys are in 
millivolts.

diff -Naur a/Documentation/i2c/chips/ds1621 b/Documentation/i2c/chips/ds1621
--- a/Documentation/i2c/chips/ds1621	1970-01-01 01:00:00.000000000 +0100
+++ b/Documentation/i2c/chips/ds1621	2005-03-04 23:15:35.725736168 +0100
+degree Celsius to +125 in 0.5 increments. You may convert this into a
+Fahrenheit range of -67 to +257 degrees with 0.9 steps. Unfortunally
+though, you will need a hash table or even a conversion routine for that.
I suppose this comes from the datasheet, but does it make sense here?

+Default values written into the DS1621 upon detection are:
+Temperature limits: High 60.0; low 0.0 degree Celsius;
+Continuous mode (not enabled), Tout active high, alarms reset.
This isn't true anymore, so that part should be removed.
diff -Naur a/Documentation/i2c/chips/eeprom b/Documentation/i2c/chips/eeprom
--- a/Documentation/i2c/chips/eeprom	1970-01-01 01:00:00.000000000 +0100
+++ b/Documentation/i2c/chips/eeprom	2005-03-04 23:15:38.701283816 +0100
+Authors: 
+	Frodo Looijaard <frodol@dds.nl>,
+	Philip Edelbrock <phil@netroedge.com>,
+        Jean Delvare <khali@linux-fr.org>,
Indentation problem here.

diff -Naur a/Documentation/i2c/chips/gl518sm b/Documentation/i2c/chips/gl518sm
--- a/Documentation/i2c/chips/gl518sm	1970-01-01 01:00:00.000000000 +0100
+++ b/Documentation/i2c/chips/gl518sm	2005-03-04 23:15:47.516943632 +0100
@@ -0,0 +1,79 @@
+This driver supports the Genesys Logic GL518SM chip. There are at least
+two revision of this chip, which we call revision 0x00 and 0x80. Revision
revisions

+situation. Measurements are guaranteed between -10 degrees and +110
+degrees, with a resolution of +-3 degrees.
shoud be accuracy of +/-3 degrees.

diff -Naur a/Documentation/i2c/chips/lm80 b/Documentation/i2c/chips/lm80
--- a/Documentation/i2c/chips/lm80	1970-01-01 01:00:00.000000000 +0100
+++ b/Documentation/i2c/chips/lm80	2005-03-04 23:16:11.525293808 +0100
+drops below the HOT Hysteresis. The Overtemperature Shotdown (OS) limits
Shutdown

+Voltage ensors (also known as IN sensors) report their values in volts.
sensors

diff -Naur a/Documentation/i2c/chips/lm85 b/Documentation/i2c/chips/lm85
--- a/Documentation/i2c/chips/lm85	1970-01-01 01:00:00.000000000 +0100
+++ b/Documentation/i2c/chips/lm85	2005-03-04 23:16:24.835270384 +0100
+Authors:
+	Philip Pokorny <ppokorny@penguincomputing.com>,
+        Frodo Looijaard <frodol@dds.nl>,
indentation problem (use tab instead of spaces)

diff -Naur a/Documentation/i2c/chips/lm87 b/Documentation/i2c/chips/lm87
--- a/Documentation/i2c/chips/lm87	1970-01-01 01:00:00.000000000 +0100
+++ b/Documentation/i2c/chips/lm87	2005-03-04 23:16:29.117619368 +0100
@@ -0,0 +1,78 @@
+Authors: 
+	Frodo Looijaard <frodol@dds.nl>,
+        Philip Edelbrock <phil@netroedge.com>, 
+        Mark Studebaker <mdsxyz123@yahoo.com>,
+        Stephen Rousset <stephen.rousset@rocketlogix.com>,
indentation problem (use tab instead of spaces)

diff -Naur a/Documentation/i2c/chips/pcf8574 b/Documentation/i2c/chips/pcf8574
--- a/Documentation/i2c/chips/pcf8574	1970-01-01 01:00:00.000000000 +0100
+++ b/Documentation/i2c/chips/pcf8574	2005-02-24 17:02:00.000000000 +0100
+Authors: Frodo Looijaard <frodol@dds.nl>,
+         Philip Edelbrock <phil@netroedge.com>,
+         Dan Eaton <dan.eaton@rocketlogix.com>,
+	 Aurelien Jarno <aurelien@aurel32.net>,
+	 Jean Delvare <khali@linux-fr.org>,
indentation problem (use tab instead of spaces)

+The write file is read/write. Writing a value outputs it on the I/O
+port. Reading return the last written value.
returns ?

diff -Naur a/Documentation/i2c/chips/sis5595 b/Documentation/i2c/chips/sis5595
--- a/Documentation/i2c/chips/sis5595	1970-01-01 01:00:00.000000000 +0100
+++ b/Documentation/i2c/chips/sis5595	2005-03-04 23:34:44.704064912 +0100
+Authors: 
+	Ky?sti M?lkki <kmalkki@cc.hut.fi>,
+        Mark D. Studebaker <mdsxyz123@yahoo.com>
+	Aurelien Jarno <aurelien@aurel32.net> 2.6 port
indentation problem (use tab instead of spaces)

+The Sis5595 southbridge has integrated hardware monitor functions. It also
SiS5595

+which was hopefully set by the BIOS. If the temperature function is
+enabled, in4 will return 0. If the in4 function is enabled, temp will
+return 0.
The 2.6 driver only creates the sys file of the input which is enabled 
(in4 or temp). So this sentence could be removed.

+The Sis5595 only updates its values each 1.5 seconds; reading it more often
SiS5595
diff -Naur a/Documentation/i2c/chips/via686a b/Documentation/i2c/chips/via686a
--- a/Documentation/i2c/chips/via686a	1970-01-01 01:00:00.000000000 +0100
+++ b/Documentation/i2c/chips/via686a	2005-02-18 00:29:54.000000000 +0100
+Authors: Ky?sti M?lkki <kmalkki@cc.hut.fi>,
+         Mark D. Studebaker <mdsxyz123@yahoo.com>
indentation problem (use tab instead of spaces)

diff -Naur a/Documentation/i2c/chips/w83627hf b/Documentation/i2c/chips/w83627hf
--- a/Documentation/i2c/chips/w83627hf	1970-01-01 01:00:00.000000000 +0100
+++ b/Documentation/i2c/chips/w83627hf	2005-02-24 17:05:07.000000000 +0100
+Authors: 
+	Frodo Looijaard <frodol@dds.nl>, 
+	Philip Edelbrock <phil@netroedge.com>,
+        Mark Studebaker <mdsxyz123@yahoo.com>,
indentation problem (use tab instead of spaces)
diff -Naur a/Documentation/i2c/chips/w83781d b/Documentation/i2c/chips/w83781d
--- a/Documentation/i2c/chips/w83781d	1970-01-01 01:00:00.000000000 +0100
+++ b/Documentation/i2c/chips/w83781d	2005-02-24 17:06:54.000000000 +0100

+Authors: 
+	Frodo Looijaard <frodol@dds.nl>, 
+	Philip Edelbrock <phil@netroedge.com>,
+        Mark Studebaker <mdsxyz123@yahoo.com>
indentation problem (use tab instead of spaces)

+For the other temperature sensor(s), an
+alarm is triggered when the temperature gets higher then the Overtemperature 
+Shutdown value; it stays on until the temperature falls below the Hysteresis 
+value. But on the W83781D, there is only one alarm that functions for both 
+other sensors!  Temperatures are guaranteed within a range of -55 to +125 
+degrees. The main temperature sensors has a resolution of 1 degree; the other 
+sensor(s) of 0.5 degree.
The first line is very short, it would be nice to reorganize the paragraph.


+W8378* PROBLEMS
+-----------------
Too much underlines characters

+Known problems:
I doubt unknow problems will be listed in this file :-), so maybe it is better
to remove this line, and describe one problem by paragraph.

+	- Some chips are misidentified.
+	  This is caused by the chip having the wrong WCHIPID register
+	  value, so there is no fix. The workaround is to use the
+          force_CHIP parameter.
+	  (modprobe w83781d force_CHIP=BUS,0x2d where CHIP is the chip name
+	   and BUS is your i2c bus number see /sys/bus/i2c dir)
all the lines are are not indented the same way (tab vs spaces), but that would 
disappear if you follow the above suggestion.

diff -Naur a/Documentation/i2c/userspace-tools b/Documentation/i2c/userspace-tools
--- a/Documentation/i2c/userspace-tools	1970-01-01 01:00:00.000000000 +0100
+++ b/Documentation/i2c/userspace-tools	2005-02-24 21:29:25.000000000 +0100
@@ -0,0 +1,37 @@
+Introduction
+------------
+
+On i2c bus are often found chips to monitor system health (like temperatures,
+voltages, fan speeds). Although kernel i2c chip and bus drivers provide towards 
+userspace standartized interfaces, it is not enough to obtain results or set
+monitoring limits in reasonable manner.

I would rephrase that part:

Most mainboards have sensor chips to monitor system health (like temperatures,
voltages, fans speed). They are often connected through an I2C bus, but some are
also connected directly through the ISA bus.

The kernel drivers make the data from the sensor chips available in the /sys
virtual filesystem. Userspace tools are then used to display or set or the data
in a more friendly manner.


+Lm-sensors
+----------
+
+Core set of utillites that will allow you to obtain health information,
utilities
+setup monitoring limits etc. You can get them on their homepage 
+http://www.lm-sensors.nu or as a package from your Linux distribution.
+
+If from website:
+Get lmsensors-X.X.X.tar.gz from project web site. Please note,
+you need only userspace part, so compile with "make user_install" target.
+
+General hints to get things working:
+
+0) get lm-sensors userspace utils
+1) compile all drivers in I2C section as modules
I would add: "in your kernel, "

+2) run sensors-detect script, it will tell you what modules you need to load.
+3) load them and run "sensors" command, you should see some results.
+5) fix sensors.conf, labels, limits, fan divisors
+6) if any more problems consult FAQ, or documentation
What about point 4?

+
+Other utillites
+---------------
+
+If you want some graphical indicators of system health seek for applications 
                                                       ^^^^^^
                                               I would have used look
+like: gkrellm, ksensors, xsensors, wmtemp, wmsensors, wmgtemp, ksysguardd,
+hardware-monitor
+
+If you are server administrator  you can try snmpd (in debian) or mrtgutils.
          ^^^                  ^^^
     I would add "a"       too much spaces

BTW, I doubt that snmpd is specific to Debian.



-- 
  .''`.  Aurelien Jarno	            | GPG: 1024D/F1BCDB73
 : :' :  Debian GNU/Linux developer | Electrical Engineer
 `. `'   aurel32@debian.org         | aurelien@aurel32.net
   `-    people.debian.org/~aurel32 | www.aurel32.net

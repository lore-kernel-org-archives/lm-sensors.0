From: aurelien@aurel32.net (Aurelien Jarno)
Date: Thu, 19 May 2005 06:25:37 +0000
Subject: Review of documentation update for 2.6 kernel
Message-Id: <20050213203819.GA31723@bode.aurel32.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Rudolf!

I have reviewed you i2c documentation patch for 2.6 kernel with 
available on http://ssh.cz/~ruik/i2cdoc

Due to the size of the patch, I should admit that my concentration was 
not the same during all the time I reviewed it, so I surely missed some
things.

First of all some general remarks that apply to most of the 
documentation files:
- When you underline (= or --) some words, it would be better to have 
  the underlining the same length as the words.
- Some lines are longer than 80 characters, and some are only half used. 
  Would be nice to fix that.

Then when I read all the documentation files, I remarked that some parts
are the same, and it may be a good idea to "factorize" that in a common 
file. I think of:
- Update rate. I mean the fact that if the values are read more often 
  than 1, 1.5, 2 or 5 seconds (that's the values I collected for the 
  different chips), old data are return instead.
- The fact that alarms are alarms from the chip and are not computed.
- The way to clear the alarms by reading values.
- The principle of how fan dividers work and the consequence on values 
  range.
- The minimum and maximum values for negative inputs. It is often 
  written "that minimum in this case always means 'closest to zero'".
  Is it still true? If I remember correctly the way negative limits are
  handled has changed some times ago.
- The way the /sys file system is designed for i2c, ie the fact that
  values for a device are accessible at /sys/bus/i2c/devices/<0>-<1>/

Last, please find below some things I have found in the individual 
files. I hope I have kept enough context lines.

Bye,
Aurelien


diff -Naur a/Documentation/i2c/busses/i2c-ali15x3 b/Documentation/i2c/busses/i2c-ali15x3
--- a/Documentation/i2c/busses/i2c-ali15x3	1970-01-01 01:00:00.000000000 +0100
+++ b/Documentation/i2c/busses/i2c-ali15x3	2005-02-08 15:43:07.000000000 +0100
<snip>
+The M1533/M1543C devices appear as FOUR separate devices
+on the PCI bus. An output of lspci will show something similar
+to the following:
+
+  00:02.0 USB Controller: Acer Laboratories Inc. M5237 (rev 03)
+  00:03.0 Bridge: Acer Laboratories Inc. M7101      <= THIS IS THE ONE WE NEED
+  00:07.0 ISA bridge: Acer Laboratories Inc. M1533 (rev c3)
+  00:0f.0 IDE interface: Acer Laboratories Inc. M5229 (rev c1)
+
+** IMPORTANT **
+** If you have a 1533 or 1543C on the board and you get
Would be better to write M1533 and M1543C so that users can't confused with
PCI ids. And it's only one letter more.

+** "ali15x3.o: Error: Can't detect ali15x3!"
+** then run lspci.
+** If you see the 1533 and 5229 devices but NOT the 7101 device,
idem there
+** then you must enable ACPI, the PMU, SMB, or something similar
+** in the BIOS. 
+** The driver won't work if it can't find the 7101 device.
+
+The SMB controller is part of the 7101 device, which is an
idem
+ACPI-compliant Power Management Unit (PMU).
+
+The whole 7101 device has to be enabled for the SMB to work.
idem
<snip>
diff -Naur a/Documentation/i2c/busses/i2c-ali1535 b/Documentation/i2c/busses/i2c-ali1535
--- a/Documentation/i2c/busses/i2c-ali1535	1970-01-01 01:00:00.000000000 +0100
+++ b/Documentation/i2c/busses/i2c-ali1535	2005-02-08 15:42:37.000000000 +0100
<snip>
+The SMB controller is part of the 7101 device, which is an
again M7101
+ACPI-compliant Power Management Unit (PMU).
+
+The whole 7101 device has to be enabled for the SMB to work.
again...
+You can't just enable the SMB alone.
diff -Naur a/Documentation/i2c/busses/i2c-ali1563 b/Documentation/i2c/busses/i2c-ali1563
--- a/Documentation/i2c/busses/i2c-ali1563	1970-01-01 01:00:00.000000000 +0100
+++ b/Documentation/i2c/busses/i2c-ali1563	2005-02-08 15:42:54.000000000 +0100
<snip>
+For an overview of these chips see http://www.acerlabs.com
What about adding the same note as for the M1533 about the password?
+
+The 1563 southbridge is deceptively similar to the 1533, with a 
again M1563 and M1533
+few notable exceptions. One of those happens to be the fact they 
+upgraded the i2c core to be 2.0 compliant, and happens to be almost 
+identical to the i2c controller found in the Intel 801 south bridges. 
Is it really i2c there or rather SMBus. AFAIK, there is no version 2.0 of the 
i2c standard, but a version 2.0 of the SMBus standard exists.
<snip>
diff -Naur a/Documentation/i2c/busses/i2c-i810 b/Documentation/i2c/busses/i2c-i810
--- a/Documentation/i2c/busses/i2c-i810	1970-01-01 01:00:00.000000000 +0100
+++ b/Documentation/i2c/busses/i2c-i810	2005-02-08 15:45:30.000000000 +0100
<snip>
+Description
+-----------
+WARNING: If you have an '810' or '815' motherboard, your standard I2C
+temperature sensors are most likely on the 801's I2C bus.
+You want the i2c-i810 driver for those, not this driver.
Something is stranger there as the currently described driver is the
i2c-i810. I think it is rather i2c-i801.
<snip>
diff -Naur a/Documentation/i2c/busses/i2c-nforce2 b/Documentation/i2c/busses/i2c-nforce2
--- a/Documentation/i2c/busses/i2c-nforce2	1970-01-01 01:00:00.000000000 +0100
+++ b/Documentation/i2c/busses/i2c-nforce2	2005-02-08 15:49:03.000000000 +0100
<snip>
+Description
+-----------
+
+i2c-nforce2 is a driver for the SMBuses included in the nVidia nForce2 MCP.
and also nForce3

<snip>
diff -Naur a/Documentation/i2c/busses/i2c-sis5595 b/Documentation/i2c/busses/i2c-sis5595
--- a/Documentation/i2c/busses/i2c-sis5595	1970-01-01 01:00:00.000000000 +0100
+++ b/Documentation/i2c/busses/i2c-sis5595	2005-02-08 15:55:08.000000000 +0100
<snip>
+WARNING: If you are trying to access the integrated sensors on the 
+SiS5595 chip, you want the sis5595.o driver for those, not this driver.
should be either sis5595 or sis5595.ko
<snip>
diff -Naur a/Documentation/i2c/busses/i2c-sis630 b/Documentation/i2c/busses/i2c-sis630
--- a/Documentation/i2c/busses/i2c-sis630       1970-01-01 01:00:00.000000000 +0100
+++ b/Documentation/i2c/busses/i2c-sis630       2005-02-08 15:55:37.000000000 +0100
<snip>
+Thank Yous
+-----------
Thank You?
<snip>
diff -Naur a/Documentation/i2c/busses/i2c-sis69x b/Documentation/i2c/busses/i2c-sis69x
--- a/Documentation/i2c/busses/i2c-sis69x	1970-01-01 01:00:00.000000000 +0100
+++ b/Documentation/i2c/busses/i2c-sis69x	2005-02-05 12:26:00.000000000 +0100
<snip>
+ - patch for Sis655
SiS655
<snip>
diff -Naur a/Documentation/i2c/chips/ds1621 b/Documentation/i2c/chips/ds1621
--- a/Documentation/i2c/chips/ds1621	1970-01-01 01:00:00.000000000 +0100
+++ b/Documentation/i2c/chips/ds1621	2005-02-04 23:14:00.000000000 +0100
<snip>
+Temperature readings are internally converted into a 9bit value to be
+read straight via the i2c-bus, but higher resolutions may be obtained
+with little effort via 'precise_temp' access or using a simple algorithm.
What is precise_temp? Maybe something that has existed but which does not exists
anymore.
<snip>
+As for alarms, you can read the alarm status of the DS1621 via the
+'alarms' proc file interface. The result consits mainly of bit 6 and 5
For 2.6 kernels this should be changed into sysfs.

<snip>
+Higher accuracy of the temperature reading can be achieved using the
AFAIK, the accuracy is still the same with this method, only the 
resolution is increased.
<snip>
diff -Naur a/Documentation/i2c/chips/gl518sm b/Documentation/i2c/chips/gl518sm
--- a/Documentation/i2c/chips/gl518sm	1970-01-01 01:00:00.000000000 +0100
+++ b/Documentation/i2c/chips/gl518sm	2005-02-04 23:20:00.000000000 +0100
<snip>
+Authors: 
+	Frodo Looijaard <frodol@dds.nl>,
+        Ky?sti M?lkki <kmalkki@cc.hut.fi>
+	Hong-Gunn Chew <hglinux@gunnet.org>
+	Jean Delvare <khali@linux-fr.org>
Identation problem

+Description
+-----------
+
+IMPORTANT: For the revision 0x00 chip, the
+           in0, in1, and in2 values (+5, +3, and +12) CANNOT be read
Would be better as (+5V, +3V, and +12V)
<snip>
diff -Naur a/Documentation/i2c/chips/it87 b/Documentation/i2c/chips/it87
--- a/Documentation/i2c/chips/it87	1970-01-01 01:00:00.000000000 +0100
+++ b/Documentation/i2c/chips/it87	2005-02-05 12:41:00.000000000 +0100
<snip>
+The sensor type can be set at runtime as of release 2.8.2.
This should be removed or if it also applies to the 2.6 kernel driver, should
be converted to a kernel version number.
<snip>
diff -Naur a/Documentation/i2c/chips/lm85 b/Documentation/i2c/chips/lm85
--- a/Documentation/i2c/chips/lm85	1970-01-01 01:00:00.000000000 +0100
+++ b/Documentation/i2c/chips/lm85	2005-02-05 21:03:00.000000000 +0100
<snip>
+To smooth the response of fans to changes in temperature, the LM85 has
+an optional filter for smoothing temperatures.  The ADM1027 has the
+same config option but uses it to rate limit the changes to fan speed
+instead.  In libsensors, we associate the smoothing feature with a
              ^^^^^^^^^^
Is it really done in the library part or in the driver part?
+zone in the LM85 and with a PWM in the ADM1027.
<snip>
+      0    PWM alwasy 0%  (off)
                ^^^^^^
		always
<snip>
diff -Naur a/Documentation/i2c/chips/pcf8574 b/Documentation/i2c/chips/pcf8574
--- a/Documentation/i2c/chips/pcf8574	1970-01-01 01:00:00.000000000 +0100
+++ b/Documentation/i2c/chips/pcf8574	2005-02-05 11:55:00.000000000 +0100
<snip>
+	 Aurelien Jarno <aurel32@debian.org>,
Would it be possible to change my email address to aurelien@aurel32.net so that 
it is coherent through all the docs?
<snip>
diff -Naur a/Documentation/i2c/chips/pcf8591 b/Documentation/i2c/chips/pcf8591
--- a/Documentation/i2c/chips/pcf8591	1970-01-01 01:00:00.000000000 +0100
+++ b/Documentation/i2c/chips/pcf8591	2005-02-05 12:01:00.000000000 +0100
<snip>
+For more informations see the datasheet.
          ^^^^^^^^^^^^
	  information
I think it is to close from French. Maybe "See the datasheet for details." 
would be better.
<snip>
diff -Naur a/Documentation/i2c/chips/w83627hf b/Documentation/i2c/chips/w83627hf
--- a/Documentation/i2c/chips/w83627hf	1970-01-01 01:00:00.000000000 +0100
+++ b/Documentation/i2c/chips/w83627hf	2005-02-05 11:07:00.000000000 +0100
<snip>
+initialization that were required in the w83781d driver
+(lm_sensors releases 2.7.0 and earlier).
This should be removed or if it also applies to the 2.6 kernel driver, should
be converted to a kernel version number.
<snip>
+For further information on this driver, /proc values, etc.
+see the w83781d driver documentation.
This is now /sys
<snip>
diff -Naur a/Documentation/i2c/chips/w83781d b/Documentation/i2c/chips/w83781d
--- a/Documentation/i2c/chips/w83781d	1970-01-01 01:00:00.000000000 +0100
+++ b/Documentation/i2c/chips/w83781d	2005-02-05 11:01:00.000000000 +0100
<snip>
+W8783S, and W83627HF chips, and the Asus AS99127F chips.
 ^^^^^^
 W83783S
<snip>
+AS9917F looks more like a w83782d).
 ^^^^^^^
 AS99127F
<snip>


-- 
  .''`.  Aurelien Jarno	              GPG: 1024D/F1BCDB73
 : :' :  Debian GNU/Linux developer | Electrical Engineer
 `. `'   aurel32@debian.org         | aurelien@aurel32.net
   `-    people.debian.org/~aurel32 | www.aurel32.net

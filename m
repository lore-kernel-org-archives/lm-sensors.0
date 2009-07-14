From: Andre Prendel <andre.prendel@gmx.de>
Date: Tue, 14 Jul 2009 17:11:32 +0000
Subject: Re: [lm-sensors] [PATCH] sensors-detect: Add TMP42x chip detection
Message-Id: <20090714171132.GA4482@ubuntu>
List-Id: <lm-sensors.vger.kernel.org>
References: <20090712193403.GA4444@ubuntu>
In-Reply-To: <20090712193403.GA4444@ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, Jul 13, 2009 at 02:10:41PM +0200, Jean Delvare wrote:

<snip>

> > Ok, will do that. What's actually the reason why we dont probe all addresses?
> > Why is it unsafe and what can happen probing an unsafe address?
> 
> We avoid probing addresses which are not very popular for hardware
> monitoring chips. For addresses which are already probed for many
> chips, adding one doesn't change much.
> 
> The reason is that I2C transactions do not have semantics attached. A
> given transaction can do different things depending on the device which
> receives it. Even transactions which SMBus says are "read"
> transactions, can write to chips. Or they read but have side effects.
> So we want to be extra cautious and not probe more than needed.
> 
> Bad things can happen when probing I2C devices in a way they did not
> expect. The lm-sensors project has an history of (thankfully rare)
> reports of sensors-detect confusing or even breaking pieces of hardware.
> Sometimes the reason is design flaws in chips [1], sometimes it's just
> that the chip did not like the probe [2].
> 
> [1] http://www.lm-sensors.org/browser/lm-sensors/branches/lm-sensors-2.10/README.thinkpad
> [2] http://lists.lm-sensors.org/pipermail/lm-sensors/2008-May/023020.html
> 
> Over time we have improved both sensors-detect [3] and some kernel
> drivers [4] to prevent all known issues. But more issues are bound to
> arise in the future again as long as we do SMBus probing. This is the
> main reason why I recently changed the order of probes in
> sensors-detect [5] and sensors-detect now skips SMBus probing if
> Super-I/O sensors were found [6] (with some exceptions.) This is better
> than the previous situation, but still not bullet-proof.
> 
> [3] http://www.lm-sensors.org/changeset/5245
> [4] http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff;h851d6eb4eeb0894f4d095dfdf8ab61c435ad57
> [5] http://www.lm-sensors.org/changeset/5498
> [6] http://www.lm-sensors.org/changeset/5511
> 

Thank for the lesson. Very informativ.

Below you can find an updated patch with the comment for addresses not
probed. Further I've adjusted the address range for TMP422 and
TMP423. TMP422 only supports 0x4c-0x4f and TMP423 0x4c, 0x4d.
---

Index: sensors/prog/detect/sensors-detect
=================================--- sensors.orig/prog/detect/sensors-detect	2009-07-10 22:15:41.000000000 +0200
+++ sensors/prog/detect/sensors-detect	2009-07-14 18:34:05.000000000 +0200
@@ -908,6 +908,21 @@
 		i2c_addrs => [0x4c..0x4e],
 		i2c_detect => sub { lm90_detect(@_, 10); },
 	}, {
+		name => "Texas Instruments TMP421",
+		driver => "tmp421",
+		i2c_addrs => [0x2a, 0x4c..0x4f], # 0x1c-0x1f not probed.
+		i2c_detect => sub { tmp42x_detect(@_, 0); },
+	}, {
+		name => "Texas Instruments TMP422",
+		driver => "tmp421",
+		i2c_addrs => [0x4c..0x4f],
+		i2c_detect => sub { tmp42x_detect(@_, 1); },
+	}, {
+		name => "Texas Instruments TMP423",
+		driver => "tmp421",
+		i2c_addrs => [0x4c, 0x4d],
+		i2c_detect => sub { tmp42x_detect(@_, 2); },
+	}, {
 		name => "National Semiconductor LM95231",
 		driver => "to-be-written",
 		i2c_addrs => [0x2b, 0x19, 0x2a],
@@ -3907,6 +3922,25 @@
 }
 
 # Registers used:
+#   0xfe: Manufactorer ID
+#   0xff: Device ID
+sub tmp42x_detect()
+{
+	my ($file, $addr, $chip) = @_;
+
+	my $mid = i2c_smbus_read_byte_data($file, 0xfe);
+	my $cid = i2c_smbus_read_byte_data($file, 0xff);
+
+	return if ($mid != 0x55);
+
+	return 6 if ($chip = 0 && $cid = 0x21); # TMP421
+	return 6 if ($chip = 1 && $cid = 0x22); # TMP422
+	return 6 if ($chip = 2 && $cid = 0x23); # TMP423
+
+	return;
+}
+
+# Registers used:
 #   0x03: Configuration (no low nibble, returns the previous low nibble)
 #   0x04: Conversion rate
 #   0xfe: Manufacturer ID

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

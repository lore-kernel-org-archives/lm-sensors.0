From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 08 May 2008 20:41:45 +0000
Subject: [lm-sensors] [PATCH] sensors-detect: Check for 1-register-only
Message-Id: <20080508224145.41cfa3ef@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi all,

A few days ago, Achim Gottinger reported severe hardware problems when
running sensors-detect on his Sapphire AM2RD790 motherboard [1]. The
system was freezing, and one CPU even died (even though I still have some
doubt about the direct responsibility of sensors-detect in this
tragedy.) Investigations taught us that the problematic chip is a
memory voltage controller which lives at address 0x2e (unfortunately a
popular address for hardware monitoring chips.) This device uses SMBus
receive byte and SMBus send byte transactions, i.e. short reads and
writes. When sensors-detect uses SMBus read byte transactions to
attempt to identify I2C/SMBus chips, the device in question sees a write
followed by a read. So in practice, sensors-detect is writing random
values to the voltage controller, resulting in hardware trouble. Not
good.

This is a fundamental weakness of I2C and SMBus that this kind of
problem can happen, and there's not that much we can do about it, short
of stopping SMBus probing altogether. But still, it would be great if
we could prevent the users from accidentally freezing their system or
frying their hardware by just running sensors-detect. I've already made
a proposal in that direction some days ago [2], and I am back with a
new one.

[1] http://lists.lm-sensors.org/pipermail/lm-sensors/2008-May/023020.html
[2] http://lists.lm-sensors.org/pipermail/lm-sensors/2008-May/023056.html

This time, my idea is to let sensors-detect attempt to figure out when
it is about to probe an I2C address where such a 1-register-only device
lives, and skip that probe. It's not easy, but I have come up with a
heuristic which I think should work in most cases, and should be
reasonably safe.

The idea is to start with two SMBus receive byte transactions. This
should give us the value of the single register - if what we have is a
1-register-only device. Then we'd send the same byte, and read again.
In theory this should still return the same value. Then we write the
same value with LSB inverted. Reading again should return the same
value with LSB inverted. If all the tests pass, we write one last time
the original register value, and leave the device alone. If at some
point a test fails, then it means that the device is probably not a
1-register-only device and must instead be a regular device which
understand SMBus read byte, so sensors-detect can keep probing it.

The trick is that the above can be implemented using only SMBus "read"
transactions (receive byte and read byte.) We were already doing random
SMBus read byte transactions so there is no change there. My hope is
that adding SMBus receive byte transactions at the beginning should do
no harm. But of course only testing will tell.

Here's the patch I have come up with:

---
 prog/detect/sensors-detect |   40 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

--- lm-sensors-3.orig/prog/detect/sensors-detect	2008-05-04 18:43:17.000000000 +0200
+++ lm-sensors-3/prog/detect/sensors-detect	2008-05-08 22:33:06.000000000 +0200
@@ -2743,6 +2743,42 @@ sub i2c_probe($$$)
   }
 }
 
+# $_[0]: Reference to an opened file handle
+# Returns: 1 if the device is safe to access, 0 else.
+# This function is meant to prevent access to 1-register-only devices,
+# which are designed to be access with SMBus receive byte and SMBus send
+# byte transactions (i.e. short reads and short writes) and treat SMBus
+# read byte as a real write followed by a read. The device detection
+# routines would write random values to the chip with possibly very nasty
+# results for the hardware. Note that this function won't catch all such
+# chips, as it assumes that reads and writes relate to the same register,
+# but that's the best we can do.
+sub i2c_safety_check
+{
+  my ($file) = @_;
+  my $data;
+
+  # First we receive a byte from the chip, and remember it.
+  $data = i2c_smbus_read_byte($file);
+
+  # We receive a byte again; very likely to be the same for
+  # 1-register-only devices.
+  return 1 if (i2c_smbus_read_byte($file) != $data);
+
+  # Then we try a standard byte read, with a register offset equal to
+  # the byte we received; we should receive the same byte value in return.
+  return 1 if (i2c_smbus_read_byte_data($file, $data) != $data);
+
+  # Then we try a standard byte read, with a slightly different register
+  # offset; we should again receive the same byte value in return.
+  return 1 if (i2c_smbus_read_byte_data($file, $data ^ 1) != ($data ^ 1));
+
+  # Apprently this is a 1-register-only device, restore the original register
+  # value and leave it alone.
+  i2c_smbus_read_byte_data($file, $data);
+  return 0;
+}
+
 ####################
 # ADAPTER SCANNING #
 ####################
@@ -3087,6 +3123,10 @@ sub scan_adapter
 
     next unless i2c_probe(\*FILE, $addr, $funcs);
     printf "Client found at address 0x%02x\n",$addr;
+    if (!i2c_safety_check(\*FILE)) {
+      print "Seems to be a 1-register-only device, skipping.\n";
+      next;
+    }
 
     $| = 1;
     foreach $chip (@chip_ids) {


I've tested it on ADM1032, LM75, LM78 and LM87 chips, as well as
EEPROMs, and it didn't cause any problem (i.e. they are all properly
identified as they were before.) I would appreciate more testers, both
on regular chips (to make sure there is no regression), and on
1-register-only devices (to see if they are detected or not) for those
of you who have access to such chips. The PCF8574 GPIO chip is one of
these. Keep in mind before doing the test though, that the LSB of the
device will be briefly switched, so make sure that it won't cause
unwanted effects.

If anyone is worried about this LSB switching, please realize that it's
still a lot safer than what we were doing so far, where _all_ bits of
the register could be switched, and additionally they wouldn't be
restored afterwards.

Disclaimer: as with any experimental I2C code, it is very hard to
predict the results on all devices, so if you don't feel like taking
any risk, don't do the test.

I've made a patched version of sensors-detect directly available at:
http://jdelvare.pck.nerim.net/sensors/sensors-detect
to make testing easier.

I am very interested in opinions about this heuristic, and in test
results. Ideally I'd like to have this committed quickly so that it
makes it in lm-sensors 3.0.2. But I can only do that if I get enough
positive test results in the next few days.

Thanks,
-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

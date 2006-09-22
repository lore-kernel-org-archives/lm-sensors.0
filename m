From: christoph.scheurer@web.de (Christoph Scheurer)
Date: Fri, 22 Sep 2006 21:33:36 +0000
Subject: [lm-sensors] new module for MAX1668, MAX1805, MAX1989
Message-Id: <20060922213336.GD4353@scheurer-clark.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello,

I would like to contribute a module which covers the Maxim chips MAX1668,
MAX1805, and MAX1989 (see also ticket #2125). It has been tested with a
MAX1805 module as described on
    http://www.madhacker.org/mbmsensors.htm     or
    http://www.andreas-lenz.de/casemods/de/max1668.php

It would be good if somebody with a MAX1668 or a MAX1989 could also test the
module and the patch to sensors-detect (relative to SVN HEAD).

Regards,

-- 
Christoph Scheurer                                  GnuPG key Id: 0x6128C6B6
-------------- next part --------------
A non-text attachment was scrubbed...
Name: max1668.c
Type: text/x-csrc
Size: 17751 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20060922/2bf4f190/attachment-0001.bin 
-------------- next part --------------
--- lm-sensors/prog/detect/sensors-detect.orig	2006-09-22 22:54:34.359156000 +0200
+++ lm-sensors/prog/detect/sensors-detect	2006-09-22 23:12:50.412859000 +0200
@@ -1078,6 +1078,24 @@
        i2c_detect => sub { adm1021_detect(3, @_); },
      },
      {
+       name => "Maxim MAX1668",
+       driver => "max1668",
+       i2c_addrs => [0x18..0x20,0x29..0x2b,0x4c..0x4e],
+       i2c_detect => sub { max1668_detect(0, @_); },
+     },
+     {
+       name => "Maxim MAX1805",
+       driver => "max1668",
+       i2c_addrs => [0x18..0x20,0x29..0x2b,0x4c..0x4e],
+       i2c_detect => sub { max1668_detect(1, @_); },
+     },
+     {
+       name => "Maxim MAX1989",
+       driver => "max1668",
+       i2c_addrs => [0x18..0x20,0x29..0x2b,0x4c..0x4e],
+       i2c_detect => sub { max1668_detect(2, @_); },
+     },
+     {
        name => "Maxim MAX6650/MAX6651",
        driver => "max6650",
        i2c_addrs => [0x1b,0x1f,0x48,0x4b],
@@ -4255,6 +4273,35 @@
 }
 
 # $_[0]: Chip to detect
+#   (0 = MAX1668, 1 = MAX1805, 2 = MAX1989)
+# $_[1]: A reference to the file descriptor to access this chip.
+#        We may assume an i2c_set_slave_addr was already done.
+# $_[2]: Address
+# Returns: undef if not detected, 7 if detected
+# Registers used:
+#   0xfe: Company ID
+#   0xff: Device ID
+#   0x05: Status1
+#   0x06: Status2
+#   0x07: Configuration
+sub max1668_detect
+{
+  my ($chip, $file, $addr) = @_;
+  my $man_id = i2c_smbus_read_byte_data($file, 0xfe);
+  my $dev_id = i2c_smbus_read_byte_data($file, 0xff);
+  my $status1 = i2c_smbus_read_byte_data($file, 0x05);
+  my $status2 = i2c_smbus_read_byte_data($file, 0x06);
+  my $conf = i2c_smbus_read_byte_data($file, 0x07);
+
+  return if $man_id != 0x4D;
+  return if $chip = 0 and $dev_id != 0x03;
+  return if $chip = 1 and $dev_id != 0x05;
+  return if $chip = 2 and $dev_id != 0x0b;
+
+  return 7;
+}
+
+# $_[0]: Chip to detect
 #   (0 = MAX1619)
 # $_[1]: A reference to the file descriptor to access this chip.
 #        We may assume an i2c_set_slave_addr was already done.

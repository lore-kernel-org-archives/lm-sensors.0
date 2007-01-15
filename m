From: khali@linux-fr.org (Jean Delvare)
Date: Mon, 15 Jan 2007 19:06:20 +0000
Subject: [lm-sensors] [PATCH] sensors-detect: Only probe useful I2C addresses
Message-Id: <20070115200620.ceeb1ad5.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi all,

Here comes a patch to sensors-detect. The idea is to limit the I2C
probing to the addresses where we know at least one hardware monitoring
chip, rather than probing the whole 0x03-0x77 address range. Probing
extra addresses has several drawbacks:
* On some machines, probing some addresses results in a bus lockup.
  Probing less addresses might help.
* Some users are confused when sensors-detect finds an I2C/SMBus chip
  at a given address but fails to identify it. To them, it may sound
  like it is an unknown hardware monitoring chips. In 99% of the cases
  it isn't though.
* It's a waste of time.

I also dropped the detection of the "SMBus 2.0 ARP-Capable Device" at
0x61. If we ever support this, it's not sensors-detect's job.

In practice, this change basically halves the number of probed I2C
addresses.

If someone really wants to see all the responsive addresses on an I2C
bus, we have i2cdetect for that.

Comments anyone?

Index: prog/detect/sensors-detect
=================================--- prog/detect/sensors-detect	(revision 4296)
+++ prog/detect/sensors-detect	(working copy)
@@ -47,7 +47,8 @@
 # CONSTANT DECLARATIONS #
 #########################
 
-use vars qw(@pci_adapters @chip_ids @superio_ids @cpu_ids $revision);
+use vars qw(@pci_adapters @chip_ids $i2c_addresses_to_scan @superio_ids
+            @cpu_ids $revision);
 
 $revision = '$Revision$ ($Date$)';
 $revision =~ s/\$\w+: (.*?) \$/$1/g;
@@ -1474,12 +1475,6 @@
        i2c_detect => sub { max6900_detect(@_); },
      },
      {
-       name => "SMBus 2.0 ARP-Capable Device",
-       driver => "not-a-sensor",
-       i2c_addrs => [0x61],
-       i2c_detect => sub { arp_detect(@_); },
-     },
-     {
        name => "IPMI BMC KCS",
        driver => "bmcsensors",
        isa_addrs => [ 0x0ca0 ],
@@ -2477,6 +2472,7 @@
 sub i2c_set_slave_addr
 {
   my ($file,$addr) = @_;
+  $addr += 0; # Make sure it's a number not a string
   ioctl $file, IOCTL_I2C_SLAVE, $addr or return 0;
   return 1;
 }
@@ -2819,6 +2815,30 @@
   }
 }
 
+# From the list of known I2C/SMBus devices, build a list of I2C addresses
+# which are worth probing. There's no point in probing an address for which
+# we don't know a single device, and probing some addresses has caused
+# random trouble in the past.
+sub i2c_addresses_to_scan()
+{
+  my @used;
+  my @addresses;
+  my $addr;
+
+  foreach my $chip (@chip_ids) {
+    next unless defined $chip->{'i2c_addrs'};
+    next if $chip->{'driver'} eq 'not-a-sensor';
+    foreach $addr (@{$chip->{'i2c_addrs'}}) {
+      $used[$addr]++;
+    }
+  }
+
+  for ($addr = 0x03; $addr <= 0x77; $addr++) {
+    push @addresses, $addr if $used[$addr];
+  }
+  return \@addresses;
+}
+
 # $_[0]: The number of the adapter to scan
 # $_[1]: The name of the adapter, as appearing in /proc/bus/i2c
 # $_[2]: The driver of the adapter
@@ -2851,7 +2871,7 @@
   }
 
   # Now scan each address in turn
-  foreach $addr (0x03..0x77) {
+  foreach $addr (@{$i2c_addresses_to_scan}) {
     # As the not_to_scan list is sorted, we can check it fast
     if (@not_to_scan and $not_to_scan[0] = $addr) {
       shift @not_to_scan;
@@ -5021,18 +5041,6 @@
 	return 3;
 }
 
-# $_[0]: A reference to the file descriptor to access this chip.
-#        We may assume an i2c_set_slave_addr was already done.
-# $_[1]: Address
-# Returns: 1
-# This is a placeholder so we get a report if any device responds
-# to the SMBus Device Default Address (0x61), which is used for
-# ARP in SMBus 2.0.
-sub arp_detect
-{
-  return (1);
-}
-
 # This checks for non-FFFF values for SpecInfo and Status.
 # The address (0x09) is specified by the SMBus standard so it's likely
 # that this really is a smart battery charger.
@@ -5581,6 +5589,7 @@
   # Before looking for chips, make sure any special case chips are
   # added to the chip_ids list
   chip_special_cases();
+  $i2c_addresses_to_scan = i2c_addresses_to_scan();
 
   print "We are now going to do the I2C/SMBus adapter probings. Some chips may\n",
         "be double detected; we choose the one with the highest confidence\n",

-- 
Jean Delvare


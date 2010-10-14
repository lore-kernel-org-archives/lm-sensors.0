From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Thu, 14 Oct 2010 15:40:42 +0000
Subject: [lm-sensors] [PATCH/RFC] sensors-detect: Add detection of PMBus
Message-Id: <20101014154042.GA20794@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

This patch adds basic support for detection of PMBus devices.
It can easily be extended to support additional PMBus devices.
Key question right now is if this approach is acceptable.

Notable changes:
- Chip detection code now uses byte read to detect devices in address range [0x03..0x0a, 0x0d..0x3f]
  TBD: Maybe we should use SMBUS_QUICK first followed by SMBUS_BYTE if it fails
  or if it is not supported by the adapter.
- Added support for SMBus block read command
- Fixed bug seen if I2C master numbering is non-sequential (which I should probably
  commit separately if the fix is ok).

Thanks,
Guenter

--
Index: prog/detect/sensors-detect
=================================--- prog/detect/sensors-detect	(revision 5865)
+++ prog/detect/sensors-detect	(working copy)
@@ -1249,6 +1249,31 @@
 		driver => "sbs", # ACPI driver, not sure if it always works
 		i2c_addrs => [0x0b],
 		i2c_detect => sub { smartbatt_detect(@_); },
+	}, {
+		name => "Linear Technology LTC2978",
+		driver => "to-be-written",
+		i2c_addrs => [0x5c..0x64],
+		i2c_detect => sub { pmbus_detect(@_, 0); },
+	}, {
+		name => "Ericsson BMR450",
+		driver => "to-be-written",
+		i2c_addrs => [0x03..0x0a, 0x0d..0x3f],
+		i2c_detect => sub { pmbus_detect(@_, 1); },
+	}, {
+		name => "Ericsson BMR451",
+		driver => "to-be-written",
+		i2c_addrs => [0x03..0x0a, 0x0d..0x3f],
+		i2c_detect => sub { pmbus_detect(@_, 2); },
+	}, {
+		name => "Ericsson BMR453",
+		driver => "to-be-written",
+		i2c_addrs => [0x03..0x0a, 0x0d..0x3f],
+		i2c_detect => sub { pmbus_detect(@_, 3); },
+	}, {
+		name => "Ericsson BMR454",
+		driver => "to-be-written",
+		i2c_addrs => [0x03..0x0a, 0x0d..0x3f],
+		i2c_detect => sub { pmbus_detect(@_, 4); },
 	}
 );
 
@@ -2812,10 +2837,12 @@
 use constant SMBUS_BYTE		=> 1;
 use constant SMBUS_BYTE_DATA	=> 2;
 use constant SMBUS_WORD_DATA	=> 3;
+use constant SMBUS_BLOCK_DATA	=> 5;
 
 use constant I2C_FUNC_SMBUS_QUICK	=> 0x00010000;
 use constant I2C_FUNC_SMBUS_READ_BYTE	=> 0x00020000;
 use constant I2C_FUNC_SMBUS_READ_BYTE_DATA	=> 0x00080000;
+use constant I2C_FUNC_SMBUS_READ_BLOCK_DATA	=> 0x01000000;
 
 # Get the i2c adapter's functionalities
 # $_[0]: Reference to an opened filehandle
@@ -2919,6 +2946,26 @@
 }
 
 # $_[0]: Reference to an opened filehandle
+# $_[1]: Command byte (usually register number)
+# Returns: -1 on failure, the read block on success.
+# Use this function with care, some devices don't like block reads,
+# so you should do as much of the detection as possible using byte reads,
+# and only start using block reads when there is a good chance that
+# the detection will succeed.
+sub i2c_smbus_read_block_data
+{
+	my ($file, $command) = @_;
+	my @data;
+	my $len;
+	i2c_smbus_access($file, SMBUS_READ, $command, SMBUS_BLOCK_DATA, \@data)
+		or return -1;
+	# First returned byte is length, followed by up to 32 bytes of data.
+	# Convert to string.
+	$len = $data[0];
+	return substr(pack("C33", @data), 1, $len);
+}
+
+# $_[0]: Reference to an opened filehandle
 # $_[1]: Address
 # $_[2]: Functionalities of this i2c adapter
 # Returns: 1 on successful probing, 0 else.
@@ -2946,6 +2993,12 @@
 		# this probe method is safe.
 		return 0 unless ($funcs & I2C_FUNC_SMBUS_READ_BYTE_DATA);
 		return i2c_smbus_access($file, SMBUS_READ, 0, SMBUS_BYTE_DATA, []);
+	} elsif (($addr >= 0x03 && $addr <= 0x0a) 
+	 || ($addr >= 0x0d && $addr <= 0x3f)) {
+		# This covers all PMBus devices we know of which don't accept
+		# SMBUS_QUICK commands.
+		return 0 unless ($funcs & I2C_FUNC_SMBUS_READ_BYTE);
+		return i2c_smbus_access($file, SMBUS_READ, 0, SMBUS_BYTE, []);
 	} else {
 		return 0 unless ($funcs & I2C_FUNC_SMBUS_QUICK);
 		return i2c_smbus_access($file, SMBUS_WRITE, 0, SMBUS_QUICK, []);
@@ -5517,6 +5570,75 @@
 	return 5;
 }
 
+# Chips to detect: 0 = LTC2978, 1=BMR450, 2=BMR451, 3=BMR453, 4=BMR454
+#
+# Registers used:
+#   0x19: CAPABILITY
+#   0x20: VOUT_MODE
+#   0x78: STATUS_BYTE
+#   0x98: PMBUS_REVISION
+#
+# For some chips:
+#   LTC2978	0xe7	MFG_SPECIAL_ID
+#		0x99	MFR_ID
+#   BMR45x	0x99	MFR_ID (as block data)
+#   		0x9a	MFR_MODEL (as block data)
+#
+sub pmbus_detect
+{
+	my ($file, $addr, $chip) = @_;
+	my ($reg, $vout_mode, $status, $revision, $capability, $data, $funcs);
+
+	$vout_mode = i2c_smbus_read_byte_data($file, 0x20);
+	$status = i2c_smbus_read_byte_data($file, 0x78);
+	$revision = i2c_smbus_read_byte_data($file, 0x98);
+
+	return if $vout_mode < 0;
+	return if $status < 0;
+
+	$capability = i2c_smbus_read_byte_data($file, 0x19);
+
+	if ($chip = 0) {
+		return if $revision != 0x11;	# PMBus Version 1.1
+		return unless $vout_mode = 0x13;
+		return unless $capability = 0xe0;
+		$reg = i2c_smbus_read_word_data($file, 0xe7);
+		# Per datasheet, chip id should be 0x0121. 0x0122 is from observation.
+		return unless $reg = 0x0121 || $reg = 0x0122; # LTC 2978
+	} elsif ($chip > 0 && $chip < 5) {
+		return if $revision != 0x21;	# PMBus version 1.1, per spec
+		return unless $vout_mode = 0x15;
+		return unless $capability = 0xb0;
+		# MFR_ID returns "Ericsson AB" with a length of 12 bytes.
+		# Reading it as word returns 0x450c.
+		$reg = i2c_smbus_read_word_data($file, 0x99);
+		return unless $reg = 0x450c;
+		# MFR_MODEL returns "BMR45x...." with a length of 20 bytes.
+		# Reading it as word returns 0x4214.
+		$reg = i2c_smbus_read_word_data($file, 0x9a);
+		return unless $reg = 0x4214;
+
+		# Now try again with full strings if block data reads are supported.
+		# Otherwise report BMR450 with lower probability.
+		$funcs = i2c_get_funcs($file);
+		if (!($funcs & I2C_FUNC_SMBUS_READ_BLOCK_DATA)) {
+			return 5 if $chip = 1;
+			return 0;
+		}
+		$data = i2c_smbus_read_block_data($file, 0x99);
+		# Should return "Ericsson AB"
+		return if substr($data, 0, 11) ne "Ericsson AB";
+		$data = i2c_smbus_read_block_data($file, 0x9a);
+		# Should return "BMR45x"
+		return if $chip = 1 && substr($data, 0, 6) ne "BMR450";
+		return if $chip = 2 && substr($data, 0, 6) ne "BMR451";
+		return if $chip = 3 && substr($data, 0, 6) ne "BMR453";
+		return if $chip = 2 && substr($data, 0, 6) ne "BMR454";
+	}
+
+	return 9;
+}
+
 # This isn't very good detection.
 # Verify the i2c address, and the stepping ID (which is 0xb0 on
 # my chip but could be different for others...
@@ -5929,7 +6051,9 @@
 	# If we added any module option to handle aliases, we need to load all
 	# the adapter drivers so that the numbers will be the same. If not, then
 	# we only load the adapter drivers which are useful.
-	foreach $adap (@i2c_adapters) {
+	for (my $dev_nr = 0; $dev_nr < @i2c_adapters; $dev_nr++) {
+		next unless exists $i2c_adapters[$dev_nr];
+		$adap = $i2c_adapters[$dev_nr];
 		next if $adap->{autoload};
 		next if $adap->{driver} eq 'UNKNOWN';
 		next if not defined $configfile and not $adap->{used};

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

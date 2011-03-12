From: Jean Delvare <khali@linux-fr.org>
Date: Sat, 12 Mar 2011 13:21:39 +0000
Subject: Re: [lm-sensors] Driver for SMSC SCH5627 needed
Message-Id: <20110312142139.5628a249@endymion.delvare>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="MP_/NC2SSit_he0W5z5hjB=3OI+"
List-Id: <lm-sensors.vger.kernel.org>
References: <4CBD8E44.8070909@ts.fujitsu.com>
In-Reply-To: <4CBD8E44.8070909@ts.fujitsu.com>
To: lm-sensors@vger.kernel.org

--MP_/NC2SSit_he0W5z5hjB=3OI+
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Sat, 12 Mar 2011 12:19:09 +0100, Jean Delvare wrote:
> Anyway, I agree that the non-standard location of the base I/O register
> isn't supported by sensors-detect yet. We already have some code to
> handle non-standard SMSC chips, but the SCH5627 is non-standard in a
> different way. I'll try to come up with something, stay tuned.

Can anyone with access to a SCH5627 chip test the sensors-detect patch
in attachment? Alternatively a pre-patched sensors-detect can be
downloaded at:
  http://khali.linux-fr.org/devel/misc/sensors-detect

It should properly detect the SCH5627, but I can't test it as I don't
have such a chip.

Thanks,
-- 
Jean Delvare

--MP_/NC2SSit_he0W5z5hjB=3OI+
Content-Type: text/x-patch
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename=smsc-sch5627-detection.patch

Add detection of the SMSC SCH5627. Some code is needed because the
base I/O registers live at non-standard addresses.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
---
 prog/detect/sensors-detect |   60 ++++++++++++++++++++++++++++++++++----------
 1 file changed, 47 insertions(+), 13 deletions(-)

--- lm-sensors.orig/prog/detect/sensors-detect	2011-03-04 15:59:20.000000000 +0100
+++ lm-sensors/prog/detect/sensors-detect	2011-03-12 14:05:38.000000000 +0100
@@ -1402,6 +1402,7 @@ use vars qw(@i2c_adapter_names);
 #	 monitoring registers can only be accessed via the SMBus
 #  devid: The device ID we have to match (base device)
 #  devid_mask (optional): Bitmask to apply before checking the device ID
+#  regs (optional): Register definitions, where they differ from the standard.
 #  logdev: The logical device containing the sensors
 #  check (optional): A function to refine the detection. Will be passed
 #      the index and data ports as parameters. Must return 1 for a matching
@@ -1761,6 +1762,16 @@ use constant FEAT_SMBUS	=> (1 << 7);
 		# No datasheet
 		driver => "not-a-sensor",
 		devid => 0x83,
+	}, {
+		name => "SMSC SCH5627 Super IO",
+		driver => "sch5627",
+		devid => 0xc6,
+		regs => {
+			basereg_lsb => 0x66,
+			basereg_msb => 0x67,
+		},
+		logdev => 0x0c,
+		features => FEAT_IN | FEAT_FAN | FEAT_TEMP,
 	}
 );
 
@@ -2236,6 +2247,20 @@ sub any_list_match
 	return 0;
 }
 
+# $_[0]: Reference to base hash
+# $_[1]: Reference to overlay hash
+# Result: Overlayed hash
+sub overlay_hash
+{
+	my ($base, $overlay) = @_;
+	my %result = %{$base};
+
+	foreach my $key (keys %{$overlay}) {
+		$result{$key} = $overlay->{$key};
+	}
+	return %result;
+}
+
 ###################
 # I/O PORT ACCESS #
 ###################
@@ -3544,7 +3569,7 @@ sub scan_isa_bus
 	$| = 0;
 }
 
-use vars qw(%superio);
+use vars qw(%standard_superio);
 
 # The following are taken from the PNP ISA spec (so it's supposed
 # to be common to all Super I/O chips):
@@ -3552,13 +3577,14 @@ use vars qw(%superio);
 #  logdevreg: The logical device register
 #  actreg: The activation register within the logical device
 #  actmask: The activation bit in the activation register
-#  basereg: The I/O base register within the logical device
-%superio = (
+#  basereg_*: The I/O base registers within the logical device
+%standard_superio = (
 	devidreg => 0x20,
 	logdevreg => 0x07,
 	actreg => 0x30,
 	actmask => 0x01,
-	basereg => 0x60,
+	basereg_msb => 0x60,
+	basereg_lsb => 0x61,
 );
 
 sub exit_superio
@@ -3580,18 +3606,18 @@ sub guess_superio_ld
 	my ($oldldn, $ldn, $addr);
 
 	# Save logical device number
-	outb($addrreg, $superio{logdevreg});
+	outb($addrreg, $standard_superio{logdevreg});
 	$oldldn = inb($datareg);
 
 	for ($ldn = 0; $ldn < 16; $ldn++) {
 		# Select logical device
-		outb($addrreg, $superio{logdevreg});
+		outb($addrreg, $standard_superio{logdevreg});
 		outb($datareg, $ldn);
 
 		# Read base I/O address
-		outb($addrreg, $superio{basereg});
+		outb($addrreg, $standard_superio{basereg_msb});
 		$addr = inb($datareg) << 8;
-		outb($addrreg, $superio{basereg} + 1);
+		outb($addrreg, $standard_superio{basereg_lsb});
 		$addr |= inb($datareg);
 		next unless ($addr & 0xfff8) == $typical_addr;
 
@@ -3601,7 +3627,7 @@ sub guess_superio_ld
 	}
 
 	# Be nice, restore original logical device
-	outb($addrreg, $superio{logdevreg});
+	outb($addrreg, $standard_superio{logdevreg});
 	outb($datareg, $oldldn);
 }
 
@@ -3610,6 +3636,14 @@ sub probe_superio
 {
 	my ($addrreg, $datareg, $chip) = @_;
 	my ($val, $addr);
+	my %superio;
+
+	# Use chip-specific registers if provided
+	if (exists $chip->{regs}) {
+		%superio = overlay_hash(\%standard_superio, $chip->{regs});
+	} else {
+		%superio = %standard_superio;
+	}
 
 	if (exists $chip->{check}) {
 		return 0 unless $chip->{check}($addrreg, $datareg);
@@ -3636,9 +3670,9 @@ sub probe_superio
 	outb($datareg, $chip->{logdev});
 
 	# Get the IO base address
-	outb($addrreg, $superio{basereg});
+	outb($addrreg, $superio{basereg_msb});
 	$addr = inb($datareg);
-	outb($addrreg, $superio{basereg} + 1);
+	outb($addrreg, $superio{basereg_lsb});
 	$addr = ($addr << 8) | inb($datareg);
 
 	# Check the activation register and base address
@@ -3721,9 +3755,9 @@ sub scan_superio
 		}
 
 		# did it work?
-		outb($addrreg, $superio{devidreg});
+		outb($addrreg, $standard_superio{devidreg});
 		$val = inb($datareg);
-		outb($addrreg, $superio{devidreg} + 1);
+		outb($addrreg, $standard_superio{devidreg} + 1);
 		$val = ($val << 8) | inb($datareg);
 		if ($val == 0x0000 || $val == 0xffff) {
 			print "No\n";

--MP_/NC2SSit_he0W5z5hjB=3OI+
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--MP_/NC2SSit_he0W5z5hjB=3OI+--

From: Hans de Goede <hdegoede@redhat.com>
Date: Sat, 14 Feb 2009 19:12:32 +0000
Subject: [lm-sensors] PATCH; sensors-detect: do not crash FSC Syleus IC's
Message-Id: <499717A0.6070002@redhat.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------020907060002000608060100"
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org

This is a multi-part message in MIME format.
--------------020907060002000608060100
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

As discussed on IRC the Syleus does not like our way of seeing if a device is 
present at a certain address, this patch implements a workaround consisting of 
doing a byte data read instead of a quick command or a byte read.

Once reviewed I can commit this myself.

Regards,

Hans

--------------020907060002000608060100
Content-Type: text/plain;
 name="sensors-detect-dont-crash-syleus.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline; filename="sensors-detect-dont-crash-syleus.patch"

Index: prog/detect/sensors-detect
===================================================================
--- prog/detect/sensors-detect	(revision 5642)
+++ prog/detect/sensors-detect	(working copy)
@@ -2629,7 +2629,14 @@
 {
 	my ($file, $addr, $funcs) = @_;
 
-	if (($addr >= 0x50 && $addr <= 0x5F)
+	if ($addr == 0x73) {
+		# Special case for FSC chips, as at least the Syleus locks
+		# up with our regular probe code. Note that to our current
+		# knowledge only FSC chips live on this address, and for them
+		# this probe method is safe
+		return 0 unless ($funcs & I2C_FUNC_SMBUS_READ_BYTE);
+		return i2c_smbus_access($file, SMBUS_READ, 0, SMBUS_BYTE_DATA, []);
+	} elsif (($addr >= 0x50 && $addr <= 0x5F)
 	 || ($addr >= 0x30 && $addr <= 0x37)) {
 		# This covers all EEPROMs we know of, including page protection
 		# addresses. Note that some page protection addresses will not

--------------020907060002000608060100
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--------------020907060002000608060100--

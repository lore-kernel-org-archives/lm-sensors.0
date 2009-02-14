From: Hans de Goede <hdegoede@redhat.com>
Date: Sat, 14 Feb 2009 19:13:31 +0000
Subject: [lm-sensors] PATCH: sensors-detect: detect FSC Hades and Syleus
Message-Id: <499717DB.2000905@redhat.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------090101010200090700080606"
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org

This is a multi-part message in MIME format.
--------------090101010200090700080606
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

This patch adds detection of the FSC Hades and Syleus to sensors-detect.

Regards,

Hans

--------------090101010200090700080606
Content-Type: text/plain;
 name="sensors-detect-fschds-n-fscsyl.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="sensors-detect-fschds-n-fscsyl.patch"

diff -up prog/detect/sensors-detect.fsc-rework prog/detect/sensors-detect
--- prog/detect/sensors-detect.fsc-rework	2009-02-14 19:49:38.000000000 +0100
+++ prog/detect/sensors-detect	2009-02-14 19:56:52.000000000 +0100
@@ -1025,6 +1025,16 @@ use vars qw(@i2c_adapter_names);
 		i2c_addrs => [0x73],
 		i2c_detect => sub { fsc_detect(@_, 5); },
 	}, {
+		name => "FSC Hades",
+		driver => "fschmd",
+		i2c_addrs => [0x73],
+		i2c_detect => sub { fsc_detect(@_, 6); },
+	}, {
+		name => "FSC Syleus",
+		driver => "fschmd",
+		i2c_addrs => [0x73],
+		i2c_detect => sub { fsc_detect(@_, 7); },
+	}, {
 		name => "ALi M5879",
 		driver => "to-be-written",
 		i2c_addrs => [0x2c..0x2d],
@@ -4648,6 +4658,8 @@ sub fsc_detect
 	return if $chip == 3 and $id ne 'HER';	# Hermes
 	return if $chip == 4 and $id ne 'HMD';	# Heimdal
 	return if $chip == 5 and $id ne 'HRC';	# Heracles
+	return if $chip == 6 and $id ne 'HDS';	# Hades
+	return if $chip == 7 and $id ne 'SYL';	# Syleus
 
 	return 8;
 }

--------------090101010200090700080606
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--------------090101010200090700080606--

From: Anish Patel <anish.mailing.list@gmail.com>
Date: Mon, 17 Jan 2011 16:14:02 +0000
Subject: [lm-sensors] patch to sensor-detect script to support SMSC EMC1023
Message-Id: <4D346ACA.8050601@gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------060402050906010500070405"
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org

This is a multi-part message in MIME format.
--------------060402050906010500070405
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

patch attached.


--------------060402050906010500070405
Content-Type: text/plain;
 name="sensors-detect.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="sensors-detect.patch"

*** sensors-detect	Fri Jan 14 11:11:56 2011
--- sensors-detect-new	Sat Jan 15 03:01:01 2011
***************
*** 1205,1210 ****
--- 1205,1215 ----
  		i2c_addrs => [0x18, 0x2a, 0x4c, 0x4d],
  		i2c_detect => sub { emc1403_detect(@_, 3); },
  	}, {
+ 		name => "SMSC_EMC1023",
+ 		driver => "emc1023",
+ 		i2c_addrs => [0x48,0x49,0x4c,0x4d],
+ 		i2c_detect => sub { emc1023_detect(@_); },
+ 	}, {
  		name => "ST STTS424",
  		driver => "jc42",
  		i2c_addrs => [0x18..0x1f],
***************
*** 5387,5392 ****
--- 5392,5418 ----
  	return 6;
  }
  
+ # Chip to detect:
+ # Registers used:
+ #   0xed: Device ID register
+ #   0xfe: Vendor ID register
+ #   0xff: Revision register
+ sub emc1023_detect
+ {
+ 	my ($file, $addr, $chip) = @_;
+ 	my $dev_id = i2c_smbus_read_byte_data($file, 0xed);
+ 	my $man_id = i2c_smbus_read_byte_data($file, 0xfe);
+ 	my $rev = i2c_smbus_read_byte_data($file, 0xff);
+ 
+ 	return unless $man_id == 0x5d;	# SMSC
+ 
+ 	return unless ($dev_id == 0x0c) || ($dev_id == 0x0d) || ($dev_id == 0x08) || ($dev_id == 0x09) ;
+ 	return unless $rev == 0x01;
+ 	
+ 	return 9;
+ }
+ 
+ 
  # This checks for non-FFFF values for temperature, voltage, and current.
  # The address (0x0b) is specified by the SMBus standard so it's likely
  # that this really is a smart battery.

--------------060402050906010500070405
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--------------060402050906010500070405--

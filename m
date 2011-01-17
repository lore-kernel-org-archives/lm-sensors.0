From: Anish Patel <anish.mailing.list@gmail.com>
Date: Mon, 17 Jan 2011 19:04:29 +0000
Subject: Re: [lm-sensors] patch to sensor-detect script to support SMSC
Message-Id: <4D3492BD.50503@gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------040502010908040004060103"
List-Id: <lm-sensors.vger.kernel.org>
References: <4D346ACA.8050601@gmail.com>
In-Reply-To: <4D346ACA.8050601@gmail.com>
To: lm-sensors@vger.kernel.org

This is a multi-part message in MIME format.
--------------040502010908040004060103
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

On 01/17/11 13:09, Guenter Roeck wrote:
> On Mon, Jan 17, 2011 at 11:14:02AM -0500, Anish Patel wrote:
>> patch attached.
>>
>> *** sensors-detect	Fri Jan 14 11:11:56 2011
>> --- sensors-detect-new	Sat Jan 15 03:01:01 2011
>> ***************
>> *** 1205,1210 ****
>> --- 1205,1215 ----
>>    		i2c_addrs =>  [0x18, 0x2a, 0x4c, 0x4d],
>>    		i2c_detect =>  sub { emc1403_detect(@_, 3); },
>>    	}, {
>> + 		name =>  "SMSC_EMC1023",
>> + 		driver =>  "emc1023",
>> + 		i2c_addrs =>  [0x48,0x49,0x4c,0x4d],
>> + 		i2c_detect =>  sub { emc1023_detect(@_); },
>> + 	}, {
>>    		name =>  "ST STTS424",
>>    		driver =>  "jc42",
>>    		i2c_addrs =>  [0x18..0x1f],
>> ***************
>> *** 5387,5392 ****
>> --- 5392,5418 ----
>>    	return 6;
>>    }
>>
>> + # Chip to detect:
>> + # Registers used:
>> + #   0xed: Device ID register
>> + #   0xfe: Vendor ID register
>> + #   0xff: Revision register
>> + sub emc1023_detect
>> + {
>> + 	my ($file, $addr, $chip) = @_;
> You don't pass $chip as argument, so you should not extract it either.
fixed
>> + 	my $dev_id = i2c_smbus_read_byte_data($file, 0xed);
>> + 	my $man_id = i2c_smbus_read_byte_data($file, 0xfe);
>> + 	my $rev = i2c_smbus_read_byte_data($file, 0xff);
>> +
>> + 	return unless $man_id == 0x5d;	# SMSC
>> +
>> + 	return unless ($dev_id == 0x0c) || ($dev_id == 0x0d) || ($dev_id == 0x08) || ($dev_id == 0x09) ;
> Per emc1023 datasheet, Product ID values should be 0x04 .. 0x07. Am I missing something ?
>
> Also, the Product ID and the chip address should match. So you could enhance detection
> by checking for the match.
i don't this this can happen, if you look at pg 2 of the data sheet, you 
can see where they hard code the addresses for the part.
when you read out of ED, it seems to have stored the lower 4bits of the 
address as the product ID.  this is all i can say for the 5 boards i 
have here with the emc1023-1 and emc1023-2.

corrected patch attached, driver to follow
> Thanks,
> Guenter
>
>

thanks
anish



--------------040502010908040004060103
Content-Type: text/plain;
 name="sensors-detect.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="sensors-detect.patch"

--- lm-sensors/prog/detect/sensors-detect	2011-01-17 03:12:10.000000000 -0500
+++ lm-sensors/prog/detect/sensors-detect.new	2011-01-17 13:32:45.751002637 -0500
@@ -1205,6 +1205,11 @@
 		i2c_addrs => [0x18, 0x2a, 0x4c, 0x4d],
 		i2c_detect => sub { emc1403_detect(@_, 3); },
 	}, {
+		name => "SMSC_EMC1023",
+		driver => "emc1023",
+		i2c_addrs => [0x48,0x49,0x4c,0x4d],
+		i2c_detect => sub { emc1023_detect(@_); },
+	}, {
 		name => "ST STTS424",
 		driver => "jc42",
 		i2c_addrs => [0x18..0x1f],
@@ -5387,6 +5392,27 @@
 	return 6;
 }
 
+# Chip to detect:
+# Registers used:
+#   0xed: Device ID register
+#   0xfe: Vendor ID register
+#   0xff: Revision register
+sub emc1023_detect
+{
+	my ($file, $addr) = @_;
+	my $dev_id = i2c_smbus_read_byte_data($file, 0xed);
+	my $man_id = i2c_smbus_read_byte_data($file, 0xfe);
+	my $rev = i2c_smbus_read_byte_data($file, 0xff);
+
+	return unless $man_id == 0x5d;	# SMSC
+
+	return unless ($dev_id == 0x0c) || ($dev_id == 0x0d) || ($dev_id == 0x08) || ($dev_id == 0x09) ;
+	return unless $rev == 0x01;
+	
+	return 8;
+}
+
+
 # This checks for non-FFFF values for temperature, voltage, and current.
 # The address (0x0b) is specified by the SMBus standard so it's likely
 # that this really is a smart battery.

--------------040502010908040004060103
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--------------040502010908040004060103--

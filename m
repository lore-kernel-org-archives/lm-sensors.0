From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Mon, 17 Jan 2011 18:09:07 +0000
Subject: Re: [lm-sensors] patch to sensor-detect script to support SMSC
Message-Id: <20110117180906.GA2682@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <4D346ACA.8050601@gmail.com>
In-Reply-To: <4D346ACA.8050601@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, Jan 17, 2011 at 11:14:02AM -0500, Anish Patel wrote:
> patch attached.
> 

> *** sensors-detect	Fri Jan 14 11:11:56 2011
> --- sensors-detect-new	Sat Jan 15 03:01:01 2011
> ***************
> *** 1205,1210 ****
> --- 1205,1215 ----
>   		i2c_addrs => [0x18, 0x2a, 0x4c, 0x4d],
>   		i2c_detect => sub { emc1403_detect(@_, 3); },
>   	}, {
> + 		name => "SMSC_EMC1023",
> + 		driver => "emc1023",
> + 		i2c_addrs => [0x48,0x49,0x4c,0x4d],
> + 		i2c_detect => sub { emc1023_detect(@_); },
> + 	}, {
>   		name => "ST STTS424",
>   		driver => "jc42",
>   		i2c_addrs => [0x18..0x1f],
> ***************
> *** 5387,5392 ****
> --- 5392,5418 ----
>   	return 6;
>   }
>   
> + # Chip to detect:
> + # Registers used:
> + #   0xed: Device ID register
> + #   0xfe: Vendor ID register
> + #   0xff: Revision register
> + sub emc1023_detect
> + {
> + 	my ($file, $addr, $chip) = @_;

You don't pass $chip as argument, so you should not extract it either.

> + 	my $dev_id = i2c_smbus_read_byte_data($file, 0xed);
> + 	my $man_id = i2c_smbus_read_byte_data($file, 0xfe);
> + 	my $rev = i2c_smbus_read_byte_data($file, 0xff);
> + 
> + 	return unless $man_id = 0x5d;	# SMSC
> + 
> + 	return unless ($dev_id = 0x0c) || ($dev_id = 0x0d) || ($dev_id = 0x08) || ($dev_id = 0x09) ;

Per emc1023 datasheet, Product ID values should be 0x04 .. 0x07. Am I missing something ?

Also, the Product ID and the chip address should match. So you could enhance detection
by checking for the match.

Thanks,
Guenter


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

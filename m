From: Jean Delvare <khali@linux-fr.org>
Date: Fri, 27 Jan 2012 19:38:19 +0000
Subject: Re: [lm-sensors] sensors-detect bug ?
Message-Id: <20120127203819.1bc1520a@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <4F22E64F.8060204@GNAServicesInc.com>
In-Reply-To: <4F22E64F.8060204@GNAServicesInc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Andrew,

On Fri, 27 Jan 2012 13:38:35 -0500, Andrew Smith wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> OK I take it back, maybe this is not a bug in sensors-detect. I was
> running sensors-detect because I thought the module was not being loaded
> / not found,  but I just found the real reason for the lack of sensor
> info by running DMESG
> 
> ACPI: resource it87 [io  0x0295-0x0296] conflicts with ACPI region SIOE
> [io 0x290-0x2af]

This is of course the real problem, see:
http://www.lm-sensors.org/wiki/FAQ/Chapter3#Mysensorshavestoppedworkinginkernel2.6.31

> That may be why I was getting the errors with sensors-detect?  If so,
> sorry for wasting your time.

No, the problem in sensors-detect is unrelated to the above. It seems
that on your system some of the i2c adapters have no name attribute.
Which kernel are you running? I'd like to see the output of the
following commands:

$ ls -l /sys/bus/i2c/devices/i2c-*/
$ grep . /sys/bus/i2c/devices/i2c-*/name

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

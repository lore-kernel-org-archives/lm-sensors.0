From: Clemens Ladisch <clemens@ladisch.de>
Date: Wed, 16 Feb 2011 15:25:53 +0000
Subject: Re: [lm-sensors] [PATCH] sensors-detect: DDR3 SPD EEPROM support
Message-Id: <4D5BEC81.3040503@ladisch.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <4D54FC00.1010600@ladisch.de>
In-Reply-To: <4D54FC00.1010600@ladisch.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean Delvare wrote:
> On Fri, 11 Feb 2011 10:06:08 +0100, Clemens Ladisch wrote:
> > +	if ($device_type >= 1 and $device_type <= 10) {
> 
> Device type 9 (FB-DIMM) also uses the CRC16, so this test is not
> correct. Not sure about type 10 (what the hell is "FB-DIMM Probe"?)

4.1.2 7.3:
| This field identifies the fundamental type of memory used on the
| assembly. The fundamental type of memory for FBDIMMs are DDR2 or
| FB-DIMM Probe (a unique Fundamental Type value to indicate logic
| analysis probe boards).

I don't think that such boards pretend to be memory modules (or that
somebody who uses them would expect sensors-detect to know about them).


Regards,
Clemens

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

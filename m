From: Nate Case <ncase@xes-inc.com>
Date: Fri, 20 Jun 2008 19:19:54 +0000
Subject: [lm-sensors] [PATCH v2 0/2] hwmon: (lm90) Enhancements for ADT7461
Message-Id: <1213989596-8716-1-git-send-email-ncase@xes-inc.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

These changes support extended mode operation for the ADT7461 which will
allow temperature readings from -64..191 degC instead of the current
limited range of 0..127 degC.  I decided to split up the changes so
that the first patch doesn't affect functionality, but just makes
preparations needed to make the second patch easier to follow.

This is the second version of the patch, which addresses the feedback
from Jean Delvare.  Changes from v1:

    * Force inline the *_from_reg() functions
    * Convert "? :" code to if/then
    * Don't force enabling of extended mode -- just use it if
      the chip is already in that mode
    * Use unsigned integers for adt7461 conversion functions
    * Clarified up comments as requested
    * Fix off-by-one errors in extended mode conversion functions

I verified that patch 1/2 does not change the functionality by
comparing the output of both the macros and the new static functions
over a large range of values.  For the extended mode conversions, I
verified the following register->temperature conversions (and vice
versa) to make sure all the corner cases are right:

	Temperature	1-byte		2-byte
	--------	------		------
	-65000		0x00		0x0000
	-64500		0x00		0x0000
	-64000		0x00		0x0000
	-63750		0x00		0x0040
	-63500		0x01		0x0080
	-63250		0x01		0x00c0
	-63000		0x01		0x0100
	-62750		0x01		0x0140
	-62500		0x02		0x0180
	-62250		0x02		0x01c0
	-62000		0x02		0x0200
	-250  		0x40		0x3fc0
	0		0x40		0x4000
	250   		0x40		0x4040
	500   		0x41		0x4080
	750   		0x41		0x40c0
	1000  		0x41		0x4100
	1250  		0x41		0x4140
	1500  		0x42		0x4180
	1750  		0x42		0x41c0
	2000  		0x42		0x4200
	190750 		0xff		0xfec0
	191000 		0xff		0xff00
	191250 		0xff		0xff40
	191500 		0xff		0xff80
	191750 		0xff		0xffc0
	192000 		0xff		0xffc0

--
Nate Case <ncase@xes-inc.com>

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

From: Hans de Goede <j.w.r.degoede@hhs.nl>
Date: Sun, 08 Jul 2007 18:56:16 +0000
Subject: [lm-sensors] fintek f71806f "support"
Message-Id: <46913350.70300@hhs.nl>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi all,

While updating the f71882fg wiki entry I noticed the f71806f entry said that 
there is no datasheet, however the same webpage offering the f71882fg datasheet 
has the f71806f datasheet too.

So I downloaded it to add detection code to sensors-detect, but we already 
detect it as a ... f71872f, because they have the same devid (fintek did the 
same with the f71882fg and the f71883fg) . I've been comparing all the hwmon 
pages of the f71806f and f71872f page by page, here are the results:

Harmless differences:
---------------------

1) The 71872 has hwmon register 09h "documented" as External BJT Offset
    Register, with all bits reserved.

2) The 71872 has  VIN_FAULT Mode Register 3  Index 39h, bit 7 documented,
    marked as r/w and ... reserved, the 71806 has it as just reserved

3) VIN_FAULT STATUS Register  Index 3Ah, bit 7 idem as 2)


Troublesome differences:
------------------------

1) The 71872 has T1 OFFSET Register -- Index 90h, and T2 at 91h and T3 at
    92h, which the 71806 lacks according to its datasheet


VID differences:
----------------

1) The 71872 has bit 3 of VID Control Register  Index 00h defined, for the
    71806 this bit is reserved


Notice that the identical device id means that sofar sensors-detect has been 
identifying the 71806 as a 71872, and most likely people have been loading and 
using the 71872 driver on this chip too, I assume that the 71872 driver uses 
the temp offset registers, and this could cause some troubles. Unfortunately I 
haven't been able to find a way in the datasheets to find out which chip we are 
really dealing with.

Regards,

Hans




_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

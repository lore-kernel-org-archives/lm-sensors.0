From: mrenzmann@otaku42.de (Michael Renzmann)
Date: Tue, 20 Dec 2005 10:13:18 +0000
Subject: [lm-sensors] [PATCH] LM77: correction of "register to temperature"
Message-Id: <1135073598.4459.63.camel@gimli>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Temperature conversion in lm77.c is currently broken for negative
temperatures, as discovered in
http://list.voyage.hk/pipermail/voyage-linux/2005-December/000540.html

National uses the upper 4 bits of the temperature registers to represent
the sign (all these are either set or unset at the same time), while the
lower 3 bits are either unused or represent the alarm status (depending
on which of the temperature registers you look at).

The "register to temperature" conversion doesn't properly consider these
sign bits. In the result they are used as part of the absolute
temperature value, so that negative temperatures are incorrectly
converted to huge positive values instead. 
(Side note: the "temperature to register" conversion works fine with
positive and negative values.)

The attached patch (which is against kernel 2.6.14.4) solves this issue.
It has been tested against all the sample values given in the LM77
datasheet (section 1.4) to proof it is working correctly.

Signed-off-by: Michael Renzmann <mrenzmann at otaku42.de>

-------------- next part --------------
A non-text attachment was scrubbed...
Name: lm77-2.6.14.4-temperature-conversion.patch
Type: text/x-patch
Size: 1076 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20051220/c2b18c8e/lm77-2.6.14.4-temperature-conversion.bin

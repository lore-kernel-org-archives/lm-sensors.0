From: ghannon@cspi.com (ghannon@cspi.com)
Date: Thu, 19 May 2005 06:25:06 +0000
Subject: I2C on Marvell GT-64260
Message-Id: <85256ED9.004E1304.00@pine.cspi.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi,

     I'm not on the list so please cc me directly on any
responses.

     I'm looking at getting i2c going on our custom board
that uses a Marvell GT-64260 as the system controller.  It is one of the
interfaces that uses registers to control the interface so that the
SDA and SCL lines are not directly accessible.

     I see that the iop3xx driver is very similar and I will be
starting from that.

     Questions...

     1)  Has anyone already done this work?
     If so, is it available?

     2)  I see that there are many differences between the
driver in the linuxppc-2_6 tree and the i2c-2.8.7 tarball, but they appear
to be mostly cosmetic.   (With the exception of the irq handler returning
IRQ_HANDLED for 2.6)    Would it be best for me to start from the
version in 2.6?     Are there other subtle but significant changes
that would make the driver not work in 2.4,  which is where I will be
using it at first?

     3)  When and if I get this working, would you be interested in
it, or should I, at some point, try to get it pushed into the 2.6 kernel
myself?

Thanks for any responses,

Gary Hannon


CSPI
ghannon at cspi dot com
(978) 663-7598 x 1509


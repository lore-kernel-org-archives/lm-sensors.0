From: phil@netroedge.com (phil@netroedge.com)
Date: Thu, 19 May 2005 06:23:28 +0000
Subject: lm75
Message-Id: <20020121132818.K876@Stimpy.netroedge.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <001901c1a061$8b6553b0$7d0110ac@Seranoa.com>
In-Reply-To: <001901c1a061$8b6553b0$7d0110ac@Seranoa.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Look at the bus drivers in lm_sensors2/kernel/busses, depending on the
hardware, there are different ways to drive the I2C bus.  But, the
chip drivers (like the lm75) can interface to any (or multiple) bus
drivers because they have the same API.  Does this help?  It think
there is a doc which explains this in the I2C project.


Phil

On Fri, Jan 18, 2002 at 03:48:55PM -0500, barry.fisher wrote:
> Hello:
> I have been looking at you lm-sensors site, have download the
> lm_sensors-2.6.2.tar.gz file and untarred everything and now I have a
> question. I am tring to develop a very simple device driver for the lm75
> device that we have as part of our product running on the 8260 ppc. I
> was looking at your source as a place to get some ideas and have tried
> to follow how the reads and writes work. It seems that everything boils
> down to a i2c_master_send and i2c_master_recv. In these routines a call
> is made to the
> adap->algo->master_xfer routine. Now the stupid question..where does
> this routine get set up. Is this something I have to supply? I just
> don't seem to be seeing the forest for the trees and would appreciate
> any hints whatsoever. Thanks!
> Regards,
> Barry O. Fisher
> Seranoa Networks
> Email: barry.fisher@seranoa.com

-- 
Philip Edelbrock -- IS Manager -- Edge Design, Corvallis, OR
   phil@netroedge.com -- http://www.netroedge.com/~phil
 PGP F16: 01 D2 FD 01 B5 46 F4 F0  3A 8B 9D 7E 14 7F FB 7A

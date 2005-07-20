From: ericb@aspsys.com (Eric J. Bowersox)
Date: Wed, 20 Jul 2005 01:30:51 +0000
Subject: [lm-sensors] LM93 driver for 2.6
Message-Id: <1121815671.1604.16.camel@wiz.dev.aspsys.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Well, after my *last* bout with new hardware that resulted in me dipping
my toe into chip driver hacking, we decided to start shipping
motherboards with yet *another* monitoring chip for which the driver
wasn't in the kernel.  This time, it was the Supermicro X6DHP
motherboard, which uses the National Semiconductor LM93...and this time,
I couldn't find a 2.6 port in work, so I had to do it myself.

After consulting with Mark Hoffman, the maintainer of the current LM93
driver (who confirmed that he had no 2.6 port in work and none planned),
I'm submitting this to the list for general review.  The patch is
against kernel 2.6.12.2.  Perhaps it can be passed along up the line
once it has been adequately vetted.

Thanks in advance for any feedback.

-- 
Eric J. Bowersox, Software Engineer     Aspen Systems, Inc.
<ericb@aspsys.com>                      3900 Youngfield Street
Tel: +01 303 431 4606 x113              Wheat Ridge, CO  80033, USA
Fax: +01 303 431 7196                   <http://www.aspsys.com>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: lm93-driver-2.6.12.2.patch
Type: text/x-patch
Size: 74068 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20050719/deedf885/lm93-driver-2.6.12.2-0001.bin

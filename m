From: barry.fisher@seranoa.com (barry.fisher)
Date: Thu, 19 May 2005 06:23:28 +0000
Subject: lm75
Message-Id: <001901c1a061$8b6553b0$7d0110ac@Seranoa.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello:
I have been looking at you lm-sensors site, have download the
lm_sensors-2.6.2.tar.gz file and untarred everything and now I have a
question. I am tring to develop a very simple device driver for the lm75
device that we have as part of our product running on the 8260 ppc. I
was looking at your source as a place to get some ideas and have tried
to follow how the reads and writes work. It seems that everything boils
down to a i2c_master_send and i2c_master_recv. In these routines a call
is made to the
adap->algo->master_xfer routine. Now the stupid question..where does
this routine get set up. Is this something I have to supply? I just
don't seem to be seeing the forest for the trees and would appreciate
any hints whatsoever. Thanks!
Regards,
Barry O. Fisher
Seranoa Networks
Email: barry.fisher@seranoa.com
-------------- next part --------------
An HTML attachment was scrubbed...
URL: http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20020118/94959579/attachment.html

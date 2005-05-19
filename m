From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:33 +0000
Subject: bt869 driver
Message-Id: <20050129234511.5dc19d3b.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Gerd,

The lm_sensors project hosts a driver for the BT869 video-out chip,
which I am told is found (among others) on Voodoo3 boards. The driver is
for Linux 2.4 and gives control of the video out parameters through
procfs.

http://www2.lm-sensors.nu/~lm78/cvs/browse.cgi/lm_sensors2/kernel/chips/bt869.c

People are asking for a Linux 2.6 port for quite some time now. I
believe that such a driver would better live in drivers/media/video than
drivers/i2c/chips, and I guess that the standard video-out drivers have
a completely different interface (sysctl instead of procfs?).

Do you have any opinion about this? If the BT869 chip integrates
properly in the media/video subsystem, I would be happy to see it moved
there. Don't know how much work this would be though, and have no chip
myself to hack/test anything.

Thanks,
-- 
Jean Delvare

From: r.marek@sh.cvut.cz (Rudolf Marek)
Date: Wed, 23 Aug 2006 15:26:09 +0000
Subject: [lm-sensors] [PATCH] AMD K8 digital sensor - take3
Message-Id: <44EC7391.2040700@sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello,

This patch adds support for the temperature sensor(s) found in AMD K8 CPUs.

Signed-off-by: Rudolf Marek <r.marek at sh.cvut.cz>

I fixed the remaining issues, I got rid of REG_TEMP_T. I left the different 
register i/o sizes. It is neccessary for future extensions of the driver.

Please apply.

Regards
Rudolf

-------------- next part --------------
A non-text attachment was scrubbed...
Name: k8temp3.patch
Type: text/x-patch
Size: 10665 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20060823/7f80120f/attachment.bin 

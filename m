From: r.marek@sh.cvut.cz (Rudolf Marek)
Date: Sat, 27 May 2006 09:03:33 +0000
Subject: [lm-sensors] [PATCH] New VID codes for Intel Core and Conroe
Message-Id: <447815E5.5060601@sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello Yuan,

I have finally put the patch together. It was a bit tricky without Conroe
datasheet ;) I added the mobile Core processor support too. Please can
you give a try and see if it reports meaningful results which should be round
1.2V for Conroe?

Thanks goes to Rene Pavlik for the formula verfication.

Regards
Rudolf

-------------- next part --------------
A non-text attachment was scrubbed...
Name: vid_core.patch
Type: text/x-patch
Size: 2683 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20060527/257c13cd/vid_core.bin

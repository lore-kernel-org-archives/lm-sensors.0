From: r.marek@assembler.cz (Rudolf Marek)
Date: Sun, 24 Sep 2006 20:57:59 +0000
Subject: [lm-sensors] [PATCH] W83627EHF fix fan5
Message-Id: <4516F157.9060407@assembler.cz>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello,

Following patch fixes the detection of fan5 and preserves the bit between the
register writes, because the bit is write only.

Signed-off-by: Rudolf Marek <r.marek at assembler.cz>

Regards
Rudolf
-------------- next part --------------
A non-text attachment was scrubbed...
Name: fan5fix2.patch
Type: text/x-patch
Size: 1857 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20060924/f4aa0a84/attachment.bin 

From: drewie@freemail.hu (Andras BALI)
Date: Thu, 19 May 2005 06:25:05 +0000
Subject: [PATCH 2.6] Add support for LM77
Message-Id: <1089231956.4800.63.camel@null>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Greg,

This patch (against the current stack) adds support for the
LM77 sensor chips made by National Semiconductor. Formerly
this was claimed by the LM75 driver but when I got hold of an
embedded board (built around the National Geode SC1100 CPU),
which was equipped with an LM77, it turned out that the two
chips are not compatible.

It has been developed with help of, reviewed and approved
by Jean Delvare.

Thanks.

Signed-off-by: Andras Bali <drewie@freemail.hu>

-------------- next part --------------
A non-text attachment was scrubbed...
Name: linux-2.6.7-mm6-lm77.patch
Type: text/x-patch
Size: 14940 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20040707/344a652f/linux-2.6.7-mm6-lm77.bin

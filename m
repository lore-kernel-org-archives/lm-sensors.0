From: r.marek@sh.cvut.cz (Rudolf Marek)
Date: Sat, 15 Apr 2006 22:34:21 +0000
Subject: [lm-sensors] [PATCH] fix the nr of bits in VID formulas
Message-Id: <444174ED.5020102@sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello

Following patch trims the VID value to correct number of bits
for each VRM.

Jean, please apply. Compile tested.
Andy, can you try?

Signed-off-by: Rudolf Marek <r.marek at sh.cvut.cz>

Thanks,

Regards
Rudolf

PS: suspend to RAM is working ;)

-------------- next part --------------
An embedded and charset-unspecified text was scrubbed...
Name: patch3
Url: http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20060416/08a14666/patch3.pl

From: drewie@freemail.hu (Andras BALI)
Date: Thu, 19 May 2005 06:25:05 +0000
Subject: lm77 on national sc1100
Message-Id: <1089100803.32259.121.camel@null>
List-Id: <lm-sensors.vger.kernel.org>
References: <1088690691.2862.25.camel@null>
In-Reply-To: <1088690691.2862.25.camel@null>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

So, here is an updated version of the lm77 driver that exports the
hysteresis for all three limits as an absolute value.

While testing I figured out that the low three bits of the temperature
limit registers are actually not unused: they contain the same status
bits as the temperature registers (and indeed, the datasheet doesn't say
that they should be 0 like it does for the high 3 bits of the config
register, it just declares them as undefined). Therefore I had to remove
the unused bits detection step from the source (apart from the check on
the config register) and I suggest that the same should be done in the
sensors-detect script.

Thanks,
Andras

-------------- next part --------------
A non-text attachment was scrubbed...
Name: lm77.c
Type: text/x-csrc
Size: 12720 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20040706/3784598c/lm77.bin

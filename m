From: r.marek@sh.cvut.cz (Rudolf Marek)
Date: Wed, 03 Aug 2005 00:33:25 +0000
Subject: [lm-sensors] [PATCH] lm93 driver for 2.6, second try
Message-Id: <42EFF48F.2040300@sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <1122934191.32459.18.camel@wiz.dev.aspsys.com>
In-Reply-To: <1122934191.32459.18.camel@wiz.dev.aspsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi again,

What about eeproms? Can you load eeprom driver (no lm93) and check if sensors command
reports correct RAM module size?

Or aletrnatively you can try to use i2cdump (see manpage how to deal with block transfers) to dump it
using bytemode and later blockmode. If dumps are OK it means that bus is OK and there is some problem
with lm93 or its driver.

I hope it helps

Regards
Rudolf

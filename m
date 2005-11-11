From: r.marek@sh.cvut.cz (Rudolf Marek)
Date: Fri, 11 Nov 2005 13:02:59 +0000
Subject: [lm-sensors] i2c -dev and i2c bus driver
Message-Id: <43744C4B.8070806@sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <24EB6743805F45478251E18DEBF3F6BE8133DD@csserver.circadiant.com>
In-Reply-To: <24EB6743805F45478251E18DEBF3F6BE8133DD@csserver.circadiant.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Howard Wang wrote:
> Hi Rudolf,
> 
> I got the scx200_i2c driver working on the second i2c bus, which is acb1,
> however, when I use i2cset and i2cdump, it seems that only 128 bytes is
> accessible, it repeats after 128 bytes, while my device is:
> microchip 24AA128 which is 128K bits (16K bytes). see attached log:
> in fact, I just set the first 10 bytes and it repeats after 128 bytes.
> 
> any suggestions ?

I'm in hury, must go back to my hometown, so just quick note before I leave:
Perhaps it uses two bytes addressing. You will need special driver for it

Hoever some driver that works for 16KBit eeproms is here.
(somewhere in this thread)
http://lists.lm-sensors.org/pipermail/lm-sensors/2005-July/012987.html

Maybe you can take a look and extend it to your needs. I can take a look ttoday in evening or
at weekend.

Regards
Rudolf

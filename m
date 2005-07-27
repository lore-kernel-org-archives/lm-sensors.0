From: khali@linux-fr.org (Jean Delvare)
Date: Wed, 27 Jul 2005 12:57:40 +0000
Subject: [lm-sensors] [PATCH] I2C W83792D driver 1/3
Message-Id: <L0DMuJPu.1122461474.7585580.khali@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050727092431.10185.qmail@desitka.sh.cvut.cz>
In-Reply-To: <20050727092431.10185.qmail@desitka.sh.cvut.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi Rduolf,

On 2005-07-27, Rudolf Marek wrote:
> Uff my bad I did not check this. On the other hand the address can be
> changed to virtually any address via CR48, with condition that two lowest
> bits cant be changed.

I think the two lowest bits can be changed. Their initial value is set at
power-up time depending on two pin levels, just like is the case for
subclients, but I do believe this can be changed afterwards, just like
is the case for subclients too. Not that it really matters...

> Should we go for range 0x20 - 0x2f ?

No. That's what we did for it87, result is that since the driver was
written, only default address 0x2d was seen. I can't think of any
reason why someone would use a different address than the four possible
power-up default ones, especially since this chip has no other interface
IIRC, so the power-up address would have to be used at least once to
change the address at CR48. If the power-up address works to do that,
there is no reason not to use it afterwards as well.

So please stick to 0x2c - 0x2f. If anyone ever needs more, that's
exactly what the probe parameter is for (but I'm quite certain it will
never happen).

Thanks,
--
Jean Delvare

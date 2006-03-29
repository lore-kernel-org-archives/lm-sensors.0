From: ijc@hellion.org.uk (Ian Campbell)
Date: Wed, 29 Mar 2006 14:00:07 +0000
Subject: [lm-sensors] I2C_PCA_ISA causes boot delays (was re: sis96x
Message-Id: <1143640808.22244.26.camel@localhost.localdomain>
List-Id: <lm-sensors.vger.kernel.org>
References: <20060317042019.GC3446@jupiter.solarsys.private>
	 <20060320230037.29764.qmail@web26902.mail.ukl.yahoo.com>
	 <20060329034510.GA8309@jupiter.solarsys.private>
In-Reply-To: <20060329034510.GA8309@jupiter.solarsys.private>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Mark M. Hoffman" <mhoffman@lightlink.com>
Cc: Etienne Lorrain <etienne_lorrain@yahoo.fr>, linux-kernel@vger.kernel.org, lm-sensors <lm-sensors@lm-sensors.org>

On Tue, 2006-03-28 at 22:45 -0500, Mark M. Hoffman wrote:
> 
> This alone is the cause of the delay.  (I have confirmed it by running
> some similar .configs here.)  You almost certainly don't own this
> specialized piece of hardware.  Worse still, that particular driver
> has no code to detect whether or not the hardware is present.  I cc'ed
> the listed driver author (Ian) just in case this might be corrected...
> but I guess there is no way to fix it.
> 
> So the delay is (1) an I2C bus driver that is not actually present,
> trying to probe for (2) seven different sensors chip drivers that
> certainly aren't present on the nonexistent bus.  Timeouts ensue.
> 
> So unless Ian knows a better way to detect that bus driver... the best
> I can advise is to *not* build in those drivers for hardware that you
> do not have. 

I don't work at Arcom anymore so I don't have access to the hardware,
but I don't know of a better way off the top of my head how to detect
the presence of the PCA chip.

You are unlikely to have the particular PC/104 card the driver was
written for. If I recall correctly PCA chip itself doesn't do ISA (it
has simple processor bus chip select type arrangement I think) but the
PC/104 card in question has a small CPLD which does the address decoding
for ISA. I guess you are unlikely to find another ISA card which has the
PCA chip on it.

It's possible that you might have an embedded board with the PCA chip
directly on it -- but if you don't then I don't know why you would
enable the driver.

Ian.
-- 
Ian Campbell

To save a single life is better than to build a seven story pagoda.



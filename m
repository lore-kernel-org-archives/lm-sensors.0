From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 03 Nov 2005 11:27:47 +0000
Subject: [lm-sensors] PEC support in i2c/lm_sensors CVS
Message-Id: <0udXqZmF.1131012920.0386690.khali@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <20051030171335.34da6461.khali@linux-fr.org>
In-Reply-To: <20051030171335.34da6461.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi Mark,

On 2005-11-03, Mark M. Hoffman wrote:
> I finally reviewed those patches; one suggestion, to apply if you like...
>
> This patch tweaks i2c-i801.c so that the driver always sets the SMBAUXCTL
> register (which enables/disables PEC) explicitly before each transaction.

I agree, I prefer it that way too. I'll apply that patch, and I'll test
it on my ICH3M too. My testing possibilities are limited though, as I
only have EEPROMs on that bus.

I was expecting more comments from your review, about the PEC core code
rewrite itself. Inidivual SMBus drivers can always be tweaked, it isn't
really related to the core rework. Do you have any kind of objection to
the rewrite itself? My implementation is completely different from what
we had before. It also has slightly different expectations from both bus
and chip drivers. Just because I think it is better doesn't mean
everyone has to agree. I might have missed something. I would hate it if
people will come and complain one year from now that this rewrite was a
bad idea, for a reason I failed to think of.

Given that the new implementation is already in Linus' tree for Linux
2.6, it's there to stay unless someone complains. The point about
i2c/lm_sensors CVS is still open though. I will have to interpret the
lack of objection as a green light for me to merge my rewrite in there.
Much like everything else I do anyway, but this time the effects are
much broader.

Thanks,
--
Jean Delvare

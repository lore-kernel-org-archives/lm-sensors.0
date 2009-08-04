From: David Brownell <david-b@pacbell.net>
Date: Tue, 04 Aug 2009 02:16:02 +0000
Subject: Re: [lm-sensors] [PATCH 0/7] Device table matching for SPI subsystem
Message-Id: <200908031916.02880.david-b@pacbell.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <20090729170345.GA26787@oksana.dev.rtsoft.ru>
In-Reply-To: <20090729170345.GA26787@oksana.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: avorontsov@ru.mvista.com
Cc: Andrew Morton <akpm@linux-foundation.org>, David Brownell <dbrownell@users.sourceforge.net>, David Woodhouse <dwmw2@infradead.org>, Grant Likely <grant.likely@secretlab.ca>, Jean Delvare <khali@linux-fr.org>, linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org, linuxppc-dev@ozlabs.org

On Wednesday 29 July 2009, Anton Vorontsov wrote:
> 	platform_data is overkill for m25p80 chips, the
> driver only needs to know exact chip model, and that's what device
> tables are for.

To be fair, the platform_data also supports partitioning
and labeling e.g. for cmdlinepart ... though I'd tend to
agree that most SPI flash chips are kind of small (so
they're mostly just one smallish partition).




_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

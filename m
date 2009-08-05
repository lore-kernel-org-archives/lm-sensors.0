From: Anton Vorontsov <avorontsov@ru.mvista.com>
Date: Wed, 05 Aug 2009 00:54:04 +0000
Subject: Re: [lm-sensors] [PATCH 0/7] Device table matching for SPI subsystem
Message-Id: <20090805005404.GA14451@oksana.dev.rtsoft.ru>
List-Id: <lm-sensors.vger.kernel.org>
References: <20090729170345.GA26787@oksana.dev.rtsoft.ru>
 <200908031916.02880.david-b@pacbell.net>
In-Reply-To: <200908031916.02880.david-b@pacbell.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Brownell <david-b@pacbell.net>
Cc: Andrew Morton <akpm@linux-foundation.org>, David Brownell <dbrownell@users.sourceforge.net>, David Woodhouse <dwmw2@infradead.org>, Grant Likely <grant.likely@secretlab.ca>, Jean Delvare <khali@linux-fr.org>, linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org, linuxppc-dev@ozlabs.org

On Mon, Aug 03, 2009 at 07:16:02PM -0700, David Brownell wrote:
> On Wednesday 29 July 2009, Anton Vorontsov wrote:
> > 	platform_data is overkill for m25p80 chips, the
> > driver only needs to know exact chip model, and that's what device
> > tables are for.
> 
> To be fair, the platform_data also supports partitioning
> and labeling e.g. for cmdlinepart ...

With OF we do partitioning and labling via drivers/mtd/ofpart.c.

Though, so far there is no support for OF partitions in the m25p80
driver. I think we'd better put the OF partitions probing into
parse_mtd_partitions(), and avoid calling of_mtd_parse_partitons()
directly...

Thanks,

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

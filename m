From: Artem Bityutskiy <dedekind1@gmail.com>
Date: Tue, 25 Aug 2009 14:14:04 +0000
Subject: Re: [lm-sensors] [PATCH v2 0/6] Device table matching for SPI
Message-Id: <1251209644.3514.0.camel@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <20090731003957.GA23982@oksana.dev.rtsoft.ru>
	 <1249889723.19638.13.camel@localhost>
	 <20090818214440.GA21391@oksana.dev.rtsoft.ru>
In-Reply-To: <20090818214440.GA21391@oksana.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: avorontsov@ru.mvista.com
Cc: Andrew Morton <akpm@linux-foundation.org>, Ben Dooks <ben@fluff.org>, David Brownell <dbrownell@users.sourceforge.net>, David Woodhouse <dwmw2@infradead.org>, Grant Likely <grant.likely@secretlab.ca>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Jean Delvare <khali@linux-fr.org>, linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org, linuxppc-dev@ozlabs.org

On Wed, 2009-08-19 at 01:44 +0400, Anton Vorontsov wrote:
> On Mon, Aug 10, 2009 at 10:35:23AM +0300, Artem Bityutskiy wrote:
> > On Fri, 2009-07-31 at 04:39 +0400, Anton Vorontsov wrote:
> > > Andrew,
> > > 
> > > This new patch set overwrites following patches:
> > > 
> > >   hwmon-lm70-convert-to-device-table-matching.patch
> > >   hwmon-adxx-convert-to-device-table-matching.patch
> > >   spi-merge-probe-and-probe_id-callbacks.patch
> > >   spi-prefix-modalias-with-spi.patch
> > >   of-remove-stmm25p40-alias.patch
> > >   mtd-m25p80-convert-to-device-table-matching.patch
> > >   spi-add-support-for-device-table-matching.patch
> > 
> > Are you going to send v3 and address David's comments?
> 
> No v3, but I'm going to address David's comments in a follow up
> patch set where I'll change the probing code anyway.
> 
> > Do you want some of these patches to go via the MTD tree or
> > they better go as a series via some other tree?
> 
> Um.. The MTD patches depend on SPI subsystem changes... If
> David and Andrew are OK with SPI patches going through MTD tree,
> then I'm fine with it as well.

If you are not sure, then I suggest to make these go through something
else (not MTD tree).

-- 
Best Regards,
Artem Bityutskiy (Артём Битюцкий)


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

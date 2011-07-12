From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Date: Tue, 12 Jul 2011 08:22:17 +0000
Subject: Re: [lm-sensors] [PATCH v3] MAX1111: Fix Race condition
Message-Id: <20110712082217.GA16141@sirena.org.uk>
List-Id: <lm-sensors.vger.kernel.org>
References: <1310421038-14823-1-git-send-email-morpheus.ibis@gmail.com>
	<20110712093606.5db834cb@endymion.delvare>
	<1628512.b7CSRB10BJ@bloomfield>
In-Reply-To: <1628512.b7CSRB10BJ@bloomfield>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Tue, Jul 12, 2011 at 10:04:55AM +0200, Pavel Herrmann wrote:
> On Tuesday 12 of July 2011 09:36:06 Jean Delvare wrote:

> > Honestly, I have no idea what "causing one thread having pointers to
> > memory on or above other threads stack" means (nor why this would be
> > bad.)

> the long-winded story is that thread A writes a pointer onto its stack into 
> the drvdata as part of spi_sync call, then thread B comes in and puts a 
> pointer onto its stack into the drvdata, at the end of spi_sync thread A uses 
> this pointer (assuming it is unchanged), which is pointing either onto valid 
> stack of thread B or somewhere above it (if thread B already returned)

That's just a use after free bug, the fact that the variables are on the
stacks of other threads isn't the issue, the issue is that the two
threads that are sharing state arne't properly synchronized.

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

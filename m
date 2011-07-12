From: Pavel Herrmann <morpheus.ibis@gmail.com>
Date: Tue, 12 Jul 2011 08:04:55 +0000
Subject: Re: [lm-sensors] [PATCH v3] MAX1111: Fix Race condition causing
Message-Id: <1628512.b7CSRB10BJ@bloomfield>
List-Id: <lm-sensors.vger.kernel.org>
References: <1310421038-14823-1-git-send-email-morpheus.ibis@gmail.com>
	<20110712093606.5db834cb@endymion.delvare>
In-Reply-To: <20110712093606.5db834cb@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Tuesday 12 of July 2011 09:36:06 Jean Delvare wrote:
> On Mon, 11 Jul 2011 23:50:38 +0200, Pavel Herrmann wrote:
> > spi_sync call uses its spi_message parameter to keep completion
> > information, using a drvdata structure is not thread-safe, potentially
> > causing one thread having pointers to memory on or above other threads
> > stack. use mutex to prevent multiple access
> 
> Honestly, I have no idea what "causing one thread having pointers to
> memory on or above other threads stack" means (nor why this would be
> bad.)

the long-winded story is that thread A writes a pointer onto its stack into 
the drvdata as part of spi_sync call, then thread B comes in and puts a 
pointer onto its stack into the drvdata, at the end of spi_sync thread A uses 
this pointer (assuming it is unchanged), which is pointing either onto valid 
stack of thread B or somewhere above it (if thread B already returned)

> Patch applied nevertheless, as it fixes an actual bug which should be
> fixed ASAP. Thanks for your contribution.

thanks

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

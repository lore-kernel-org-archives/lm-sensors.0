From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 12 Jul 2011 08:40:41 +0000
Subject: Re: [lm-sensors] [PATCH v3] MAX1111: Fix Race condition causing
Message-Id: <20110712104041.542fc402@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1310421038-14823-1-git-send-email-morpheus.ibis@gmail.com>
	<20110712093606.5db834cb@endymion.delvare>
	<1628512.b7CSRB10BJ@bloomfield>
In-Reply-To: <1628512.b7CSRB10BJ@bloomfield>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Tue, 12 Jul 2011 10:04:55 +0200, Pavel Herrmann wrote:
> On Tuesday 12 of July 2011 09:36:06 Jean Delvare wrote:
> > On Mon, 11 Jul 2011 23:50:38 +0200, Pavel Herrmann wrote:
> > > spi_sync call uses its spi_message parameter to keep completion
> > > information, using a drvdata structure is not thread-safe, potentially
> > > causing one thread having pointers to memory on or above other threads
> > > stack. use mutex to prevent multiple access
> > 
> > Honestly, I have no idea what "causing one thread having pointers to
> > memory on or above other threads stack" means (nor why this would be
> > bad.)
> 
> the long-winded story is that thread A writes a pointer onto its stack into 
> the drvdata as part of spi_sync call, then thread B comes in and puts a 
> pointer onto its stack into the drvdata, at the end of spi_sync thread A uses 
> this pointer (assuming it is unchanged), which is pointing either onto valid 
> stack of thread B or somewhere above it (if thread B already returned)

OK, I understand now, thanks for the explanation. But these low-level
technical details have little interest for explaining what your patch
does and why it is needed.

Here, the key problem was that the code assumed exclusive access to
drvdata for the duration of max1111_read() but no mechanism was in
place to guarantee this. It's not even limited to spi_sync and how it
works internally. Just looking at max1111_read() without any knowledge
of the spi subsystem, it is pretty clear that data->tx_buf and
data->rx_buf could get corrupted if max1111_read() runs twice in
parallel. As a matter of fact, your fix doesn't just protect the call
to spi_sync(), it protects data->tx_buf and data->rx_buf too.

The stack thing may be how the bug manifested in your case, but once
the issue is understood as a whole, the patch description should not
include more details than needed. You should really limit yourself to
the higher level needed to understand why the change is necessary and
correct.

Thanks,
-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

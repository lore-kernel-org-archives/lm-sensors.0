From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Tue, 12 Jul 2011 17:20:17 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (max1111) Avoid extra memory
Message-Id: <20110712172017.GA25577@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20110712110152.4eead147@endymion.delvare>
In-Reply-To: <20110712110152.4eead147@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, Jul 12, 2011 at 12:45:22PM -0400, Jean Delvare wrote:
> On Tue, 12 Jul 2011 09:40:33 -0700, Guenter Roeck wrote:
> > On Tue, Jul 12, 2011 at 05:01:52AM -0400, Jean Delvare wrote:
> > > We can allocate the tx and rx buffers as part of our data structure.
> > > Doing so is faster and spares memory.
> > > 
> > > Signed-off-by: Jean Delvare <khali@linux-fr.org>
> > > ---
> > > Can anyone with a MAX1111 device try and report please?
> > > 
> > Reason for using allocated buffers may have been to ensure (word/cache line) alignment.
> > Not really sure if that is a valid argument with 1/2 byte buffers, though.
> 
> And such an alignment would belong to the bus driver rather than the
> SPI device driver. At least this is the way we do it for I2C...
> 
Possibly, and makes sense (how does the device driver know ?), but for USB
they had me do it in the I2C master driver ...  I ensured alignment by placing
the buffers at the beginning of the allocated memory.

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

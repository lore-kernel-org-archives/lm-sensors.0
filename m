From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Date: Tue, 23 Sep 2008 07:23:25 +0000
Subject: Re: [lm-sensors] [PATCH 6/8] hwmon: add max1111/max1110 Low-power
Message-Id: <20080923072325.GA22016@flint.arm.linux.org.uk>
List-Id: <lm-sensors.vger.kernel.org>
References: <f17812d70809022312y6fd288ffu2607761414152f77@mail.gmail.com>
In-Reply-To: <f17812d70809022312y6fd288ffu2607761414152f77@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, Sep 23, 2008 at 09:31:09AM +0800, Eric Miao wrote:
> > Allocating such small buffers using kmalloc seems pretty inefficient.
> > At the very least, I would allocate both buffers at once. But quite
> > frankly I don't get why you don't just make these buffers part of
> > struct max1111_data. This would even make the structure smaller!
> >
> 
> I originally place the buffer within "struct max1111_data" but received
> a mail from David Brownell suggesting using a kmalloc() buffer, so that
> DMA mode will work better with the cache alignment and trailing bytes,
> though PIO can just work happily. I don't know the specific reason for
> this, honestly.

Having cachelines overlap with other data which may be modified during
the DMA causes problems on non-cache coherent hardware.  It's much
safer to ensure that DMA buffers don't share cache lines with anything
else.

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

From: David Brownell <david-b@pacbell.net>
Date: Tue, 23 Sep 2008 05:15:52 +0000
Subject: Re: [lm-sensors] [PATCH 6/8] hwmon: add max1111/max1110 Low-power
Message-Id: <200809222215.53089.david-b@pacbell.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <f17812d70809022312y6fd288ffu2607761414152f77@mail.gmail.com>
In-Reply-To: <f17812d70809022312y6fd288ffu2607761414152f77@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On Monday 22 September 2008, Eric Miao wrote:
> >> + =A0 =A0 data->rx_buf =3D kmalloc(MAX1111_RX_BUF_SIZE, GFP_KERNEL);
> >> + =A0 =A0 if (!data->rx_buf) {
> >> + =A0 =A0 =A0 =A0 =A0 =A0 kfree(data->tx_buf);
> >> + =A0 =A0 =A0 =A0 =A0 =A0 return -ENOMEM;
> >> + =A0 =A0 }
> >
> > Allocating such small buffers using kmalloc seems pretty inefficient.
> > At the very least, I would allocate both buffers at once. But quite
> > frankly I don't get why you don't just make these buffers part of
> > struct max1111_data. This would even make the structure smaller!
> >
>=20
> I originally place the buffer within "struct max1111_data" but received
> a mail from David Brownell suggesting using a kmalloc() buffer, so that
> DMA mode will work better with the cache alignment and trailing bytes,
> though PIO can just work happily. I don't know the specific reason for
> this, honestly.

The phrase is "cache line sharing".  If you make sure the buffer doesn't
share its cache line with something the CPU may modify while the DMA is
happening, you're OK ... and using a dedicated kmalloc buffer guarantees
that.  (So will sticking buffers at the end of a struct, like max1111_data,
annotated as "____cacheline_aligned", in many cases.)

On most ARMs, L1 and L2 caches are not DMA-coherent.  So when both DMA
and CPU write to some memory, one can overwrite the other if you're
sloppy about buffer allocation.


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

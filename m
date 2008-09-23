From: Trent Piepho <tpiepho@freescale.com>
Date: Tue, 23 Sep 2008 09:52:41 +0000
Subject: Re: [lm-sensors] [PATCH 6/8] hwmon: add max1111/max1110 Low-power
Message-Id: <Pine.LNX.4.64.0809230240190.7680@t2.domain.actdsltmp>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="-1463811584-224022065-1222163561=:7680"
List-Id: <lm-sensors.vger.kernel.org>
References: <f17812d70809022312y6fd288ffu2607761414152f77@mail.gmail.com>
In-Reply-To: <f17812d70809022312y6fd288ffu2607761414152f77@mail.gmail.com>
To: lm-sensors@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463811584-224022065-1222163561=:7680
Content-Type: TEXT/PLAIN; charset=X-UNKNOWN; format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Mon, 22 Sep 2008, David Brownell wrote:
> On Monday 22 September 2008, Eric Miao wrote:
>>>> + =A0 =A0 data->rx_buf =3D kmalloc(MAX1111_RX_BUF_SIZE, GFP_KERNEL);
>>>> + =A0 =A0 if (!data->rx_buf) {
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 kfree(data->tx_buf);
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 return -ENOMEM;
>>>> + =A0 =A0 }
>>>
>>> Allocating such small buffers using kmalloc seems pretty inefficient.
>>> At the very least, I would allocate both buffers at once. But quite
>>> frankly I don't get why you don't just make these buffers part of
>>> struct max1111_data. This would even make the structure smaller!
>>>
>>
>> I originally place the buffer within "struct max1111_data" but received
>> a mail from David Brownell suggesting using a kmalloc() buffer, so that
>> DMA mode will work better with the cache alignment and trailing bytes,
>> though PIO can just work happily. I don't know the specific reason for
>> this, honestly.
>
> The phrase is "cache line sharing".  If you make sure the buffer doesn't
> share its cache line with something the CPU may modify while the DMA is
> happening, you're OK ... and using a dedicated kmalloc buffer guarantees
> that.  (So will sticking buffers at the end of a struct, like max1111_dat=
a,
> annotated as "____cacheline_aligned", in many cases.)

Another alternative:

typedef ____cacheline_aligned char cacheline_barrier_t[0];

struct max1111_data {
 =09u8 buffer[BUF_SIZE];
 =09cacheline_barrier_t barrier;

 =09int whatever;
 =09...
 =09long something_else;

 =09cacheline_barrier_t barrier2;
 =09u8 also_gets_its_own_cacheline[BUF_SIZE];
};

One could also have ARM define:
typedef ____cacheline_aligned char dma_padding_t[0];

And x86, etc. would define:
typedef char dma_padding_t[0];

Then other arches don't get wasted space.
---1463811584-224022065-1222163561=:7680
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
---1463811584-224022065-1222163561=:7680--

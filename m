From: Jonathan Cameron <jic23@cam.ac.uk>
Date: Mon, 18 Jul 2011 21:45:26 +0000
Subject: Re: [lm-sensors] [PATCH] iio: add support for Analog Devices ad7194
Message-Id: <4E24A976.5050301@cam.ac.uk>
List-Id: <lm-sensors.vger.kernel.org>
References: <1310975165-19912-1-git-send-email-pthomas8589@gmail.com>
In-Reply-To: <1310975165-19912-1-git-send-email-pthomas8589@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org



On 07/18/11 18:11, Paul Thomas wrote:
> Aside from the ABI stuff, I had a couple responses to your comments.
> 
> thanks,
> Paul
...
>>>> +static inline int ad7194_read_reg24(struct spi_device *spi,
>>>> +            int reg, uint32_t *val)
>>>> +{
>>>> +    int ret;
>>>> +    uint8_t tx[1], rx[3];
>>>> +
>>>> +    tx[0] = (COMM_READ_bm | (reg << COMM_ADDR_bp));
>> Don't allocate single element arrays.  Just makes things
>> harder to read.
> I was trying to keep consistency between the _reg8 & _reg24 versions
> as well as between the rx & tx buffers. It makes the
> spi_write_then_read(spi, tx, 1, rx, 3) read nicely, but if that's a
> no-no then I can change it.
Not really important so either is fine.
> 
>>
>>>> +
>>>> +    ret = spi_write_then_read(spi, tx, 1, rx, 3);
>>>> +    *val = (rx[0] << 16) + (rx[1] << 8) + rx[2];
>>>> +    return ret;
>>>> +}
>>>> +
>>>> +static inline int ad7194_write_reg24(struct spi_device *spi,
>>>> +            int reg, uint32_t *val)
>>>> +{
>>>> +    uint8_t tx[4];
>>>> +
>>>> +    tx[0] = (reg << COMM_ADDR_bp);
>>>> +    tx[1] = (*val >> 16) & 0xff;
>>>> +    tx[2] = (*val >> 8) & 0xff;
>>>> +    tx[3] = (*val >> 0) & 0xff;
>>>> +
>>>> +    return spi_write(spi, tx, 4);
>> IIRC spi_write requires dma safe buffers (cache line aligned
>> buffers on the heap).
> Could you expand here?
> 
Basically it boils down to meaning that all spi buffers (other than
through write_then_read (which copies the data) have to be allocated
using kmalloc or equilvalent.  If you want to embed the in the
chip specific structure, then this can be done by using ____cachline_aligned
(grep for it in iio drivers to see what I mean).

The issue is that if you issue a dma request to an spi controller, it can
mess with the data. This can mean the contents of memory around the dma
buffer in the processor cache can become different from that in memory.
The solution is to ensure nothing else sits in the cacheline (the chunk
of memory on which the cache operates). This is always true for kmalloc'd
memory. The ____cacheline_aligned trick ensures that enough padding is added
to make this rule still be obeyed even when allocating a larger structure.

It's a common trap people fall into the first time they write an spi driver.

Note that spi_write_then read is obviously a slow option hence the comments
in the header (or maybe the c file) explaining why it is a bad idea for anything
other than small infrequent use cases.
Jonathan


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

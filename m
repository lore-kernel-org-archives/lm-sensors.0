From: "Eric Miao" <eric.y.miao@gmail.com>
Date: Tue, 23 Sep 2008 01:31:09 +0000
Subject: Re: [lm-sensors] [PATCH 6/8] hwmon: add max1111/max1110 Low-power
Message-Id: <f17812d70809221831w668ebaerc6fd2cb2aecde6a6@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <f17812d70809022312y6fd288ffu2607761414152f77@mail.gmail.com>
In-Reply-To: <f17812d70809022312y6fd288ffu2607761414152f77@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

>
> Code looks reasonable, so you get my:
>
> Acked-by: Jean Delvare <khali@linux-fr.org>

Thanks.

>
> However, please read my few suggestions below to make the driver even
> better.
>> +
>> +     data->rx_buf = kmalloc(MAX1111_RX_BUF_SIZE, GFP_KERNEL);
>> +     if (!data->rx_buf) {
>> +             kfree(data->tx_buf);
>> +             return -ENOMEM;
>> +     }
>
> Allocating such small buffers using kmalloc seems pretty inefficient.
> At the very least, I would allocate both buffers at once. But quite
> frankly I don't get why you don't just make these buffers part of
> struct max1111_data. This would even make the structure smaller!
>

I originally place the buffer within "struct max1111_data" but received
a mail from David Brownell suggesting using a kmalloc() buffer, so that
DMA mode will work better with the cache alignment and trailing bytes,
though PIO can just work happily. I don't know the specific reason for
this, honestly.

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

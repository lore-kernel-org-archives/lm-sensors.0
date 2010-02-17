From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 17 Feb 2010 21:15:33 +0000
Subject: Re: [lm-sensors] A question regarding ASRock H55DE3 motherboard
Message-Id: <20100217221533.33699b9a@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <4B7A403E.7000103@permonline.ru>
In-Reply-To: <4B7A403E.7000103@permonline.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, 18 Feb 2010 01:08:04 +0500, Artem S. Tashkinov wrote:
> On 02/18/2010 12:19 AM, Jean Delvare wrote:
>  > This driver should be available. If it's not there, this suggests that
>  > you did not set CONFIG_SENSORS_ADT7473=m when building your kernel. You
>  > should have...
> 
> I will try to build this driver and report if it shows anything.

Note: last time I checked (long ago), the binary nvidia driver which
you appear to be using, did not let hwmon driver probe its I2C buses
for devices. So you might have to instantiate the chip yourself with:

# echo adt7473 0x2e > /sys/class/i2c-adapter/i2c-<N>/device/new_device

where <N> is the bus number of the i2c bus in question.

> (...)
> It looks like it's my own blunder: I have confused w83_2_627 to w83627 
> :) and taking into consideration ASRock's documentation my chip is 
> indeed made by Nuvoton and it's currently unsupported - I'm eagerly 
> awaiting patches to be merged.

Hmm, does the W832627 actually exist? I thought it was a typo.

-- 
Jean Delvare
http://khali.linux-fr.org/wishlist.html

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

From: Jean Delvare <khali@linux-fr.org>
Date: Sat, 28 Jan 2012 20:34:00 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (w83627ehf) Fix number of fans for NCT6776F
Message-Id: <20120128213400.1ff93726@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1327672138-5224-1-git-send-email-linux@roeck-us.net>
In-Reply-To: <1327672138-5224-1-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sat, 28 Jan 2012 09:04:28 -0800, Guenter Roeck wrote:
> Logic was that I only need to check if the fans are connected to 90..92 if they are
> not connected to 3..5. However, it looks like 90..92 take precedence, so
> I think I have to check if the fans are connected to 90..92 first, and only
> check if they are connected to 3..5 if they are not connected to 90..92.
> 
> Something like:
> 
> 	fan3pin = 0;
> 	fan4pin = 0;
> 	fan5pin = 0;
> 	if (superio_inb(sio_data->sioreg, 0x27) & 0x80) {
>                 superio_select(sio_data->sioreg, W83627EHF_LD_HWM);
>                 regval = superio_inb(sio_data->sioreg, SIO_REG_ENABLE);
>                 fan3pin = !!(regval & 0x80);
>                 fan4pin = !!(regval & 0x40);
>                 fan5pin = !!(regval & 0x20);
>         }
> 	if (!fan3pin)
> 		fan3pin = !(superio_inb(sio_data->sioreg, 0x24) & 0x40);
> 	if (!fan4pin)
> 		fan4pin = !!(superio_inb(sio_data->sioreg, 0x1C) & 0x01);
> 	if (!fan5pin)
>   		fan5pin = !!(superio_inb(sio_data->sioreg, 0x1C) & 0x02);
> 
> Does that make sense ?

Yes, this should work in practice. However some improper chip
configurations would not be dealt with properly by the code above. For
example bits 5, 6 and 7 of configuration register SIO_REG_ENABLE set but
bit 7 of configuration register 0x27 not set makes no sense, but if the
chip is so configured then I believe the fans cannot be monitored,
regardless of the bit values in configuration registers 0x24 and 0x1C.
If you want to handle this case, you have to check every fan
separately, like:

	gpok = superio_inb(sio_data->sioreg, 0x27) & 0x80;
	regval = superio_inb(sio_data->sioreg, SIO_REG_ENABLE);

	if (regval & 0x80)
		fan3pin = gpok;
	else
		fan3pin = !(superio_inb(sio_data->sioreg, 0x24) & 0x40);

	if (regval & 0x40)
		fan4pin = gpok;
	else
		fan4pin = !!(superio_inb(sio_data->sioreg, 0x1C) & 0x01);
	[etc]

It's up to you if you want to do that for absolute correctness
(assuming I read the datasheet properly...) or prefer to stick to your
approach which should be equivalent for properly configured chips.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

From: Guenter Roeck <linux@roeck-us.net>
Date: Wed, 01 Jul 2015 21:04:07 +0000
Subject: Re: [lm-sensors] [PATCH V2 2/3] hwmon:f71882fg fix f81866a temp/beep setting
Message-Id: <559455C7.3030002@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1435627870-12249-1-git-send-email-hpeter+linux_kernel@gmail.com> <1435627870-12249-3-git-send-email-hpeter+linux_kernel@gmail.com>
In-Reply-To: <1435627870-12249-3-git-send-email-hpeter+linux_kernel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Peter Hung <hpeter@gmail.com>, jdelvare@suse.de
Cc: lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org, tom_tsai@fintek.com.tw, peter_hong@fintek.com.tw, Peter Hung <hpeter+linux_kernel@gmail.com>

Hi Peter,

On 06/29/2015 06:31 PM, Peter Hung wrote:
> The temperature value of Fintek F81866 is the same with
> f71882fg. It located with 0x6c + 2*(nr), others located
> with 0x6c + 2*(nr+1). We change the rule in f71882fg_probe(),
> If type = f71858fg/f8000/f81866a. the temp_start will set to 0,
> others are 1.
>
> The F81866 over-temperature beep setting is not the same with
> f71882fg too. They are using the same address 63H, but F81866 is
> using bit 0/1/2 & 4/5/6, others are using bit 1/2/3 & 5/6/7,
> So we copy from fxxxx_temp_beep_attr[] to f81866_temp_beep_attr
> and change bit setting.
>
> Signed-off-by: Peter Hung <hpeter+linux_kernel@gmail.com>
> ---
[ .. ]

> +			if (data->type = f81866a) {
> +				size = ARRAY_SIZE(f81866_temp_beep_attr[0]);
> +				err = f71882fg_create_sysfs_files(pdev,
> +						&f81866_temp_beep_attr[0][0],
> +						size * nr_temps);
> +
> +			} else {
> +				size = ARRAY_SIZE(fxxxx_temp_beep_attr[0];

TskTsk ... turns out you didn't even compile test this code.

How am I supposed to know that it is working ?

Guenter


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

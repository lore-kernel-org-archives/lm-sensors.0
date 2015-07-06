From: Guenter Roeck <linux@roeck-us.net>
Date: Mon, 06 Jul 2015 21:59:32 +0000
Subject: Re: [lm-sensors] hwmon: (f71882fg) Add f81866/f71868 SuperIO support
Message-Id: <559AFA44.2060804@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <20150706153502.GA22265@mwanda>
In-Reply-To: <20150706153502.GA22265@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 07/06/2015 08:35 AM, Dan Carpenter wrote:
> Hello Peter Hung,
>
> The patch b7bca9b681e3: "hwmon: (f71882fg) Add f81866/f71868 SuperIO
> support" from Jun 30, 2015, leads to the following static checker
> warning:
>
> 	drivers/hwmon/f71882fg.c:2425 f71882fg_probe()
> 	warn: buffer overflow 'fxxxx_in_attr' 9 <= 9
>
> drivers/hwmon/f71882fg.c
>    2422                  for (i = 0; i < F71882FG_MAX_INS; i++) {
>                                          ^^^^^^^^^^^^^^^^
> We increased this from 9 to 10.
>
>    2423                          if (f71882fg_has_in[data->type][i]) {
>    2424                                  err = device_create_file(&pdev->dev,
>    2425                                                  &fxxxx_in_attr[i].dev_attr);
>                                                           ^^^^^^^^^^^^^^^^
> But this array still only has 9 elements.
>
>    2426                                  if (err)
>    2427                                          goto exit_unregister_sysfs;
>    2428                          }
>    2429                  }
>

Peter,

easy to fix, and annoying that I didn't catch it earlier.

I decided to pull the entire series, since you obviously
did not test the code. When you resubmit, please let me know
how you tested it.

Thanks,
Guenter


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

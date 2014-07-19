From: Axel Lin <axel.lin@ingics.com>
Date: Sat, 19 Jul 2014 02:47:15 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (smsc47m192) Fix temperature limit and vrm write operations
Message-Id: <CAFRkauCsodYqRbh2fRqosmyhEjE9ASR4fnvkxpas5CgSt0repg@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1405694121-5670-1-git-send-email-linux@roeck-us.net>
In-Reply-To: <1405694121-5670-1-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

2014-07-18 22:35 GMT+08:00 Guenter Roeck <linux@roeck-us.net>:
> Temperature limit clamps are applied after converting the temeprature
> from milli-degrees C to degrees C, so the clamp limit needs to be
> specified in degrees C, not milli-degrees C.
>
> vrm is an u8, so the written value needs to be clamped to [0, 255].
>
> Cc: Axel Lin <axel.lin@ingics.com>

Hi Guenter,
The v2 looks good to me,
Reviewed-by: Axel Lin <axel.lin at ingics.com>

Regards,
Axel

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

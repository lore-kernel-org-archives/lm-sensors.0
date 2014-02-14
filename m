From: Guenter Roeck <linux@roeck-us.net>
Date: Fri, 14 Feb 2014 02:51:18 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (ntc_thermistor): Avoid overflow
Message-Id: <52FD84A6.9000400@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1392331174-12271-1-git-send-email-dianders@chromium.org>
In-Reply-To: <1392331174-12271-1-git-send-email-dianders@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Doug Anderson <dianders@chromium.org>, Jean Delvare <jdelvare@suse.de>
Cc: lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org

On 02/13/2014 02:39 PM, Doug Anderson wrote:
> The ntc thermistor code was doing math whose temporary result might
> have overflowed 32-bits.  We need some casts in there to make it safe.
>
> In one example I found:
> - pullup_uV: 1800000
> - result of iio_read_channel_raw: 3226
> - 1800000 * 3226 => 0x15a1cbc80
>
> Signed-off-by: Doug Anderson <dianders@chromium.org>

Nice catch. Applied.

Thanks,
Guenter



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

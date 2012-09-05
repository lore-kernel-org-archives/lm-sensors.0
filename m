From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 05 Sep 2012 08:20:43 +0000
Subject: Re: [lm-sensors] [PATCH 1/4] hwmon: (adm9240) Remove legacy chassis intrusion detection sysfs attrib
Message-Id: <20120905102043.0a9b4dfc@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1346810610-26352-2-git-send-email-linux@roeck-us.net>
In-Reply-To: <1346810610-26352-2-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue,  4 Sep 2012 19:03:27 -0700, Guenter Roeck wrote:
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
>  drivers/hwmon/adm9240.c |   26 --------------------------
>  1 file changed, 26 deletions(-)
>
> diff --git a/drivers/hwmon/adm9240.c b/drivers/hwmon/adm9240.c
> index 5a78d10..8b24d1a 100644
> --- a/drivers/hwmon/adm9240.c
> +++ b/drivers/hwmon/adm9240.c
> (...)

Acked-by: Jean Delvare <khali@linux-fr.org>

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

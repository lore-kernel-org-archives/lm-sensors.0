From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 05 Sep 2012 08:56:40 +0000
Subject: Re: [lm-sensors] [PATCH 3/4] hwmon: (w83793) Remove legacy chassis intrusion detection sysfs attribu
Message-Id: <20120905105640.3b5e4538@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1346810610-26352-4-git-send-email-linux@roeck-us.net>
In-Reply-To: <1346810610-26352-4-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue,  4 Sep 2012 19:03:29 -0700, Guenter Roeck wrote:
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
>  drivers/hwmon/w83793.c |   23 -----------------------
>  1 file changed, 23 deletions(-)
> 
> diff --git a/drivers/hwmon/w83793.c b/drivers/hwmon/w83793.c
> index d6b0bdd..4fc47e0 100644
> --- a/drivers/hwmon/w83793.c
> +++ b/drivers/hwmon/w83793.c
> (...)

Acked-by: Jean Delvare <khali@linux-fr.org>

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

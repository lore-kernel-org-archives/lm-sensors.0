From: Jean Delvare <khali@linux-fr.org>
Date: Sat, 16 Jun 2012 16:21:15 +0000
Subject: Re: [lm-sensors] [PATCH 85/95] hwmon: (w83795) Convert to use devm_ functions
Message-Id: <20120616182115.26f14fc3@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1339773856-3443-86-git-send-email-linux@roeck-us.net>
In-Reply-To: <1339773856-3443-86-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Fri, 15 Jun 2012 08:24:06 -0700, Guenter Roeck wrote:
> Convert to use devm_ functions to reduce code size and simplify the code.
> 
> Cc: Jean Delvare <khali@linux-fr.org>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
>  drivers/hwmon/w83795.c |   11 +++--------
>  1 file changed, 3 insertions(+), 8 deletions(-)

Acked-by: Jean Delvare <khali@linux-fr.org>

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

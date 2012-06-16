From: Jean Delvare <khali@linux-fr.org>
Date: Sat, 16 Jun 2012 17:00:29 +0000
Subject: Re: [lm-sensors] [PATCH 50/95] hwmon: (lm87) Convert to use devm_ functions
Message-Id: <20120616190029.6e65cc4d@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1339773856-3443-51-git-send-email-linux@roeck-us.net>
In-Reply-To: <1339773856-3443-51-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Fri, 15 Jun 2012 08:23:31 -0700, Guenter Roeck wrote:
> Convert to use devm_ functions to reduce code size and simplify the code.
> 
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
>  drivers/hwmon/lm87.c |   15 +++++----------
>  1 file changed, 5 insertions(+), 10 deletions(-)

Acked-by: Jean Delvare <khali@linux-fr.org>

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

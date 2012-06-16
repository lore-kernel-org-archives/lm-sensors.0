From: Jean Delvare <khali@linux-fr.org>
Date: Sat, 16 Jun 2012 16:50:45 +0000
Subject: Re: [lm-sensors] [PATCH 38/95] hwmon: (gl520sm) Convert to use devm_ functions
Message-Id: <20120616185045.4b707419@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1339773856-3443-39-git-send-email-linux@roeck-us.net>
In-Reply-To: <1339773856-3443-39-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Fri, 15 Jun 2012 08:23:19 -0700, Guenter Roeck wrote:
> Convert to use devm_ functions to reduce code size and simplify the code.
> 
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
>  drivers/hwmon/gl520sm.c |   15 +++++----------
>  1 file changed, 5 insertions(+), 10 deletions(-)

Acked-by: Jean Delvare <khali@linux-fr.org>

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

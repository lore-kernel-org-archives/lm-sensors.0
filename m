From: Jean Delvare <khali@linux-fr.org>
Date: Sat, 16 Jun 2012 19:59:41 +0000
Subject: Re: [lm-sensors] [PATCH 53/95] hwmon: (lm93) Convert to use devm_ functions
Message-Id: <20120616215941.34901c5c@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1339773856-3443-54-git-send-email-linux@roeck-us.net>
In-Reply-To: <1339773856-3443-54-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Fri, 15 Jun 2012 08:23:34 -0700, Guenter Roeck wrote:
> Convert to use devm_ functions to reduce code size and simplify the code.
> 
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
>  drivers/hwmon/lm93.c |   14 ++++----------
>  1 file changed, 4 insertions(+), 10 deletions(-)

Acked-by: Jean Delvare <khali@linux-fr.org>

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

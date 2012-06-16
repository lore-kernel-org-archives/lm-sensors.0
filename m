From: Jean Delvare <khali@linux-fr.org>
Date: Sat, 16 Jun 2012 16:48:19 +0000
Subject: Re: [lm-sensors] [PATCH 24/95] hwmon: (atxp1) Convert to use devm_ functions
Message-Id: <20120616184819.60e34c1e@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1339773856-3443-25-git-send-email-linux@roeck-us.net>
In-Reply-To: <1339773856-3443-25-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Fri, 15 Jun 2012 08:23:05 -0700, Guenter Roeck wrote:
> Convert to use devm_ functions to reduce code size and simplify the code.
> 
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
>  drivers/hwmon/atxp1.c |   16 +++++-----------
>  1 file changed, 5 insertions(+), 11 deletions(-)

Acked-by: Jean Delvare <khali@linux-fr.org>

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

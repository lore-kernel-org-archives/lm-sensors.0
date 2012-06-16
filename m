From: Jean Delvare <khali@linux-fr.org>
Date: Sat, 16 Jun 2012 15:45:33 +0000
Subject: Re: [lm-sensors] [PATCH 32/95] hwmon: (f71805f) Convert to use devm_ functions
Message-Id: <20120616174533.57c1e2d4@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1339773856-3443-33-git-send-email-linux@roeck-us.net>
In-Reply-To: <1339773856-3443-33-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Fri, 15 Jun 2012 08:23:13 -0700, Guenter Roeck wrote:
> Convert to use devm_ functions to reduce code size and simplify the code.
> 
> Cc: Jean Delvare <khali@linux-fr.org>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
>  drivers/hwmon/f71805f.c |   26 +++++++-------------------
>  1 file changed, 7 insertions(+), 19 deletions(-)

Acked-by: Jean Delvare <khali@linux-fr.org>

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 17 Jun 2012 06:45:04 +0000
Subject: Re: [lm-sensors] [PATCH v2] hwmon: (pc87427) Convert to use devm_ functions
Message-Id: <20120617084504.5451d592@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1339907740-3512-2-git-send-email-linux@roeck-us.net>
In-Reply-To: <1339907740-3512-2-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sat, 16 Jun 2012 21:35:40 -0700, Guenter Roeck wrote:
> Convert to use devm_ functions to reduce code size and simplify the code.
> 
> Cc: Jean Delvare <khali@linux-fr.org>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
> v2: Further simplify pc87427_request_regions
> 
>  drivers/hwmon/pc87427.c |   51 ++++++++++-------------------------------------
>  1 file changed, 11 insertions(+), 40 deletions(-)

Acked-by: Jean Delvare <khali@linux-fr.org>

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

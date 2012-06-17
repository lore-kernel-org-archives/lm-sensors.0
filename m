From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 17 Jun 2012 20:57:33 +0000
Subject: Re: [lm-sensors] [PATCH 93/95] hwmon: (smsc47m192) Convert to use devm_ functions
Message-Id: <20120617225733.5b59cde2@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1339773856-3443-94-git-send-email-linux@roeck-us.net>
In-Reply-To: <1339773856-3443-94-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Fri, 15 Jun 2012 08:24:14 -0700, Guenter Roeck wrote:
> Convert to use devm_ functions to reduce code size and simplify the code.
> 
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
>  drivers/hwmon/smsc47m192.c |   16 +++++-----------
>  1 file changed, 5 insertions(+), 11 deletions(-)

Acked-by: Jean Delvare <khali@linux-fr.org>

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 17 Jun 2012 19:48:17 +0000
Subject: Re: [lm-sensors] [PATCH 91/95] hwmon: (smsc47b397) Convert to use devm_ functions
Message-Id: <20120617214817.2522f41c@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1339773856-3443-92-git-send-email-linux@roeck-us.net>
In-Reply-To: <1339773856-3443-92-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Fri, 15 Jun 2012 08:24:12 -0700, Guenter Roeck wrote:
> Convert to use devm_ functions to reduce code size and simplify the code.
> 
> Cc: Mark M. Hoffman <mhoffman@lightlink.com>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
>  drivers/hwmon/smsc47b397.c |   22 ++++++----------------
>  1 file changed, 6 insertions(+), 16 deletions(-)

Acked-by: Jean Delvare <khali@linux-fr.org>

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

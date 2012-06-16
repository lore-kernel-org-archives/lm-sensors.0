From: Jean Delvare <khali@linux-fr.org>
Date: Sat, 16 Jun 2012 16:46:45 +0000
Subject: Re: [lm-sensors] [PATCH 12/95] hwmon: (adm1031) Convert to use devm_ functions
Message-Id: <20120616184645.23761253@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1339773856-3443-13-git-send-email-linux@roeck-us.net>
In-Reply-To: <1339773856-3443-13-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Fri, 15 Jun 2012 08:22:53 -0700, Guenter Roeck wrote:
> Convert to use devm_ functions to reduce code size and simplify the code.
> 
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
>  drivers/hwmon/adm1031.c |   15 +++++----------
>  1 file changed, 5 insertions(+), 10 deletions(-)

Acked-by: Jean Delvare <khali@linux-fr.org>

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

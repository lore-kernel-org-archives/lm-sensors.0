From: Guenter Roeck <linux@roeck-us.net>
Date: Thu, 11 Oct 2012 14:23:09 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: da9052: Use da9052_reg_update for rmw operations
Message-Id: <20121011142309.GA17164@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1349964231.9925.1.camel@phoenix>
In-Reply-To: <1349964231.9925.1.camel@phoenix>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Axel Lin <axel.lin@ingics.com>
Cc: Jean Delvare <khali@linux-fr.org>, David Dajun Chen <dchen@diasemi.com>, Ashish Jangam <ashish.jangam@kpitcummins.com>, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org

On Thu, Oct 11, 2012 at 10:03:51PM +0800, Axel Lin wrote:
> Signed-off-by: Axel Lin <axel.lin@ingics.com>
> ---
>  drivers/hwmon/da9052-hwmon.c |   27 +++++++--------------------
>  1 file changed, 7 insertions(+), 20 deletions(-)
> 
Applied to -next.

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

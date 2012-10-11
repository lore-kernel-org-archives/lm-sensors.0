From: Guenter Roeck <linux@roeck-us.net>
Date: Thu, 11 Oct 2012 16:22:51 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (ina2xx) Use module_i2c_driver macro
Message-Id: <20121011162251.GA31269@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1349970986.9548.1.camel@phoenix>
In-Reply-To: <1349970986.9548.1.camel@phoenix>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Axel Lin <axel.lin@ingics.com>
Cc: Jean Delvare <khali@linux-fr.org>, Lothar Felten <l-felten@ti.com>, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org

On Thu, Oct 11, 2012 at 11:56:26PM +0800, Axel Lin wrote:
> Signed-off-by: Axel Lin <axel.lin@ingics.com>
> ---
>  drivers/hwmon/ina2xx.c |   13 +------------
>  1 file changed, 1 insertion(+), 12 deletions(-)
> 
Hi Axel,

A similar patch from Wei Yongjun is already queued in my -next branch.
It is not in linux-next yet since I am supposed to hold off until
the commit window closes. 

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

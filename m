From: Guenter Roeck <linux@roeck-us.net>
Date: Thu, 28 Aug 2014 18:20:01 +0000
Subject: Re: [lm-sensors] [PATCH v2] hwmon: (ds1621) Update zbits after conversion rate change
Message-Id: <20140828182001.GA19149@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1409247943-31246-1-git-send-email-robert.coulson@ericsson.com>
In-Reply-To: <1409247943-31246-1-git-send-email-robert.coulson@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, Aug 28, 2014 at 10:45:43AM -0700, Robert Coulson wrote:
> From: Robert Coulson <rob.coulson@gmail.com>
> 
> After the conversion rate is changed, the zbits are not updated,
> but should be, since they are used later in the set_temp function.
> 
> Fixes: a50d9a4d9ad3 ("hwmon: (ds1621) Fix temperature rounding operations")
> Reported-by: Murat Ilsever <murat.ilsever@gmail.com>
> Signed-off-by: Robert Coulson <rob.coulson@gmail.com>
> 

Applied.

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

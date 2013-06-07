From: Guenter Roeck <linux@roeck-us.net>
Date: Fri, 07 Jun 2013 16:27:17 +0000
Subject: Re: [lm-sensors] [PATCH 1/2] hwmon: (adm1021) Do not create min sysfs attributes for LM84
Message-Id: <20130607162717.GA4725@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1370620280-32415-1-git-send-email-linux@roeck-us.net>
In-Reply-To: <1370620280-32415-1-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Fri, Jun 07, 2013 at 06:07:28PM +0200, Jean Delvare wrote:
> On Fri,  7 Jun 2013 08:51:19 -0700, Guenter Roeck wrote:
> > LM84 does not support minimum temperature registers.
> > Only create the respective sysfs attributes for other chips.
> 
> Did you consider implementing this with .is_visible()? This might
> result in a smaller binary.
> 
Hi Jean,

Turns out it is larger: 8575 bytes vs. 8516 bytes. Cost of cleaner code :(.

> Other than that, this looks good:
> 
> Acked-by: Jean Delvare <khali@linux-fr.org>
> 
Thanks - I'll keep it as-is (using multiple groups).

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

From: Guenter Roeck <linux@roeck-us.net>
Date: Sat, 02 Mar 2013 15:04:08 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (sht15) Check return value of regulator_enable()
Message-Id: <20130302150408.GA22984@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1362209610-12337-1-git-send-email-broonie@opensource.wolfsonmicro.com>
In-Reply-To: <1362209610-12337-1-git-send-email-broonie@opensource.wolfsonmicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sat, Mar 02, 2013 at 03:33:30PM +0800, Mark Brown wrote:
> Not having power is a pretty serious error so check that we are able to
> enable the supply and error out if we can't.
> 
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

Good catch; applied. We'll have to do a manual backport to 3.0/3.4 after it is
in mainline. The patch applies, but would leak memory in the error case.

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

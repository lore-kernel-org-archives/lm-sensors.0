From: Guenter Roeck <linux@roeck-us.net>
Date: Wed, 12 Feb 2014 16:41:34 +0000
Subject: Re: [lm-sensors] [PATCH 09/12] hwmon: vexpress: Use devm helper for hwmon device registration
Message-Id: <20140212164134.GA19445@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <20140212024904.GA19352@roeck-us.net>
 <1392206196.848.18.camel@hornet>
In-Reply-To: <1392206196.848.18.camel@hornet>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Pawel Moll <pawel.moll@arm.com>
Cc: "arm@kernel.org" <arm@kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Jean Delvare <jdelvare@suse.de>, "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>

On Wed, Feb 12, 2014 at 11:56:36AM +0000, Pawel Moll wrote:
> 
> > I agree with Arnd that it would be nice to get rid of the local macro,
> > but I won't mandate that.
> 
> I actually prefer to have the structures unfolded, but was just trying
> to mimic the trend in other hwmon drivers. No problem - will change this
> gladly.
> 
In general we tend to discourage people to use their own macros -
most of the time it just makes the code more difficult to read.

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

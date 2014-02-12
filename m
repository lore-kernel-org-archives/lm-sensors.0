From: Pawel Moll <pawel.moll@arm.com>
Date: Wed, 12 Feb 2014 11:59:27 +0000
Subject: Re: [lm-sensors] [PATCH 09/12] hwmon: vexpress: Use devm helper for hwmon device registration
Message-Id: <1392206367.848.20.camel@hornet>
List-Id: <lm-sensors.vger.kernel.org>
References: <20140212024904.GA19352@roeck-us.net>
	 <1392206196.848.18.camel@hornet>
In-Reply-To: <1392206196.848.18.camel@hornet>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guenter Roeck <linux@roeck-us.net>
Cc: Jean Delvare <jdelvare@suse.de>, "arm@kernel.org" <arm@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>

On Wed, 2014-02-12 at 11:56 +0000, Pawel Moll wrote:
> > Third, I noticed that the 'label' attribute is always created but returns  
> > -ENOENT if there is no label. A much better implementation would be to use
> > .is_visible and not create the label attribute if its devicetree entry
> > does not exist. I don't know how libsensors reacts to -ENOENT on a read,
> > but no matter how it does react, it is pretty much undefined.
> > Again, that should be handled in a separate patch.

Missed that one - will do as well.

Pawel


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

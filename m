From: Pawel Moll <pawel.moll@arm.com>
Date: Mon, 28 Apr 2014 17:37:40 +0000
Subject: Re: [lm-sensors] [PATCH 1/3] driver core & of: Mark of_nodes of added device as populated
Message-Id: <1398706660.20390.5.camel@hornet>
List-Id: <lm-sensors.vger.kernel.org>
References: <1392137610-27842-1-git-send-email-pawel.moll@arm.com>
	 <1392137610-27842-2-git-send-email-pawel.moll@arm.com>
	 <CAL_JsqJQy7ob87=wPOLxn3X0fTrt2QhAEJ2nPTAmCMZqNZp+sw@mail.gmail.com>
In-Reply-To: <CAL_JsqJQy7ob87=wPOLxn3X0fTrt2QhAEJ2nPTAmCMZqNZp+sw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Rob Herring <robherring2@gmail.com>
Cc: Mark Rutland <mark.rutland@arm.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Mike Turquette <mturquette@linaro.org>, "arm@kernel.org" <arm@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Mark Brown <broonie@kernel.org>, Guenter Roeck <linux@roeck-us.net>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, lm-sensors@lm-sensors.org, Rob Herring <robh+dt@kernel.org>, Jean Delvare <jdelvare@suse.de>, Kumar Gala <galak@codeaurora.org>, Grant Likely <grant.likely@linaro.org>, Lee Jones <lee.jones@linaro.org>, David Woodhouse <dwmw2@infradead.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Samuel Ortiz <sameo@linux.intel.com>

On Thu, 2014-02-13 at 13:15 -0600, Rob Herring wrote:
> On Tue, Feb 11, 2014 at 10:53 AM, Pawel Moll <pawel.moll@arm.com> wrote:
> > In "Device Tree powered" systems, platform devices are usually
> > massively populated with of_platform_populate() call, executed
> > at some level of initcalls, either by generic architecture
> > or by platform-specific code.
>
> Go read Grant's and my comments from your last posting.

Right, I can't explain why I missed those. Will do right now.

Pawel


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

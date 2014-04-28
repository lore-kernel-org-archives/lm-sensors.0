From: Pawel Moll <pawel.moll@arm.com>
Date: Mon, 28 Apr 2014 17:40:54 +0000
Subject: Re: [lm-sensors] [PATCH 1/3] driver core & of: Mark of_nodes of added device as populated
Message-Id: <1398706854.20390.8.camel@hornet>
List-Id: <lm-sensors.vger.kernel.org>
References: <1392137610-27842-1-git-send-email-pawel.moll@arm.com>
	 <1392137610-27842-2-git-send-email-pawel.moll@arm.com>
	 <52FA5EB4.7080008@codeaurora.org>
In-Reply-To: <52FA5EB4.7080008@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Christopher Covington <cov@codeaurora.org>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>, Mike Turquette <mturquette@linaro.org>, Samuel Ortiz <sameo@linux.intel.com>, Arnd Bergmann <arnd@arndb.de>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Mark Brown <broonie@kernel.org>, Jean Delvare <jdelvare@suse.de>, linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, lm-sensors@lm-sensors.org, arm@kernel.org, Guenter Roeck <linux@roeck-us.net>, Kumar Gala <galak@codeaurora.org>, Grant Likely <grant.likely@linaro.org>, Lee Jones <lee.jones@linaro.org>, David Woodhouse <dwmw2@infradead.org>, linux-arm-kernel@lists.infradead.org

On Tue, 2014-02-11 at 12:32 -0500, Christopher Covington wrote:
> Hi Pawel,
> 
> On 02/11/2014 11:53 AM, Pawel Moll wrote:
> > This patch tries to solve that issue in a generic way,
> > adding a "populated" flag which is set in the device_node
> > structure when a device is being created in the core.
> > Later, of_platform_populate() skips such nodes (and
> > its children) in a similar way to the non-available ones.
> 
> Will there never be a case where it is useful for a parent node to be created
> early, but not necessarily the child nodes? Might only skipping nodes
> explicitly marked as populated be a more universal solution?

That's a good point. I've assumed one would either use
of_platform_device_create() on leaf nodes only (or
of_platform_populate() on subtree), and kept this approach in the
refreshed patch I'm about to post, but I'm happy to do what you
suggested.

Thanks!

Pawel


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

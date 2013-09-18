From: Joe Perches <joe@perches.com>
Date: Wed, 18 Sep 2013 19:59:37 +0000
Subject: Re: [lm-sensors] [PATCHv3 02/16] drivers: thermal: introduce device tree parser
Message-Id: <1379534377.1787.59.camel@joe-AO722>
List-Id: <lm-sensors.vger.kernel.org>
References: <5239F6D8.1020907@ti.com>
	 <1379530923-29268-1-git-send-email-eduardo.valentin@ti.com>
	 <1379531483.1787.55.camel@joe-AO722> <523A0290.8050502@ti.com>
In-Reply-To: <523A0290.8050502@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Eduardo Valentin <eduardo.valentin@ti.com>
Cc: swarren@wwwdotorg.org, pawel.moll@arm.com, mark.rutland@arm.com, ian.campbell@citrix.com, rob.herring@calxeda.com, linux@roeck-us.net, rui.zhang@intel.com, wni@nvidia.com, grant.likely@linaro.org, durgadoss.r@intel.com, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org

On Wed, 2013-09-18 at 15:44 -0400, Eduardo Valentin wrote:
> Hello Joe,

Hello Eduardo.

>  18-09-2013 15:11, Joe Perches wrote:
> > On Wed, 2013-09-18 at 15:02 -0400, Eduardo Valentin wrote:
> >> This patch introduces a device tree bindings for
> >> describing the hardware thermal behavior and limits.
> >> Also a parser to read and interpret the data and feed
> >> it in the thermal framework is presented.
> > 
> > trivial notes:
[]
> > If readings are within some non zero noise level,
> > perhaps stable should be returned.
> 
> Yes, there should be some sort of threshold for temperature trend. But I
> am not sure this is the right place to implement this. This type of
> feature is in my TODO list, but I am planing to get it done within the
> core code of the thermal framework.

No worries, one day...  Just wanted to bring it to attention.

> >> +static struct __thermal_zone *
> >> +thermal_of_build_thermal_zone(struct device_node *np)
> >> +{
[]
> >> +	tz = kzalloc(sizeof(*tz), GFP_KERNEL);
> >> +	if (!tz) {
> >> +		pr_err("not enough memory for thermal of zone\n");
> > 
> > Unnecessary OOM message.
> > All allocs without GFP_NOWARN get a dump_stack()

[]

> Hmmm.. I am pretty sure you have a good point. But to me seams to be
> still a common practice to have drivers outputing error messages when
> allocation fails. A simple git grep -A 4 kzalloc for instance, shows
> that there are still quite a considerable amount of occurrences of such
> practice.

True though a considerable number have been removed.
I think these should all be deleted eventually and
there's no good reason to add more.



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

From: Wei Ni <wni@nvidia.com>
Date: Fri, 09 Aug 2013 06:06:13 +0000
Subject: Re: [lm-sensors] [PATCH v2 2/3] ARM: dt: t114 dalmore: add dt entry for nct1008
Message-Id: <520486D5.3070109@nvidia.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1375944991-29182-1-git-send-email-wni@nvidia.com>
 <1375944991-29182-3-git-send-email-wni@nvidia.com>
 <5203D6FF.1060000@wwwdotorg.org>
In-Reply-To: <5203D6FF.1060000@wwwdotorg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Stephen Warren <swarren@wwwdotorg.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>, "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>, Matthew Longnecker <MLongnecker@nvidia.com>, "linux@roeck-us.net" <linux@roeck-us.net>, "khali@linux-fr.org" <khali@linux-fr.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On 08/09/2013 01:35 AM, Stephen Warren wrote:
> On 08/08/2013 12:56 AM, Wei Ni wrote:
>> Enable thermal sensor nct1008 for t114 dalmore.
> 
> It'd be best to remove this patch from the series; send one series to
> the LM90 maintainer with just the driver and DT binding changes, and
> another series to the Tegra maintainer with the *.dts changes. You can
> tell me not to apply the *.dts changes until the driver/binding changes
> are accepted (or just wait until they are before sending the patch).

Ok, I will do it.

> 


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

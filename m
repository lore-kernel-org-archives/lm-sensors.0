From: Alex Courbot <acourbot@nvidia.com>
Date: Tue, 19 Feb 2013 03:42:57 +0000
Subject: Re: [lm-sensors] [RFC PATCH 8/9] ARM: dt: t30 cardhu: add dt entry for thermal driver
Message-Id: <5122F4C1.9050108@nvidia.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1361187031-3679-1-git-send-email-wni@nvidia.com> <1361187031-3679-9-git-send-email-wni@nvidia.com>
In-Reply-To: <1361187031-3679-9-git-send-email-wni@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Wei Ni <wni@nvidia.com>
Cc: "durgadoss.r@intel.com" <durgadoss.r@intel.com>, "rui.zhang@intel.com" <rui.zhang@intel.com>, Matthew Longnecker <MLongnecker@nvidia.com>, "khali@linux-fr.org" <khali@linux-fr.org>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>, "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.orgrs.org" <linux-kernel@vger.kernel.orgrs.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On 02/18/2013 08:30 PM, Wei Ni wrote:
> diff --git a/Documentation/devicetree/bindings/thermal/tegra3-thermal.txt b/Documentation/devicetree/bindings/thermal/tegra3-thermal.txt
> new file mode 100644

This should go with the previous patch (which introduces the driver) 
instead of this one. Bindings should be documented with their driver.

Alex.


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

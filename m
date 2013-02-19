From: Alex Courbot <acourbot@nvidia.com>
Date: Tue, 19 Feb 2013 05:39:22 +0000
Subject: Re: [lm-sensors] [RFC PATCH 4/9] hwmon: (lm90) use macros for the indexes of temp8 and temp11
Message-Id: <5123100A.9050604@nvidia.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1361187031-3679-1-git-send-email-wni@nvidia.com> <1361187031-3679-5-git-send-email-wni@nvidia.com>
In-Reply-To: <1361187031-3679-5-git-send-email-wni@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Wei Ni <wni@nvidia.com>
Cc: "durgadoss.r@intel.com" <durgadoss.r@intel.com>, "rui.zhang@intel.com" <rui.zhang@intel.com>, Matthew Longnecker <MLongnecker@nvidia.com>, "khali@linux-fr.org" <khali@linux-fr.org>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>, "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.orgrs.org" <linux-kernel@vger.kernel.orgrs.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On 02/18/2013 08:30 PM, Wei Ni wrote:
> Using macros for the indexes and nrs of temp8 and temp11.
> This make the code much clearer.
>
> Signed-off-by: Wei Ni <wni@nvidia.com>

Acked-by: Alexandre Courbot <acourbot@nvidia.com>

Great patch. This makes the code much more readable. I also compiled 
lm90.o before and after this patch, and diff'ed the stripped binaries to 
make sure there was no error in the macro indexes. Both binaries were 
indentical, therefore:

Tested-by: Alexandre Courbot <acourbot@nvidia.com>

Alex.



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

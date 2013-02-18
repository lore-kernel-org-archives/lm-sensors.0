From: Matthew Longnecker <MLongnecker@nvidia.com>
Date: Mon, 18 Feb 2013 22:29:23 +0000
Subject: Re: [lm-sensors] [RFC PATCH 2/9] hwmon: (lm90) split set&show temp as common codes
Message-Id: <1B93E76B0D8B0E4E8BDD54060BBDE81975FB926ACC@HQMAIL03.nvidia.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1361187031-3679-1-git-send-email-wni@nvidia.com>
 <1361187031-3679-3-git-send-email-wni@nvidia.com>
In-Reply-To: <1361187031-3679-3-git-send-email-wni@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "durgadoss.r@intel.com" <durgadoss.r@intel.com>, "rui.zhang@intel.com" <rui.zhang@intel.com>, "khali@linux-fr.org" <khali@linux-fr.org>
Cc: "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>, "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.orgrs.org" <linux-kernel@vger.kernel.orgrs.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Wei Ni <wni@nvidia.com>

Wei,

This set of patches seems to include 3 logical subsets
1) lm90 changes
2) dt support in drivers/thermal
3) tegra30 support in drivers/thermal

Would it make sense to split this into 3 separate sets of changes?

-Matt Longnecker

nvpublic

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

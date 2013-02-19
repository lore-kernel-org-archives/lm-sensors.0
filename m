From: Stephen Warren <swarren@wwwdotorg.org>
Date: Tue, 19 Feb 2013 23:02:47 +0000
Subject: Re: [lm-sensors] [RFC PATCH 4/9] hwmon: (lm90) use macros for the indexes of temp8 and temp11
Message-Id: <51240497.8010909@wwwdotorg.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <1361187031-3679-1-git-send-email-wni@nvidia.com> <1361187031-3679-5-git-send-email-wni@nvidia.com>
In-Reply-To: <1361187031-3679-5-git-send-email-wni@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Wei Ni <wni@nvidia.com>
Cc: durgadoss.r@intel.com, rui.zhang@intel.com, MLongnecker@nvidia.com, khali@linux-fr.org, devicetree-discuss@lists.ozlabs.org, linux-tegra@vger.kernel.org, lm-sensors@lm-sensors.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.orgrs.org, linux-arm-kernel@lists.infradead.org

On 02/18/2013 04:30 AM, Wei Ni wrote:
> Using macros for the indexes and nrs of temp8 and temp11.
> This make the code much clearer.

Sorry to nit-pick, but those aren't macros, but rather they're enums.

The patch looks good though.

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Fri, 15 Apr 2011 15:46:08 +0000
Subject: Re: [lm-sensors] [PATCH 2/3] hwmon (lm90) Support to configure
Message-Id: <20110415154608.GA24844@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1302865228-7185-1-git-send-email-wni@nvidia.com>
 <1302865228-7185-3-git-send-email-wni@nvidia.com>
In-Reply-To: <1302865228-7185-3-git-send-email-wni@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "wni@nvidia.com" <wni@nvidia.com>
Cc: "khali@linux-fr.org" <khali@linux-fr.org>, "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "olofj@chromium.org" <olofj@chromium.org>, "achew@nvidia.com" <achew@nvidia.com>

On Fri, Apr 15, 2011 at 07:00:27AM -0400, wni@nvidia.com wrote:
> From: Wei Ni <wni@nvidia.com>
> 
> This patch add support to configure nct1008 from platform data.
> 

In my opinion those enhancments should not only be for nct1008 but
apply to all chips, ie be made generic. Not even supporting the functionally
identical chips does not make sense to me at all.

Guenter


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

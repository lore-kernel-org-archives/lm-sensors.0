From: Stephen Warren <swarren@wwwdotorg.org>
Date: Thu, 12 Sep 2013 14:58:21 +0000
Subject: Re: [lm-sensors] [PATCH v4 2/3] of: add vendor prefix for GMT
Message-Id: <5231D68D.3000200@wwwdotorg.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <1378985061-28547-1-git-send-email-wni@nvidia.com> <1378985061-28547-3-git-send-email-wni@nvidia.com>
In-Reply-To: <1378985061-28547-3-git-send-email-wni@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Wei Ni <wni@nvidia.com>
Cc: khali@linux-fr.org, linux@roeck-us.net, broonie@kernel.org, lm-sensors@lm-sensors.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org

On 09/12/2013 05:24 AM, Wei Ni wrote:
> Adding Global Mixed-mode Technology Inc. to the list
> of devicetree vendor prefixes.

> diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt

> +gmt	Global Mixed-mode Technology Inc.

There's some opportunity for confusion here re: the GMT timezone, but
GMT seems to be what the company abbreviates itself to on their website,
so I guess this is reasonable.

Acked-by: Stephen Warren <swarren@nvidia.com>

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

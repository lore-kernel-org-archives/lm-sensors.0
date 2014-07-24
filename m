From: Guenter Roeck <linux@roeck-us.net>
Date: Thu, 24 Jul 2014 13:54:57 +0000
Subject: Re: [lm-sensors] [PATCH 2/2] hwmon: (nct6775) Remove num_attr_groups from struct nct6775_data
Message-Id: <53D11031.4070005@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1406163574.7561.3.camel@phoenix>
In-Reply-To: <1406163574.7561.3.camel@phoenix>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 07/23/2014 05:59 PM, Axel Lin wrote:
> num_attr_groups is only used in nct6775_probe(), make it to be local variable.
>
> Signed-off-by: Axel Lin <axel.lin@ingics.com>
> ---

Applied to -next.

Thanks,
Guenter



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

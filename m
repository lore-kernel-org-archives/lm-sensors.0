From: Guenter Roeck <linux@roeck-us.net>
Date: Sat, 07 Jun 2014 17:42:12 +0000
Subject: Re: [lm-sensors] [PATCH v3] hwmon: (atxp1) Convert to devm_hwmon_device_register_with_groups
Message-Id: <20140607174212.GA6995@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1402098910.13153.0.camel@phoenix>
In-Reply-To: <1402098910.13153.0.camel@phoenix>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sat, Jun 07, 2014 at 07:55:10AM +0800, Axel Lin wrote:
> Use ATTRIBUTE_GROUPS macro and devm_hwmon_device_register_with_groups.
> This simplifies the code a bit.
> 
> Signed-off-by: Axel Lin <axel.lin@ingics.com>

Looks good. I applied it to my hwmon-staging branch for further testing
and to make it available. Let's hope that we find some testers.

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

From: Guenter Roeck <linux@roeck-us.net>
Date: Wed, 06 Aug 2014 02:46:24 +0000
Subject: Re: [lm-sensors] [PATCH 01/10] hwmon: (adm1025) Fix vrm write operation
Message-Id: <53E19700.3020105@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1407284383.4924.5.camel@phoenix>
In-Reply-To: <1407284383.4924.5.camel@phoenix>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 08/05/2014 05:19 PM, Axel Lin wrote:
> vrm is an u8, so the written value needs to be limited to [0, 255].
>
> Signed-off-by: Axel Lin <axel.lin@ingics.com>
> ---

Series applied, except for the lm85 patch which I had already fixed separately.

Thanks,
Guenter


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

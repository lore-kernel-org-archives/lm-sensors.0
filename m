From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 07 Jun 2007 08:33:17 +0000
Subject: Re: [lm-sensors] [PATCH] lm-sensors: replace references to
Message-Id: <20070607103317.41586418@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <191fb4ca0706061335g3a45d590na6d4afaada3bec97@mail.gmail.com>
In-Reply-To: <191fb4ca0706061335g3a45d590na6d4afaada3bec97@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Juerg,

On Wed, 6 Jun 2007 13:35:44 -0700, Juerg Haefliger wrote:
> This patch replaces all references to bmcsensors and i2c-ipmi with
> ipmisensors and ipmi-si in sensors-detect.
> 
> Signed-off-by: Juerg Haefliger <juergh at gmail.com>

Thanks for giving it a shot. Unfortunately I can't take this first
version because it breaks 2.4 kernel systems, which _still_ need
i2c-ipmi + bmcsensors.

Please rework your change so that we can support both 2.4 and 2.6
kernels. This shouldn't be too difficult, most of the infrastructure is
already in place. Look at function chip_special_cases(), it handles the
case of the W83791D chip which is handled by different drivers under
2.4 and 2.6. You need to do something similar for IMPI/BMC.

Thanks,
-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

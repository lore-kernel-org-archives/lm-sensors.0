From: Guenter Roeck <linux@roeck-us.net>
Date: Fri, 27 Feb 2015 14:20:30 +0000
Subject: Re: [lm-sensors] [PATCH v4] Add Nuvoton NCT7904 hwmon driver
Message-Id: <54F07D2E.8020106@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1425042960.8163.64.camel@vvlasov.dev.rtsoft.ru>
In-Reply-To: <1425042960.8163.64.camel@vvlasov.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 02/27/2015 05:16 AM, Vadim V. Vlasov wrote:
> Signed-off-by: Vadim V. Vlasov <vvlasov@dev.rtsoft.ru>
> ---
> Changes from v3:
> 1. Added Documentation/hwmon/nct7904
> 2. Removed X86 dependency from Kconfig
> 3. Fan mode may be only 0 or 1 (for manual/smartfan)
>     selecting smartfan mode is allowed only if the mode
>     has been previously set up
> 4. Minor style fixes
>
>   Documentation/hwmon/nct7904 |  61 +++++

Nicely done.

You introduced a couple of whitespace errors in this file.
No need to resubmit, I fixed it up.

I also dropped the now redundant comment about not supported features
from the driver code.

Thanks, applied to -next.

Guenter


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

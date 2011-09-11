From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 11 Sep 2011 16:29:47 +0000
Subject: Re: [lm-sensors] [PATCH v2] hwmon: (pmbus) Fix low limit
Message-Id: <20110911182947.0077662f@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sun, 11 Sep 2011 07:36:33 -0700, Guenter Roeck wrote:
> Temperature alarms are detected by checking the alarm bit and comparing
> temperature limits against the current temperature. For low limits, this
> comparison needs to be reversed (temp < limit instead of temp > limit).
> This was not taken into account, resulting in wrong alarms if a temperature
> fell below a low limit.
> 
> Fix by adding a low limit flag in the limit data structure. When creating the
> sensor entry, the order of registers to compare is now reversed for low limits.
> 
> Signed-off-by: Guenter Roeck <guenter.roeck@ericsson.com>
> ---
> v2: One of the tagged alarms wasn't a low limit.
> 
>  drivers/hwmon/pmbus/pmbus_core.c |    9 ++++++++-
>  1 files changed, 8 insertions(+), 1 deletions(-)
> (...)

Acked-by: Jean Delvare <khali@linux-fr.org>

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

From: Jean Delvare <khali@linux-fr.org>
Date: Fri, 17 Dec 2010 21:40:36 +0000
Subject: Re: [lm-sensors] [PATCH v2] hwmon: sysfs ABI updates
Message-Id: <20101217224036.637617e3@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1292434586-7283-1-git-send-email-guenter.roeck@ericsson.com>
In-Reply-To: <1292434586-7283-1-git-send-email-guenter.roeck@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Guenter,

On Wed, 15 Dec 2010 09:36:26 -0800, Guenter Roeck wrote:
> Add attributes supported by various PMBus devices to hwmon sysfs ABI.
> 
> Signed-off-by: Guenter Roeck <guenter.roeck@ericsson.com>
> ---
> v2 changes:
> Removed power[1-*]_alarm description from power section. Refer to alarms
> section instead.
> Added power[1-*]_cap_alarm.
> 
>  Documentation/hwmon/sysfs-interface |   40 ++++++++++++++++++++++++++++------
>  1 files changed, 33 insertions(+), 7 deletions(-)
> (...)

Looks alright to me, feel free to add to your hwmon tree.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

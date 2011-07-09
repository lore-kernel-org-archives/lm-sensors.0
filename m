From: Jean Delvare <khali@linux-fr.org>
Date: Sat, 09 Jul 2011 20:50:10 +0000
Subject: Re: [lm-sensors] [PATCH v3 3/3] hwmon: (lm95241) Add support for
Message-Id: <20110709225010.003dd957@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1310071365-2475-4-git-send-email-guenter.roeck@ericsson.com>
In-Reply-To: <1310071365-2475-4-git-send-email-guenter.roeck@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, 7 Jul 2011 13:42:45 -0700, Guenter Roeck wrote:
> LM95231 is fully compatible to LM95241; only necessary change is to add
> LM95231 chip detection.
> 
> Signed-off-by: Guenter Roeck <guenter.roeck@ericsson.com>

Looks very good.

Acked-by: Jean Delvare <khali@linux-fr.org>

> ---
>  drivers/hwmon/Kconfig   |    5 +++--
>  drivers/hwmon/lm95241.c |   31 +++++++++++++++++++------------
>  2 files changed, 22 insertions(+), 14 deletions(-)
> (...)

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

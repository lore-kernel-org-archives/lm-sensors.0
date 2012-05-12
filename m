From: Jean Delvare <khali@linux-fr.org>
Date: Sat, 12 May 2012 15:41:16 +0000
Subject: Re: [lm-sensors] [PATCH v4] hwmon: (it87) Make temp3 attribute conditional for IT8782F
Message-Id: <20120512174116.270091a3@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1336772553-12823-2-git-send-email-guenter.roeck@ericsson.com>
In-Reply-To: <1336772553-12823-2-git-send-email-guenter.roeck@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Fri, 11 May 2012 14:42:33 -0700, Guenter Roeck wrote:
> From: Guenter Roeck <linux@roeck-us.net>
> 
> On IT8782F, temp3 is only supported if UART6 is disabled.
> 
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
> v4: Review feedback
> v3: Resolve conflicts with previous patches.
>     Only remove temp sysfs attributes if the to-be-removed sensor exists,
>     to be in sync with the other attribute removal code.
> v2: Drop condition for IT8783F. On that chip, UART6 may be routed via JP4 to
>     a different set of pins, so we can not reliably detect if temp3 and RI6
>     overlap or not. 
>  drivers/hwmon/it87.c |   81 +++++++++++++++++++++++++++++++++++++------------
>  1 files changed, 61 insertions(+), 20 deletions(-)
> (...)

Acked-by: Jean Delvare <khali@linux-fr.org>

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

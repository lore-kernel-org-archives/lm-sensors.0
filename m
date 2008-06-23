From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 23 Jun 2008 17:06:26 +0000
Subject: Re: [lm-sensors] [PATCH v2 1/2] hwmon: (lm90) Convert some macros
Message-Id: <20080623190626.7ae2e4bf@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1213989596-8716-2-git-send-email-ncase@xes-inc.com>
In-Reply-To: <1213989596-8716-2-git-send-email-ncase@xes-inc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Nate,

On Fri, 20 Jun 2008 14:19:55 -0500, Nate Case wrote:
> Use static functions instead of the TEMPx_FROM_REG* and TEMPx_TO_REG*
> macros.  This will ensure type safety and eliminate any side effects
> from arguments passed in since the macros referenced 'val' multiple
> times.  This change should not affect functionality.

Almost correct, but I get the following warnings at build time:

drivers/hwmon/lm90.c: In function "show_temp8":
drivers/hwmon/lm90.c:282: warning: format "%d" expects type "int", but argument 3 has type "long int"
drivers/hwmon/lm90.c:282: warning: format "%d" expects type "int", but argument 3 has type "long int"
drivers/hwmon/lm90.c: In function "show_temp11":
drivers/hwmon/lm90.c:316: warning: format "%d" expects type "int", but argument 3 has type "long int"
drivers/hwmon/lm90.c:316: warning: format "%d" expects type "int", but argument 3 has type "long int"
drivers/hwmon/lm90.c: In function "show_temphyst":
drivers/hwmon/lm90.c:356: warning: format "%d" expects type "int", but argument 3 has type "long int"
drivers/hwmon/lm90.c:356: warning: format "%d" expects type "int", but argument 3 has type "long int"

This is because you changed temp1_from_reg and temp2_from_reg to return
longs instead of ints. We don't need longs, so the easiest fix is to
revert that change. If you insist on returning longs then you must
change %d to %ld in the sprintf calls.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

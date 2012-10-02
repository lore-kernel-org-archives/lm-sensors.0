From: Guenter Roeck <linux@roeck-us.net>
Date: Tue, 02 Oct 2012 18:23:09 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: Drop needless includes of <linux/delay.h>
Message-Id: <20121002182309.GA27236@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <20121002182056.6adb0fa4@endymion.delvare>
In-Reply-To: <20121002182056.6adb0fa4@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, Oct 02, 2012 at 06:20:56PM +0200, Jean Delvare wrote:
> These drivers use no sleep or delay functions so they don't need to
> include <linux/delay.h>.
> 
> Signed-off-by: Jean Delvare <khali@linux-fr.org>
> Cc: Rudolf Marek <r.marek@assembler.cz>

Acked-by: Guenter Roeck <linux@roeck-us.net>

Related question: Some drivers use jiffies but don't include linux/jiffies.h.
Should we add that ?

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

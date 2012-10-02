From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 02 Oct 2012 19:13:42 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: Drop needless includes of <linux/delay.h>
Message-Id: <20121002211342.4a11724d@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20121002182056.6adb0fa4@endymion.delvare>
In-Reply-To: <20121002182056.6adb0fa4@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, 2 Oct 2012 11:23:09 -0700, Guenter Roeck wrote:
> On Tue, Oct 02, 2012 at 06:20:56PM +0200, Jean Delvare wrote:
> > These drivers use no sleep or delay functions so they don't need to
> > include <linux/delay.h>.
> > 
> > Signed-off-by: Jean Delvare <khali@linux-fr.org>
> > Cc: Rudolf Marek <r.marek@assembler.cz>
> 
> Acked-by: Guenter Roeck <linux@roeck-us.net>
> 
> Related question: Some drivers use jiffies but don't include linux/jiffies.h.
> Should we add that ?

Yes we should, otherwise we are at the mercy of build errors in the
future whenever inter-header file inclusions change.

I'll take care of this second patch to avoid conflicts with this one.

Thanks,
-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

From: Guenter Roeck <linux@roeck-us.net>
Date: Tue, 02 Oct 2012 19:52:59 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: Drop needless includes of <linux/delay.h>
Message-Id: <20121002195259.GA31690@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <20121002182056.6adb0fa4@endymion.delvare>
In-Reply-To: <20121002182056.6adb0fa4@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, Oct 02, 2012 at 09:13:42PM +0200, Jean Delvare wrote:
> On Tue, 2 Oct 2012 11:23:09 -0700, Guenter Roeck wrote:
> > On Tue, Oct 02, 2012 at 06:20:56PM +0200, Jean Delvare wrote:
> > > These drivers use no sleep or delay functions so they don't need to
> > > include <linux/delay.h>.
> > > 
> > > Signed-off-by: Jean Delvare <khali@linux-fr.org>
> > > Cc: Rudolf Marek <r.marek@assembler.cz>
> > 
> > Acked-by: Guenter Roeck <linux@roeck-us.net>
> > 
> > Related question: Some drivers use jiffies but don't include linux/jiffies.h.
> > Should we add that ?
> 
> Yes we should, otherwise we are at the mercy of build errors in the
> future whenever inter-header file inclusions change.
> 
> I'll take care of this second patch to avoid conflicts with this one.
> 
Ok. Here is the list of affected files:

   drivers/hwmon/adm9240.c
   drivers/hwmon/adt7475.c
   drivers/hwmon/asus_atk0110.c
   drivers/hwmon/emc1403.c
   drivers/hwmon/hih6130.c
   drivers/hwmon/i5k_amb.c	(includes jiffies.h but doesn't use it as far as I can see)
   drivers/hwmon/ina2xx.c
   drivers/hwmon/lineage-pem.c
   drivers/hwmon/lm92.c
   drivers/hwmon/lm93.c
   drivers/hwmon/ltc4151.c
   drivers/hwmon/ltc4245.c
   drivers/hwmon/ltc4261.c
   drivers/hwmon/pmbus/pmbus_core.c
   drivers/hwmon/sht21.c
   drivers/hwmon/smm665.c
   drivers/hwmon/thmc50.c
   drivers/hwmon/tmp102.c
   drivers/hwmon/w83792d.c
   drivers/hwmon/w83793.c
   drivers/hwmon/w83795.c
   drivers/hwmon/w83l786ng.c

Guess I am guilty for many of those :).

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

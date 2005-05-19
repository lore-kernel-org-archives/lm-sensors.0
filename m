From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:47 +0000
Subject: Backport i2c-ali1563.c from linux-2.6 to linux-2.4
Message-Id: <20050329203948.152a4e01.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <FF9D611BFCDB1E42B37FAA148096BECE2E5499@weshml03.winbond.com.tw>
In-Reply-To: <FF9D611BFCDB1E42B37FAA148096BECE2E5499@weshml03.winbond.com.tw>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Rudolf, hi Chunhao,

(I agree with all of Rudolf's comments.)

> It depends if others want to leave ENTER and LEAVE macros. I cant tell
> you. If they do not complain after this email, leave them :)

Nice catch Rudolf, please remove them Chunhao. They might come in handy
when first writing the driver but then there are less intrusive, more
useful debug statements for the maintainance times.

> Also I think you can safy remove lines like:
>         /* dev_warn(&a->dev,"ali1563: Trying to reset busy device\n");
>          */
>         /* modified by chunhao */
> Because functionality is still same, only expressed other way for this
> 2.4 kernels. Could you always add ali1563 to the logs expect the
> KERN_DEBUG?
> 
>    printk(KERN_WARNING "ali1563: <=this helps to locate correct driver
> that wrote this line to kernel log.

Agreed. Note that it *is* possible to use dev_dbg in lm_sensors 2.9,
thanks to a compatibility header file named "sensor_compat.h".

#include "sensors_compat.h"

The only difference with 2.6 is that the first parameter is &adapter,
not &adapter->dev.

You need to include sensors_compat.h anyway, because it contains other
compatibility macros for old 2.4 kernels.

Thanks,
-- 
Jean Delvare

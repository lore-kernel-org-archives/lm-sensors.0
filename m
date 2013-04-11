From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 11 Apr 2013 08:36:19 +0000
Subject: Re: [lm-sensors] request for TMP432
Message-Id: <20130411103619.2c12ca0f@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <06BD56040955684AB7DB9D4C50FFEB7E119117@DNCE04.ent.ti.com>
In-Reply-To: <06BD56040955684AB7DB9D4C50FFEB7E119117@DNCE04.ent.ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Quentin,

On Thu, 11 Apr 2013 08:15:10 +0000, BICHON, Quentin wrote:
> This stand-alone driver is very appreciated by the team, however they are using the following kernel version:
> Linux version 2.6.32.27-Cavium-Octeon
> And the code on the driver is apparently not compatible.
> 
> Do you know if some minor changes could fix this?

Most certainly yes. The same problem happens for every single driver
and so far I have always been able to add compatibility code to make it
work. For all i2c-related compatibility issues I have a separate header
file common to all the drivers I maintain. The latest version can be
seen at:

http://khali.linux-fr.org/devel/misc/adt7410/i2c-compat.h

So adding this file and the following line near the top of the tmp401
driver should solve most issues:

#include "i2c-compat.h"

There may be a few remaining issues left, I'll leave them to Guenter.

Quentin, your testing is very appreciated. Would you or someone in your
team also be able to review Guenter's patches? This would speed up
upstream integration.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

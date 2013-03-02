From: Jean Delvare <khali@linux-fr.org>
Date: Sat, 02 Mar 2013 08:01:26 +0000
Subject: Re: [lm-sensors] [PATCH] lib/smbus.c: Include stddef.h to fix build error
Message-Id: <20130302090126.699ab392@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1362178124-2796-1-git-send-email-linux@roeck-us.net>
In-Reply-To: <1362178124-2796-1-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Fri,  1 Mar 2013 14:48:44 -0800, Guenter Roeck wrote:
> lib/smbus.c fails to build since NULL is undefined.
> 
> Reported-by: Tobias Simon <tobias.simon@tu-ilmenau.de>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>

Good catch, please commit.

Next time, please include "i2c-tools" or "libi2c" somewhere in the
subject or summary so that it is more obvious what piece of software
you're fixing ;)

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

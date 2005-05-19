From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:23 +0000
Subject: compilation failure
Message-Id: <20041121134655.50aad8a1.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20041121091125.54bf9037.amorabito@funescoop.com.ar>
In-Reply-To: <20041121091125.54bf9037.amorabito@funescoop.com.ar>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> Dear developers,
> 
> I get the following errors when trying to compile lm-sensors 2.8.8:
> 
> kernel/chips/lm93.c: In function `lm93_fan_smart_tach':
> kernel/chips/lm93.c:1691: parse error before `int'
> kernel/chips/lm93.c:1694: `mapping' undeclared (first use in this
> function) kernel/chips/lm93.c:1694: (Each undeclared identifier is
> reported only once kernel/chips/lm93.c:1694: for each function it
> appears in.) make: *** [kernel/chips/lm93.o] Error 1
> 
> I succesfully compiled and installed i2c-2.8.8 before and I'm running
> a 2.4.27 linux kernel on a i686 machine with gcc            2.95.4-14
> libc6          2.2.5-11.5
> 
> /lib/modules/2.4.27 is fine and kernel 2.4.27  sources are under
> /usr/src/linux
> 
> If you've got the time please tell me how to work it out. Thank you!

Already reported here:
http://archives.andrew.net.au/lm-sensors/msg28153.html
The post has the fix.

The fix was aleady applied to CVS, btw.

Thanks,

-- 
Jean Delvare
http://khali.linux-fr.org/

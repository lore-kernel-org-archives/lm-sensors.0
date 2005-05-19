From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:12 +0000
Subject: use of iconv() in main.c
Message-Id: <20040816123027.M64053@ensicaen.ismra.fr>
List-Id: <lm-sensors.vger.kernel.org>
References: <200408160857.i7G8vTrs027501@localhost.localdomain>
In-Reply-To: <200408160857.i7G8vTrs027501@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> > Is there a way we could detect the use of uClibc? If there is a known
> > #define, we could use it to automatically disable the use of iconv.
> 
> In the case of cross-compiling, there is probably a way of detecting 
> it's use. However, I'm using a chroot-environment and then just 
> running make with the defaults.

I was thinking of a test like this within the C source code:
#if defined(__GLIBC__) && __GLIBC__ = 2
#include <something>
#endif

We have this for detecting glibc 2.x. Maybe there is a similar symbol defined
for uClib? If there is, we could rely on it to automatically disable the use
of iconv. This would work for both the cross-compilation and the
chroot-environment cases.

For glibc 2.3, the symbol is defined in include/features.h. Could you please
take a look at this file (or any other you see fit) in your uClibc compilation
environment and search for a similar line? If you find something relevant, let
us know.

Thanks,

-- 
Jean "Khali" Delvare
http://khali.linux-fr.org/

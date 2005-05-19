From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:23:42 +0000
Subject: 2.7.0 testings
Message-Id: <20021128171834.37c69030.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20021127213903.5b84866d.khali@linux-fr.org>
In-Reply-To: <20021127213903.5b84866d.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> We have a problem. 2.2 kernels may not have a
> /lib/modules/$VERSION/build symlink. I don't know what's responsible
> for creating it. Curiously, when I tried on my laptop with a 2.2.22
> kernel, the symlink was created. But on my old desktop system, kernels
> 2.2.14, 2.2.16 and 2.2.20 don't have one.

I tried 2.2.22 on the same system, and no symlink was created. So I
guess that it does depend on some tool (modutils?) and not on the kernel
versions.

> I also get this warning for many files:
> /usr/src/linux-2.2.20/include/linux/module.h:13: warning: `_set_ver'
> redefined
> /usr/src/linux-2.2.20/include/linux/modsetver.h:9: warning: this is
> the location of the previous definition
> But I guess this is a kernel-side problem, right? Gonna try on a
> 2.2.22 to see if it has been fixed.

No warning with kernel 2.2.22, I guess we can safely ignore this
warning.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/

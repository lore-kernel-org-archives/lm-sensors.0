From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:33 +0000
Subject: Dependency problem during compile
Message-Id: <1073639545.3ffe70791bf2a@imp.gcu.info>
List-Id: <lm-sensors.vger.kernel.org>
References: <1073609543.32040.73.camel@localhost>
In-Reply-To: <1073609543.32040.73.camel@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> I'm having compile problems when using lm sensors 2.8.2.
> 
> It appears to me that the dependancies don't get correctly worked out
> by the make file.
> 
> The error I get is as follows...
> 
> make: *** No rule to make target `linux/modsetver.h', needed by
> `kernel/chips/vt1211.d'.  Stop.
>
> (...)
>
> # The currently running kernel version. This is used right below to
> # determine where the kernel sources can be found.
> KERNELVERSION := 2.4.21
> 
> # The location of linux itself. This is used to find the kernel
> # headers and other things.
> LINUX := /home/darren/MiniMyth/kernelNewTry/linux-2.4.21
> #LINUX := $(shell if [ -L /lib/modules/$(KERNELVERSION)/build ] ; \
> #	then echo "/lib/modules/$(KERNELVERSION)/build" ; \
> #	else echo "/usr/src/linux" ; fi)
> LINUX_HEADERS := $(LINUX)/include

The kernel must have been configured and compiled at least once in the
pointed location before lm_sensors can be successfully compiled against
it. Didn't you miss that step?

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/

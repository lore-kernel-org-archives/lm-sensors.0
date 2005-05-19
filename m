From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:43 +0000
Subject: RFC PATCH Trivial: Query :- is sysfs vrm supposed to be
Message-Id: <20050316114620.49ac624b.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <ekmf31hdtifbqdb04lhustt5aab3o0ufuj@4ax.com>
In-Reply-To: <ekmf31hdtifbqdb04lhustt5aab3o0ufuj@4ax.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Grant,

> Reported read-only VID depends on VRM, also marked read-only.

This is a documentation error, vrm is actually read/write (but read
below).

> Doesn't seem right to me, where does VRM type value come from?
> If it is a driver constant, okay.
> If it is outside the driver, where do I get it from?
> If it is a documentation mistake, someone please let me know, 
> this just an extra irritant I forget to resolve every couple days :)

VRM depends on the CPU and can be set from two different sources:
1* User-space, by writing to the vrm sysfs file.
2* Kernel-space, determined automatically from the CPU brand and model.

In older versions of the driver, VRM version was hardcoded into the
driver and couldn't be changed. We added a way to change VRM later, when
we found that some hardware monitoring chips could be used with
different CPU modules, which were using different VRM versions.

Until recently, only the first method was implemented (the user had to
manually change the VRM version in /etc/sensors.conf if the arbitrary
default set in each driver wasn't correct). But since VRM can be deduced
from the CPU brand and model, Rudolf Marek implemented a detection
function (see i2c/i2c-sensor-vid.c), which is now used (or should be) by
all drivers. This means that the default VRM should now be OK for
everyone, and should never need to be changed in /etc/sensors.conf. We
could even switch the vrm sysfs file to read-only or even delete it
altogether.

However, there are a couple cases where having the vrm file could help:
1* Debugging of the VRM version auto-detection.
2* New CPUs using an already implemented VRM version but not properly
   detected.

3* Experimental stuff, like demo boards on parallel port, etc... which
   might want to use a VRM version that it NOT the one of the host.

So, put in short, the vrm file is technically read/write, but should not
need to be writen to by most users anymore.

> --- linux-2.6.11-mm3-p2x/Documentation/i2c/sysfs-interface.orig	2004-12-25 08:34:01.000000000 +1100
> +++ linux-2.6.11-mm3-p2x/Documentation/i2c/sysfs-interface	2005-03-16 18:02:27.000000000 +1100
> @@ -110,7 +110,7 @@
>  		Not always correct.
>  
>  vrm		Voltage Regulator Module version number. 
> -		Read only.
> +		Read/Write
>  		Two digit number, first is major version, second is
>  		minor version.
>  		Affects the way the driver calculates the CPU core reference

Patch is correct, please send it to Greg KH with explanation and
Signed-Off-By line.

Thanks,
-- 
Jean Delvare

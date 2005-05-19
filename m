From: khali@linux-fr.org (Khali)
Date: Thu, 19 May 2005 06:23:40 +0000
Subject: lm_sensors2 Makefile
Message-Id: <1033131073.3d945441d6d95@imp.free.fr>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> Modified Files:
> 	Makefile 
> Log Message:
> (mds) take LINUX from /lib/modules/x.x.x/build; patch from
>       Dave Johnson <ddj@cascv.brown.edu>

Hmmm...
This isn't that clear to me.

While the new way (/lib/modules/$(shell uname -r)/build) ensures we are 
compiling the modules for the current kernel, the old way (/usr/src/linux) 
allowed one to compile the modules for the default kernel, whatever the current 
kernel is.

As far as I'm concerned, I prefer the old way. I happen to change kernel 
versions quite often (testing both ACPI and CPUFreq on my system) and have to 
reconfigure and reinstall i2c and lm_sensors everytime. Using /usr/src/linux as 
the default, I am able to do so *before* I actually reboot on the new kernel. 
With the new way, I would have to do the same *after* the reboot.

I would be pleased to listen to arguments in favor of the new way.

Anyway, whatever we decide, I think that we should do the same in i2c and 
lm_sensors (which isn't the case right now).

Later,
Khali

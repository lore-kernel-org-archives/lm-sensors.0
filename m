From: Rene Herman <rene.herman@keyaccess.nl>
Date: Sun, 22 Jun 2008 15:43:57 +0000
Subject: Re: [lm-sensors] [REGRESSION, ABI] Re:  LMSENSORS: 2.6.26-rc,
Message-Id: <485E733D.8060109@keyaccess.nl>
List-Id: <lm-sensors.vger.kernel.org>
References: <485DA11C.7050906@keyaccess.nl> <485DFF35.6080008@hhs.nl> <485E505F.8010306@keyaccess.nl> <485E61DE.6020202@hhs.nl>
In-Reply-To: <485E61DE.6020202@hhs.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Hans de Goede <j.w.r.degoede@hhs.nl>
Cc: linux-acpi@vger.kernel.org, Linux Kernel <linux-kernel@vger.kernel.org>, lm-sensors@lm-sensors.org, "Mark M. Hoffman" <mhoffman@lightlink.com>, Zhang Rui <rui.zhang@intel.com>

On 22-06-08 16:29, Hans de Goede wrote:

Oh, and...

> I wonder what just plain "sensors" (without the -s) does.

Same thing as sensors -s:

rene@7ixe4:~$ sensors 

Can't access procfs/sysfs file
Kernel interface access error
For 2.6 kernels, make sure you have mounted sysfs and libsensors
was compiled with sysfs support!

And no, the values are not being set by sensors -s, it's not just 
complaining but still working.

Rene.

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

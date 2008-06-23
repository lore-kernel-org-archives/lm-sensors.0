From: Matthew Garrett <mjg59@srcf.ucam.org>
Date: Mon, 23 Jun 2008 14:31:12 +0000
Subject: Re: [lm-sensors] LMSENSORS: 2.6.26-rc,
Message-Id: <20080623143112.GA4160@srcf.ucam.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <485DA11C.7050906@keyaccess.nl> <485DFF35.6080008@hhs.nl> <485E505F.8010306@keyaccess.nl> <485E61DE.6020202@hhs.nl> <20080623120844.5f722aa6@hyperion.delvare> <485F79C6.20507@keyaccess.nl> <20080623135704.2980078c@hyperion.delvare> <485F9877.1060902@keyaccess.nl>
In-Reply-To: <485F9877.1060902@keyaccess.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Rene Herman <rene.herman@keyaccess.nl>
Cc: Jean Delvare <khali@linux-fr.org>, Hans de Goede <j.w.r.degoede@hhs.nl>, linux-acpi@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>, "Mark M. Hoffman" <mhoffman@lightlink.com>, Linux Kernel <linux-kernel@vger.kernel.org>, lm-sensors@lm-sensors.org

On Mon, Jun 23, 2008 at 02:35:03PM +0200, Rene Herman wrote:
> libsensors dictated the ABI rule that the hwmon directories must have 
> device backlinks; the new ACPI Thermal Zone hwmon interface breaks that 
> bit of ABI. It is not relevant that that ABI may have gotten to be as a 
> result of unfortunate programming on the userspace side -- the only 
> thing relevant is that it IS. lm-sensors 2 is on millions of systems out 
> there. This is not meant agressively, or whatever you guys seem to want 
> to read in my words, it's un undeniable fact.

No, libsensors made an assumption about the ABI that turns out not to be 
true. The ABI hasn't changed, libsensors is just being exposed to a case 
it didn't previously see.

We've had this kind of change before. The ACPI backlight code changed in 
such a way that scripts that blindly wrote values instead of (correctly) 
reading the maximum brightness value broke. mmap's behaviour changed in 
such a way that it was no longer possible for vm86 to execute code that 
wasn't mapped as executable, breaking libx86. The applications in 
question were undeniably buggy. Those are examples that I was personally 
involved with - I'm sure there are others. Where userspace has made 
false assumptions, it's not the kernel's responsibility to continue to 
support those assumptions.

-- 
Matthew Garrett | mjg59@srcf.ucam.org

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

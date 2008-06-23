From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 23 Jun 2008 10:56:39 +0000
Subject: Re: [lm-sensors] LMSENSORS: 2.6.26-rc,
Message-Id: <20080623125639.5c8c4416@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <485DA11C.7050906@keyaccess.nl>
	<485DFF35.6080008@hhs.nl>
	<485E505F.8010306@keyaccess.nl>
	<485E61DE.6020202@hhs.nl>
	<485E6F12.4010307@keyaccess.nl>
	<485E94ED.10602@hhs.nl>
	<485E992B.8010101@keyaccess.nl>
In-Reply-To: <485E992B.8010101@keyaccess.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Rene Herman <rene.herman@keyaccess.nl>
Cc: Hans de Goede <j.w.r.degoede@hhs.nl>, linux-acpi@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>, lm-sensors@lm-sensors.org, Linux Kernel <linux-kernel@vger.kernel.org>, "Mark M. Hoffman" <mhoffman@lightlink.com>

Hi Rene,

On Sun, 22 Jun 2008 20:25:47 +0200, Rene Herman wrote:
> On 22-06-08 20:07, Hans de Goede wrote:
> > Know something else? I've just stopped caring about this issue, I'm not 
> > the author of the changes causing said breakage. I'm merely an 
> > lm_sensors (both userspace and kernel space) developer who was heavily 
> > involved in getting this fixed for lm_sensors-3.0.2, and I believe that 
> > adding yet another kconfig option which we then carry for years and 
> > years is _not_ a good solution. Some userspace utlities like udev sit 
> > very close to the kernel and sometimes an kernel update mandates a new 
> > udev. To me this is much the same.
> > 
> > But at the end of the day, I do not feel responsible for this as I'm not 
> > the author of the code causing the breakage. I'm just someone who knows 
> > the ins and outs and tried to help, but given the treatment and thanks 
> > I've been getting for my help I'm stopping with helping now.
> 
> What on earth are you talking about? Could you please re-read? I didn't 
>   "treat badly" you, hwmon, acpi or whatever.

You certainly did. I felt the same as Hans when reading the discussion
thread.

Now, you are lucky that I already know you and I know that you are
usually helpful and cooperative, so I know that you probably didn't
mean the aggressive tone you used. But presumably Hans doesn't know
you, so his reaction was understandable.

Hans is one of the main contributors to the hwmon subsystem and the
lm-sensors project in general. I would be grateful if the users he
tries to help could treat him with the respect he reserves. If he was
to leave the project, this would be a significant loss, and this is
something I really want to avoid.

Thanks,
-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

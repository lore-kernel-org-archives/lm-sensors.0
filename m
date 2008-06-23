From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 23 Jun 2008 11:06:01 +0000
Subject: Re: [lm-sensors] LMSENSORS: 2.6.26-rc,
Message-Id: <20080623130601.7715773e@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <485DA11C.7050906@keyaccess.nl>
	<485DFF35.6080008@hhs.nl>
	<485E505F.8010306@keyaccess.nl>
	<485E61DE.6020202@hhs.nl>
	<485E6F12.4010307@keyaccess.nl>
	<485E94ED.10602@hhs.nl>
	<485E992B.8010101@keyaccess.nl>
	<485ECB23.4010305@keyaccess.nl>
	<1214185482.3001.45.camel@rzhang-dt.sh.intel.com>
In-Reply-To: <1214185482.3001.45.camel@rzhang-dt.sh.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Zhang Rui <rui.zhang@intel.com>
Cc: Rene Herman <rene.herman@keyaccess.nl>, Hans de Goede <j.w.r.degoede@hhs.nl>, linux-acpi@vger.kernel.org, "Mark M. Hoffman" <mhoffman@lightlink.com>, Linux Kernel <linux-kernel@vger.kernel.org>, lm-sensors@lm-sensors.org

Hi Rui,

On Mon, 23 Jun 2008 09:44:42 +0800, Zhang Rui wrote:
> On Mon, 2008-06-23 at 05:58 +0800, Rene Herman wrote:
> > On 22-06-08 20:25, Rene Herman wrote:
> > 
> > > Another way to solve it _could_ be to just make up a device link if
> > > something generic is available so that sensors doesn't trip over it
> > > in the first place but I don't know if that's a good option. You
> > > might.
> > 
> > This also works for me and, if correct, is ofcourse better than the
> > CONFIG option. Wants a comment from the thermal_zone side (for which
> > Zhang Rui seems the correct CC?) though.
> Hi, Rene and Hans,
> 
> Thank you for your efforts on this issue and sorry for the late
> response, I did not check my email during the whole weekend.
> 
> About the hwmon ABI, after the device symbol link is created, are there
> any other ABIs required in the device node?

Not that I know of. The code currently in the kernel works just fine
with both lm-sensors SVN trunk (which will become 2.10.7 soon) and
3.0.2 as far as I can see.

> If no, this patch seems to work, although it might break if the first
> registered ACPI thermal zone device is unregistered, which ONLY happens
> theoretically.

If I remember correctly, there are more than one device in a given
thermal zone, so having a link pointing to one of them would create an
asymmetry. This basically means that nobody can use the device link in
question, so there's no point in creating it from a functional point of
view. If the goal is simply to solve the breakage that was reported by
Rene, the bug is in libsensors, so that' where it must be fixed (and
actually it already is.)

Thanks,
-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 23 Jun 2008 19:54:42 +0000
Subject: Re: [lm-sensors] LMSENSORS: 2.6.26-rc,
Message-Id: <20080623215442.0a536bf4@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <485DA11C.7050906@keyaccess.nl>
	<485DFF35.6080008@hhs.nl>
	<485E505F.8010306@keyaccess.nl>
	<485E61DE.6020202@hhs.nl>
	<485E6F12.4010307@keyaccess.nl>
	<alpine.LFD.1.10.0806231333030.2984@localhost.localdomain>
In-Reply-To: <alpine.LFD.1.10.0806231333030.2984@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Len Brown <lenb@kernel.org>
Cc: Rene Herman <rene.herman@keyaccess.nl>, linux-acpi@vger.kernel.org, Linux Kernel <linux-kernel@vger.kernel.org>, lm-sensors@lm-sensors.org, "Mark M. Hoffman" <mhoffman@lightlink.com>, Hans de Goede <j.w.r.degoede@hhs.nl>, Zhang Rui <rui.zhang@intel.com>

Hi Len,

On Mon, 23 Jun 2008 13:54:56 -0400 (EDT), Len Brown wrote:
> Rene,
> Thank you for reporting this.
> 
> I agree that this failure is an unwelcome surprise to those users
> who upgrade to 2.6.26 but are still using libsensors <= 2.10.6.
> 
> Jean, Mark, Hans,
> 
> I'm actually fine with adding a temporary kernel config option
> along the lines Rene suggested to ease the  migration
> to linux-2.6.26 for those users.
> 
> But the config option would need to be scheduled for removal
> after a certain period (say 6 months) so we don't have to maintain
> it forever.
> 
> More importantly, I think it would also have to be disabled by default
> so that it would not have a negative impact on what we think are the
> majority of properly configured systems.  After all, we fixed this
> bug in user-space about out 4 months ago and as you point out, the
> distro upgrade path is actually quite well looked after.
> 
> So I'm not sure how useful it would be to the target users.
> After they run into the problem, they'd probably google it
> and find that they can either tweak a kernel config option
> or upgrade libsensors.  And we'd prefer that they do the
> later rather than the former, yes?

If the option defaults to thermal zone being enabled, and users have to
rebuild their kernel to disable it, then I don't think it has any
value. Patching and rebuilding libsensors is no harder than
reconfiguring and rebuilding the kernel, so we can as well tell the
users to do the former.

If the option defaults to thermal zone being disabled, then it makes
some sense as a way to smooth the transition. If the help text is clear
enough (clearly saying for which versions of lm-sensors users can
enable the option and for which versions they would rather not) it
should work. The drawback being that users in a hurry might stick to
the default without reading the help text, and miss an opportunity to
have the ACPI thermal zones magically integrated into their favorite
monitoring application.

Whether avoiding the risk of easily fixable breakage for some users is
worth the temporary loss of new functionality for other users, I can't
really say. I think I wouldn't do it myself, but I'm not the only one
to decide. If we decide to do it, I have no objection.

Thanks,
-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

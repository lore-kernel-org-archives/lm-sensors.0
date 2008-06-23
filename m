From: Len Brown <lenb@kernel.org>
Date: Mon, 23 Jun 2008 17:54:56 +0000
Subject: Re: [lm-sensors] [REGRESSION, ABI] Re:  LMSENSORS: 2.6.26-rc,
Message-Id: <alpine.LFD.1.10.0806231333030.2984@localhost.localdomain>
List-Id: <lm-sensors.vger.kernel.org>
References: <485DA11C.7050906@keyaccess.nl> <485DFF35.6080008@hhs.nl>
 <485E505F.8010306@keyaccess.nl> <485E61DE.6020202@hhs.nl>
 <485E6F12.4010307@keyaccess.nl>
In-Reply-To: <485E6F12.4010307@keyaccess.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Rene Herman <rene.herman@keyaccess.nl>
Cc: Hans de Goede <j.w.r.degoede@hhs.nl>, linux-acpi@vger.kernel.org, Linux Kernel <linux-kernel@vger.kernel.org>, lm-sensors@lm-sensors.org, "Mark M. Hoffman" <mhoffman@lightlink.com>, Zhang Rui <rui.zhang@intel.com>

Rene,
Thank you for reporting this.

I agree that this failure is an unwelcome surprise to those users
who upgrade to 2.6.26 but are still using libsensors <= 2.10.6.

Jean, Mark, Hans,

I'm actually fine with adding a temporary kernel config option
along the lines Rene suggested to ease the  migration
to linux-2.6.26 for those users.

But the config option would need to be scheduled for removal
after a certain period (say 6 months) so we don't have to maintain
it forever.

More importantly, I think it would also have to be disabled by default
so that it would not have a negative impact on what we think are the
majority of properly configured systems.  After all, we fixed this
bug in user-space about out 4 months ago and as you point out, the
distro upgrade path is actually quite well looked after.

So I'm not sure how useful it would be to the target users.
After they run into the problem, they'd probably google it
and find that they can either tweak a kernel config option
or upgrade libsensors.  And we'd prefer that they do the
later rather than the former, yes?

just let me know.

thanks,
-Len

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

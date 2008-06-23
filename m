From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 23 Jun 2008 10:08:44 +0000
Subject: Re: [lm-sensors] LMSENSORS: 2.6.26-rc,
Message-Id: <20080623120844.5f722aa6@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <485DA11C.7050906@keyaccess.nl>
	<485DFF35.6080008@hhs.nl>
	<485E505F.8010306@keyaccess.nl>
	<485E61DE.6020202@hhs.nl>
In-Reply-To: <485E61DE.6020202@hhs.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Hans de Goede <j.w.r.degoede@hhs.nl>
Cc: Rene Herman <rene.herman@keyaccess.nl>, linux-acpi@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>, "Mark M. Hoffman" <mhoffman@lightlink.com>, Linux Kernel <linux-kernel@vger.kernel.org>, lm-sensors@lm-sensors.org

Hi Hans,

On Sun, 22 Jun 2008 16:29:50 +0200, Hans de Goede wrote:
> Rene Herman wrote:
> > This is an ABI breakage issue and an unfortunate one at that:
> 
> No it is not, (...)

Technically speaking, Hans is right. The problem doesn't qualify as an
"ABI breakage". Just because a kernel update broke user-space, doesn't
imply API breakage.

That being said, the truth is that we don't really care how the
breakage is called. It's broken and needs to be fixed, that's all we
care about.

> (...)
> Actually its lm_sensors userspace which is to blame, as instead of skipping the 
> new hwmon device which it doesn't understand it aborts (atleast that is what I 
> understand from what you're telling us).

Yes, user-space is to blame.

> > (...)
> > So it seems we have here a change to the kernel requiring a userspace 
> > basically noone is ready for
> 
> Erm if you look at that same page you will notice there are links to patches 
> for almost every userspace package which uses lm_sensors, I know as I wrote 
> most of them, quite a few of them have been integrated by their resp. upstreams.

Can you please update the wiki to say so? I was myself wondering
whether your patches had been integrated or not by now.

Maybe we could present things a bit better, for example with a table or
a bullet-list, listing all applications, with the minimum version that
has libsensors 3 support (for applications which are already updated
upstream) or a link to the patch (for those which are not.) This could
stay on the Download page, or be moved to a dedicated page. If you have
some time to do something like this, please do. If not, please tell me,
I'll take care of the reformatting and then you can update the entries.

> Also "noone is ready for"? lm_sensors-3.0.x is the default in both Fedora 9 and 
> OpenSuse 11.

Note: openSuse 11.0 ships with both libsensors 2.10.6 and libsensors
3.0.2. sensors links with the latter, but other applications presumably
link with the former. This version of openSuse is the transition one.
The plan is to only have libsensors 3.x in openSuse 11.1.

> > But if not, .26 is around the corner and requiring libsensors-3.0 must 
> > really not be.
> 
> I agree that requiring libsensors-3.0.2 for this is not a good solution, but I 
> don't want to be crippling the kernel for what I believe is a bug in 2.10.x either.

Actually, requiring libsensors 3.0.2 wouldn't be such a bad solution.
libsensors 2.10.x lacks support for many new devices. It also needs
libsysfs, which most distributions are trying to get rid of.

You can't at the same time upgrade to the latest kernel and expect
legacy branches of all user-space tools to keep working. Legacy means,
well, legacy. Mixing that with bleeding edge is asking for trouble.

> (...)
> 2) Fix this in the 2.10.x series (which are still supported) and do a new
>     2.10.x release.

In fact, it is already fixed. If you look carefully at:
http://www.lm-sensors.org/wiki/Download

You'll see that I maintain a list of recommended patches for the last
version of each branch of lm-sensors. For version 2.10.6, there are
currently 3 recommended patches, the first one being:
http://www.lm-sensors.org/changeset/5147

Which, you guess, fixes the problem reported by Rene.

So all we have to do is release lm-sensors 2.10.7 soon.

> 3) If this really completely messes 2.10.x and in that case I'm afraid we will
>     have to make kernel side changes.

No, the kernel does the right thing and does not need to be modified at
all.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

From: mhoffman@lightlink.com (Mark M. Hoffman)
Date: Thu, 27 Jul 2006 01:18:30 +0000
Subject: [lm-sensors] generic chip support in libsensors
Message-Id: <20060727011830.GB25291@jupiter.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <44C78622.8060808@hhs.nl>
In-Reply-To: <44C78622.8060808@hhs.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Hans, Rudolf:

* Hans de Goede <j.w.r.degoede at hhs.nl> [2006-07-26 17:11:30 +0200]:
> >> I was thinking about doing things differently with regards to userspace.
> >> As I already posted to the list I'm working on a driver for the uGuru2.
> >> The driver is done (waiting for feedback from testers) but I still need
> >> todo userspace. Since the uGuru2 driver is going to be 2.6 only and
> >> since 2.6 has a clear API/ABI between userspace and the kernel for hwmon
> >> chips I was thinking about adding code to libsensors for generic 2.6
> >> support. The idea is to write a piece of code which will come into
> >> action only if libsensors doesn't have a chip definition for a found
> >> chip and libsensors is running on a  2.6 kernel. This piece of code
> >> would then fill a dynamicly allocated structure describing the unknown
> >> chip, using the same structure as for known chips.

> Rudolf Marek wrote:
> > Yes this is in long term plan.

In fact, Jean Delvare & I discussed just how we would like to do this
at OLS.  It is long overdue.

> I know it has been the long term plan for a while, my suggestion is to
> write an intermediate solution for the short term (say within a couple
> of weeks) this short term solution would only kick into action for new
> chip drivers (like your k8 temp driver) leaving the behaviour unchanged
> for chips currently already supported by libsensors (although the 2.6
> only ones may be removed after thorough testing making libsensors smaller).

That sounds great.  But, generic chip/feature discovery was not the first
thing on the plan.  It turns out that libsysfs is getting yanked from a
lot of distros and so that part should be reworked first.  Are you
interested in taking that on?  Apparently, libsysfs was recently written
*out* of udev... we should see what they're doing instead.

I will let Jean reproduce the rest of the plan here from his notes.

> >> Does this sound like a plan With this in place we no longer need to
> >> write support for every new 2.6 hwmon driver, actually if this goes in I
> >> would like to see explicit support for the uGuru (1) be removed, since
> >> this generic code should do just as good of a job.
> > 
> > Yes.
> > 
> > There are still questions if to rewrite the libsensors and allow LGPL or
> > change libsensors to what you propose.

This was never really a question in my mind.  I recognize that we've been
asked for a LGPL library in the past... too bad for them.  I'm not going to
take on the job of rewriting *all* of libsensors just to accomodate a license
change.  I think that I've brought Jean around to the same thinking.

> I know, what I propose is not to wait for a decission but instead add
> support for unknown 2.6 driven chips to libsensors, leaving things as is
> for already supported chips. This way we no longer need to update
> libsensors each time a new 2.6 driver is added. I've been planning to
> write a patch for this evolutionary change for a while now. But first I
> would like to see some people backing the concept, I don't like writing
> code with 0%chance of getting it integrated upstream.

I will back you.  The fear of what a huge task it would be to rewrite
it has prevented us from simply maintaining it.  I've been saying that
we should evolve it instead of rewriting it for some time now.  I've
tried to improve the code every time I touch it... although I guess the
libsysfs stuff I did turns out to be short-lived.

Thanks & regards,

-- 
Mark M. Hoffman
mhoffman at lightlink.com



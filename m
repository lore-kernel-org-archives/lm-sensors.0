From: Phil Pokorny <ppokorny@penguincomputing.com>
Date: Tue, 13 Oct 2015 21:05:56 +0000
Subject: Re: [lm-sensors] [PATCH 1/1] Bumps limit of maximum core ID from 32 to 128.
Message-Id: <CAAek22GTG6o0QYU_WUJaASafk_Gfv03y_x056tiGtzz=w41yOg@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1444650812-17398-1-git-send-email-lukasz.odzioba@intel.com>
	<20151013203134.GA28106@roeck-us.net>
In-Reply-To: <20151013203134.GA28106@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guenter Roeck <linux@roeck-us.net>
Cc: Lukasz Odzioba <lukasz.odzioba@intel.com>, fenghua.yu@intel.com, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>

On Tue, Oct 13, 2015 at 1:31 PM, Guenter Roeck <linux@roeck-us.net> wrote:
>
> On Mon, Oct 12, 2015 at 01:53:32PM +0200, Lukasz Odzioba wrote:
> > A new limit selected arbitrarily as power of two greater than
> > required minimum for Xeon Phi processor.

> Why 128 instead of a more reasonable 64 ? What is the required minimum
> for Xeon Phi ?

Not meaning to be snarky, but this was answered in the first sentence.
64 is less than the required minimum for Xeon Phi processor.  So it
must be 65 or greater...

I wouldn't expect Intel to give you any more detail than that.  And it
might be that 64 is actually enough for now but would soon (months or
less than a year) be overrun by a newer processor.  So rather than
submit multiple minor patches, just submit one now that should be
"enough"

If you think this is a waste of RAM, we could make it a kernel
configuration option and let it be configured by the distro or user.
But if most distros select 128 to be able to support Xeon Phi, then
there might not be a reason for the additional complexity.

Phil P.

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

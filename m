From: khali@linux-fr.org (Jean Delvare)
Date: Sun, 04 Sep 2005 13:29:13 +0000
Subject: [lm-sensors] Re: RFC PATCH patch-13-mm1-hwmon-adm9240-whitespace-1
Message-Id: <20050904132909.1d64ff84.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <uvhkh19nggg4s7rv03ab6tetdu06jlmk42@4ax.com>
In-Reply-To: <uvhkh19nggg4s7rv03ab6tetdu06jlmk42@4ax.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Grant,

> > > Patches are planned to make chassis_clear write data > > > <dont_care>,
> >
> > With what benefit?
>
> linux-kernel will be one source line smaller :-p

I don't think so, unless you would accept the idea that writing 0 to
that file would clear the chassis intrusion info too. That would be
rather confusing, don't you think?

> Not sure, don't have to do that.  The recent sysfs breakage made
> me wonder if we should use the write to chassis_clear, ignoring
> the data.

I don't know what sysfs breakage you are talking about, but I don't see
how this would be related to accepting other values than 1 to be written
to a given file. Please don't mix up unrelated problems.

> > Are you referring to Yani Ioannou's dynamic sysfs callbacks? That
> > would be very welcome, thanks for looking into that.
> 
> Yes, it finally seems to have settled some?

Yes it has. There are 6 drivers converted already (lm63, lm83, lm90,
it87, adm1026 and w83792d) and one more in the works (pc87360.)
Considering the size shrink and code readability improvement that was
obtained each time, converting more drivers is very welcome.

> Okay, here's take two.
> (...)
> This patch breaks long lines, removed a trailing space and is code 
> neutral.  Further patches are planned which will apply after this 
> cleanup.  Run tested.

Looks fine to me, I've applied it. Greg, please push this patch on your
own i2c stack.

-- 
Jean Delvare

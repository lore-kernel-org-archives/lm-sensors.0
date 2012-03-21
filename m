From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Wed, 21 Mar 2012 18:07:23 +0000
Subject: Re: [lm-sensors] [GIT PULL] hwmon updates for 3.4
Message-Id: <1332353243.32717.207.camel@groeck-laptop>
List-Id: <lm-sensors.vger.kernel.org>
References: <20120320162358.GA5189@ericsson.com>
	 <CA+55aFzEQ-undQpx_Q_5+scP5EN9KxJ9m-1O-8O0h+EbZE2mMw@mail.gmail.com>
In-Reply-To: <CA+55aFzEQ-undQpx_Q_5+scP5EN9KxJ9m-1O-8O0h+EbZE2mMw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>

On Wed, 2012-03-21 at 13:40 -0400, Linus Torvalds wrote:
> On Tue, Mar 20, 2012 at 9:23 AM, Guenter Roeck
> <guenter.roeck@ericsson.com> wrote:
> >
> > Please pull hwmon updates for Linux 3.4 from tag:
> >
> >    git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-for-linus
> >
> > Mostly cleanup. No new drivers this time around, but support for several chips
> > added to existing drivers: TPS40400, TPS40422, MTD040, MAX34446, ZL9101M,
> > ZL9117M, and LM96080. Also added watchdog support for SCH56xx, plus additional
> > sysfs attributes for a couple of drivers.
> 
> Btw, please don't put that "git log --oneline" generated data into the
> tag - there's no real point. It doesn't add anything human-readable to
> anything, and for any automation you can get the data better directly
> from git instead.
> 
> So the tag-message shouldn't contain anything auto-generated, since
> any auto-generated data is better just generated later on the fly.
> Just do the human-readable "this is the high-level overview of that
> the pull request contains" into the tag message.
> 
>                        Linus

Ok. Sorry for the noise, and thanks for pulling the changes.

Guenter



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

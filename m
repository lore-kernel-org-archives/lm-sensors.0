From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 21 Mar 2012 17:40:32 +0000
Subject: Re: [lm-sensors] [GIT PULL] hwmon updates for 3.4
Message-Id: <CA+55aFzEQ-undQpx_Q_5+scP5EN9KxJ9m-1O-8O0h+EbZE2mMw@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20120320162358.GA5189@ericsson.com>
In-Reply-To: <20120320162358.GA5189@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Guenter Roeck <guenter.roeck@ericsson.com>
Cc: linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org

On Tue, Mar 20, 2012 at 9:23 AM, Guenter Roeck
<guenter.roeck@ericsson.com> wrote:
>
> Please pull hwmon updates for Linux 3.4 from tag:
>
> =A0 =A0git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging=
.git hwmon-for-linus
>
> Mostly cleanup. No new drivers this time around, but support for several =
chips
> added to existing drivers: TPS40400, TPS40422, MTD040, MAX34446, ZL9101M,
> ZL9117M, and LM96080. Also added watchdog support for SCH56xx, plus addit=
ional
> sysfs attributes for a couple of drivers.

Btw, please don't put that "git log --oneline" generated data into the
tag - there's no real point. It doesn't add anything human-readable to
anything, and for any automation you can get the data better directly
from git instead.

So the tag-message shouldn't contain anything auto-generated, since
any auto-generated data is better just generated later on the fly.
Just do the human-readable "this is the high-level overview of that
the pull request contains" into the tag message.

                       Linus

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

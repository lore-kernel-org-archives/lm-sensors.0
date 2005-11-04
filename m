From: james.oden@gmail.com (James Olin Oden)
Date: Fri, 04 Nov 2005 17:44:22 +0000
Subject: [lm-sensors] Re: [PATCH] lm93 driver for 2.6
Message-Id: <ac921f990511040843s59310169wfaf47a2ed5fa4ffa@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20051028182339.23792.qmail@desitka.sh.cvut.cz>
In-Reply-To: <20051028182339.23792.qmail@desitka.sh.cvut.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 04 Nov 2005 09:17:52 -0700, Eric J. Bowersox <ericb@aspsys.com> wrote:
> On Thu, 2005-11-03 at 22:30, Mark M. Hoffman wrote:
> > > We also need someone to test this code in deep, on a real LM93 chip,
> > > before we can put this in Linux 2.6.
> >
> > I imagine Eric did that?  Otherwise why would he port it?  Would it be
> > enough if I reviewed it closely?
>
> When we ported the driver, I tested it enough to verify that we were
> getting good (i.e. not-nonsensical) voltage, fan speed, and temperature
> readings from it on the motherboard in question (Supermicro X6DHP).
> Unfortunately, the machines that I tested that driver on have long since
> been shipped to the customer that paid for them, and I don't know if we
> have any others in house.  I also haven't been able to pay as much
> attention to this driver as I might have wanted to, because, as (now)
> the only professional software engineer here, my time gets pulled in all
> kinds of directions...
>
>                                        Eric
>
We have have plenty of machines with lm93 chips in them at Tekelec,
but presently we are using a 2.4 kernel.  I can talk to Dave about
trying to test with the new driver on a 2.6 kernel on these machines. 
 Eventually we will be migrating to 2.6 in the not so far future, but
right now we are trying to tidy up our 2.4 based stuff.
So eventually it will get tested, but maybe (and I don't know this
now) we can get too it sooner rather than later.

Also, Mark is correct.  We went through the lm93 spec decided what we
really needed, sent this as requirements to Mark.  There were a couple
cycles of negotiated what we really needed as Mark beat lovingly with
a clue bat (-;  In the end I think we use almost all of the
functionality.

In particular the tables for ramping up fan speeds is a pretty
fabulous feature, but is probably way to complex for the average users
needs.  In a Telco environment where it seems to fit well.

Cheers...james

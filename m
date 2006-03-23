From: david.c.hubbard@gmail.com (David Hubbard)
Date: Thu, 23 Mar 2006 23:09:55 +0000
Subject: [lm-sensors] [PATCH] Add voltage support to W83627EHF
Message-Id: <4dfa50520603231509g92fb2bt6806ec1f7b835a9@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <4409700D.8010604@sh.cvut.cz>
In-Reply-To: <4409700D.8010604@sh.cvut.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Rudolf,

Oops, re-post and send to the list!

On 3/23/06, Rudolf Marek <r.marek at sh.cvut.cz> wrote:
> Hi David,
>
> I finally got some time to look continue with this. Many thanks for looking into this stuff.
>
> Please feel free to continue with this automatic fan stuff. It seems that you have time that I dont have
> right now. Usually I come from work at 9pm and after 12 hours of other work is quite hard to continue here.

> Well Jean did already some work today to support the alarms.
> I'm attaching the driver with all patches applied except the automatic fan which is in separate patch.

...

> Uff better to post a file for me, see the w83627ehf.c, which has all patches on the top and is in sync with 2.6.16 + all neccessary stuff.

Okay, I'll look at this one, thanks for send the file!

> Please fix it and prepare it for kernel inclusion/review. Of course you will get credit for this.
> Let me know if you will do the EHF doc too. If not I can try to handle this while in train back to hometown.

I can document the code, though I'd appreciate your help too!

> >
> > I'm also attaching a regression test script for the w83627ehf driver.
> > This is what I used to test the driver on my machine. I found only two
> > issues:
>
> WOW I think we need such test. Have you some methodology for the test construction please?

Well, it's just a shell script... although I think several parts are
still missing. Such as, how to test voltage / VID values for
correctness? Some CPUs can be underclocked / undervolted, which would
at least provide a simple test for these inputs. If this is useful,
then that's great!

> > First, pwmN_mode sets PWM or DC mode. In the datasheet, the bit is
> > 0->PWM and 1->DC but the comment in the driver says 1->PWM and 0->DC.
> > That's how w83792d.c does it too. So right now, the hardware behavior
> > is backward, relative to what's "standard" between the drivers. I
> > think the solution is to invert the bit in store_pwm_mode(), so that
> > 1->PWM (written as a 0) and 0->DC (written as a 1).
>
> Yes this is correct W83792D has it vice versa. Please fix that.

OK

- David


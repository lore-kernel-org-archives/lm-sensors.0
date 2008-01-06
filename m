From: "Juerg Haefliger" <juergh@gmail.com>
Date: Sun, 06 Jan 2008 07:40:50 +0000
Subject: Re: [lm-sensors] auto_pwm_min in dme1737 driver
Message-Id: <191fb4ca0801052340q588589e3hf5c8436404fe45d3@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <191fb4ca0712191022i313516d2t759f71a95e561ff1@mail.gmail.com>
In-Reply-To: <191fb4ca0712191022i313516d2t759f71a95e561ff1@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean,

On Jan 5, 2008 5:51 PM, Jean Delvare <khali@linux-fr.org> wrote:
> On Thu, 20 Dec 2007 10:50:15 -0800, Juerg Haefliger wrote:
> > On Dec 19, 2007 4:35 PM, Michel Lespinasse <walken@zoy.org> wrote:
> > > Oh, and I just found another small issue. This one is in the driver.
> > > # echo 0 > fan1_min
> > > saloon kernel: divide error: 0000 [1]
> > > I guess the divide error is in the FAN_TO_REG macro...
> >
> > Good catch. Thanks, will fix.
>
> Juerg, do you have a patch for this by now?

Yes but I don't have access to my testing machine before the end of
the month. I'll submit when I'm back from vacation.

...juerg


> Thanks,
> --
> Jean Delvare
>

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

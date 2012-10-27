From: Guenter Roeck <linux@roeck-us.net>
Date: Sat, 27 Oct 2012 15:57:04 +0000
Subject: Re: [lm-sensors] Asus P7F-X w/ W83667HG-B pwm control problem
Message-Id: <20121027155704.GA25272@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <CABkW7JOH6quu8kc56=Qm4+3ewqvtcpo7RsQKyYDyFtLd3_1pkw@mail.gmail.com>
In-Reply-To: <CABkW7JOH6quu8kc56=Qm4+3ewqvtcpo7RsQKyYDyFtLd3_1pkw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Fri, Oct 26, 2012 at 10:48:09PM -0700, camden lindsay wrote:
> >
> > Please download and install the driver from
> > https://github.com/groeck/w83627ehf.
> > This is an experimental version which adds a couple of new features and,
> > specifically for you chip, a missing fan control mode. If we are lucky that
> > might solve your problem.
> >
> > Thanks,
> > Guenter
> >
> 
> 
> Thank you, Guenter.
> No the fans never seemed to change speed with load or cpu use, or for that
> matter temperature- although i'm in a pretty cold environment and don't
> ever really see more than 30c on the chips.
> 
You woud have to bring the load up to 100% for some time, and the CPU
temperature as well, to see the fan speeds change. At 30c nothing is going to
happen with the fans.

> The newer driver does indeed allow _some_ control of the fans! - albeit
> with slightly odd results;
> All case fans and CPU fans seem to hang off of one output, but the cpu fan
> does not stop when 0 is entered, while the other fans do.
> 
That the CPU fan does not stop is quite normal. Apparently many CPU fans operate
that way.

> pwm1 and pwm3 have control of none of the fans plugged into the board
> 
It appears that the board designers connected all fans to the same pwm output.
Odd, but there is really no other explanation (or I don't have one).

The initial pwm_enable value if "5" means that the fan control system is in
"SmartFan IV" mode, meaning it performs automatic fan control. That mode is
controlled with a separate register and overrides all other settings, meaning
the earlier code never really changed the fan control mode at all. Which
explains why you could not set the pwm values.

Apparently, in SmartFan IV mode, you can not read the current pwm value
with that chip.

Overall I would recommend not to touch the fan control at all and leave pwmX_enable
at 5. This lets the chip handle fan control, which is better than you can ever do
manually.

One other question: Can you change pwmX_enable back to 5, and do the fan speeds
revert to the original speed if you do that ?

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

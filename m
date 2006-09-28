From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 28 Sep 2006 19:59:13 +0000
Subject: [lm-sensors] it8718 under 2.6
Message-Id: <20060928215913.65ed4a4f.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20060824170520.ad92a6de.khali@linux-fr.org>
In-Reply-To: <20060824170520.ad92a6de.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Shane,

> > Please go to the BIOS setup screen and write down everything it says
> > about voltages, fans and temperatures (labels and values, in order.)
> > Then report this list here, together with the output of "sensors"
> > without a configuration file (either delete it, or run "sensors
> > -c /dev/null"). I'll help you come up with a working configuration file
> > for your board.
> 
> Unfortunately, the bios health status screen on the dq6 is
> less than helpful.  The temps do get reported, around 34c
> for cpu and 40c for case temp.  Those are idle though so
> would differ when the system comes up.  I believe temp2 is
> cpu though going by load tests.  The voltages aren't being
> reported in the bios at all but just get reported as ok. 
> Those coming out of sensors look rather close save for 12v.

Even without values, the voltage info in the BIOS is valuable, because
it tells you which voltage lines are monitored, and most likely in
which order. Which is why I was asking you to report it all here.

If you want me to help you with the +12V, please provide the
information I asked for:
* Voltage labels in the BIOS, in order.
* Output of "sensors -c /dev/null".

> > Oh, the driver is also trying to help with messages in the logs when
> > you load it. Please report these messages.
> 
> it87: Found IT8718F chip at 0x290, revision 1
> it87: in3 is VCC (+5V)
> it87: fan4 is enabled
> it87: fan5 is enabled

This means that in3 is +5V for sure, which is a good thing to know.

> > > Also, fan 4 and fan 5 aren't shown in the sensors output.
> > 
> > I have not seen a board using these yet, so I didn't bother adding
> > support. I could add it if you need it. What do you offer?
> 
> Yeah, I don't think this board is enabling that either as
> only three are shown in the bios.

A possibly more relevant question is: are there more than three fan
headers on this motherboard?

I would appreciate if you could post the configuration file you have
come up with (only the it8718-* section please) so that I can add it to
our default configuration file.

-- 
Jean Delvare


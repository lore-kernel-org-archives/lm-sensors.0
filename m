From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:57 +0000
Subject: RFC parameter based voltage scaling
Message-Id: <RPaRl8wR.1115645736.3506290.khali@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <rl8u711rq5bc1e1jtt91s76fed180ctoav@4ax.com>
In-Reply-To: <rl8u711rq5bc1e1jtt91s76fed180ctoav@4ax.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi Grant,

> I've written fixed point math routines in bash to prove the concept,
> but if driver scaling has been vetoed, I'd rather know now than
> submit something unwanted.  lm87 driver almost has it, carrying
> scaling factors in private memory, loaded at chip detect time.

The rule is: drivers should provide the voltages as seen at their pins.
This means that, where scaling is external, it has to be done in
user-space, while where scaling is internal, it has to be done by the
driver itself. All drivers respect that rule as far as I remember.

> * Winbond inX internal scaling -- fullscale is 4096mV, Vref is 3600mV
> *
> * These sensor chips perform internal scaling for 5V (in3) and 5VSB

I don't think so. Can you point us to a datasheet stating this?

> Comments?

Your code makes sense for external resistors, but not for internal
scaling as far as I can see, so it won't be of any help in the drivers.
And libsensors mostly works the way you describe already, just not in as
formal a way (because compute lines were meant for all values, not just
voltages).

So all in all I think that you are trying to fix a problem that doesn't
exist in the first place, sorry.

--
Jean Delvare

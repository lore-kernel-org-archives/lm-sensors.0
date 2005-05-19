From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:57 +0000
Subject: bmc and fan speed control
Message-Id: <20050510212743.58430e51.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <427FF313.7070202@mds.gotdns.com>
In-Reply-To: <427FF313.7070202@mds.gotdns.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Aj,

> >Hi Al,
>
> AJ :-)

Oops, sorry ;-)

> You are right, I shouldn't type chip names from memory! I meant I
> think  the ADM1026 does the fan speed control for the Intel SHG2
> motherboard.  Notice on page 30 of the SHG2  Technical Product
> Specification it says  pin 18 of the ADM1026 is "PWM" : "Pulse width
> modulation of fan speed".

True. If memory serves, it is also possible to use DC fan control on
that same pin (I think).

> Now my question is, is it feasible to control the fan speed on an
> Intel  SHG2 motherboard from Linux?

If the motherboard is properly wired for fan control operation, that
should work, as the adm1026 driver has support for this. Your best
chance is to try simply the adm1026 driver and see how it goes.

-- 
Jean Delvare

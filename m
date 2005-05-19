From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:40 +0000
Subject: [RFT] Preliminary w83627ehf hardware monitoring driver
Message-Id: <BIe4VCVx.1109588428.5008080.khali@localhost>
List-Id: <lm-sensors.vger.kernel.org>
In-Reply-To: <20050228075012.GN25818@edu.joroinen.fi>
References: <20050226191142.6288b2ef.khali@linux-fr.org>
In-Reply-To: <20050226191142.6288b2ef.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: pasik@iki.fi
Cc: LM Sensors <sensors@Stimpy.netroedge.com>, LKML <linux-kernel@vger.kernel.org>


Hi Pasi,

> > Have you tried w83627hf_wdt? I took a quick look at the W83627HF and
> > W83627THF datasheets and watchdog timer seems to work identically. Since
> > the driver doesn't seem to identify the chip (it probably should, BTW),
> > I'd expect it to work.
>
> Yes, I have tried it. It doesn't work.
>
> The machine reboots always after the watchdog timeout set in the BIOS. I've
> tried with the example watchdog daemon from the watchdog.txt, and with the
> Debian "watchdog" package.
>
> When I enable the debug messages and logging in the Debian watchdog
> package, I can see that the watchdog daemon gets stuck while trying to
> update the /dev/watchdog.. so the driver hangs..

I am not familiar with watchdogs. I'd invite you to get in touch with
the author and/or maintainer of the w83627hf_wdt driver, or possibly try
to debug it yourself. Datasheets are freely available from Winbond for
both the W83627HF and W83627THF:
  http://www.winbond.com/e-winbondhtm/partner/b_2_d_2.htm

I do not own a system with either chip myself, so I can hardly help. (If
anyone wants to donate a system with either chip so that I can work on
this, just contact me.)

--
Jean Delvare

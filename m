From: Luca Tettamanti <kronos.it@gmail.com>
Date: Sun, 24 Oct 2010 21:42:28 +0000
Subject: Re: [lm-sensors] Discrepancy between reported readings from
Message-Id: <AANLkTi=MMhXPsZQEX4dLbV-JGFy5wxbdU64HnzfmB_FV@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <AANLkTik8hx=ej8V7ti_=izz0u+daOxxy5PmBjX0ZQv8W@mail.gmail.com>
In-Reply-To: <AANLkTik8hx=ej8V7ti_=izz0u+daOxxy5PmBjX0ZQv8W@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: lm-sensors@vger.kernel.org

On Sun, Oct 24, 2010 at 11:27 PM, Arun Raghavan <arraghav@gmail.com> wrote:
> Hi,
>
> Thanks for the quick response and the links. I'm not sure I understand
> exactly how to proceed or how to interpret your point about coretemp
> being relative to Tjmax. I see the coretemp value increasing with
> activity, implying the reading is greater the hotter it gets. If it
> were a delta from Tjmax, I would expect it to decrease?

Tjmax is the upper limit at which the CPU forces the throttling
(AFAIK). The exact value varies between CPUs, in you case it should be
101°C; the DTS reports a negative value (or rather a positive margin)
relative to TjMax, the driver converts it to an absolute temperature.
Tabs = TjMax - Tdts

> I also have thermometers probing across the heat sink and they seem to
> match the coretemp readings at idle (of course, when the CPU heats up,
> the package temperature is hotter than the heatsink probe detects).
> Should I just trust the coretemp readings to a reasonable
> approximation?

I should be :) For some desktop CPU the exact value for TjMax is not
known and is assumed to be 100°C; in this case the driver emits a
warning in the log.

Luca

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

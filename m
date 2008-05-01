From: "Juerg Haefliger" <juergh@gmail.com>
Date: Thu, 01 May 2008 18:08:20 +0000
Subject: Re: [lm-sensors] VIA VT1211
Message-Id: <191fb4ca0805011108re66d530pd88de57ca2ec6a5e@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <eeb7df810804250151n93dcd2ds5112e8cf9c5e199e@mail.gmail.com>
In-Reply-To: <eeb7df810804250151n93dcd2ds5112e8cf9c5e199e@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi Alessandro,


> 2008/5/1 Juerg Haefliger <juergh@gmail.com>:
>  > Hi Alessandro,
>
>  Hi Juerg,
>
>
>  >  Hmm... Not very useful at the moment. I'm curious to see if anything
>  >  good ever comes out of it. VIA is notoriously tight lipped about their
>  >  stuff...
>
>  I don't understand such behaviours. VIA should be glad to provide
>  specs for the development of the drivers for their hardware...

Let's not go there. Unfortunately, some companies are like that and
dillusional about the importance and significance of their IP :-)


>  >  >  It seems like there are three models of C7-D CPU's: C7-D Model A
>  >  >  (1.5/2 GHz) and model D (1.5 Ghz) don't support PowerSaver, C7-D M=
odel
>  >  >  D (1.8/2 GHz) support PowerSaver (P-States P0-P1). I own a "Model =
A"
>  >  >  C7-D.
>
>  >  OK, not good I guess.
>
>  Well, this is the problem: I would like to read CPU temperature so I
>  can handle the case ventilation (I've installed a fanbus which allow
>  me to manually change the fan speed). Internal temperature stalls
>  around 50 =B0C and the CPU temperature is always higher than the
>  internal temperature. With frequency/voltage modulation I would make
>  my CPU get little colder.

I understand. I still think we can get there.


>  However I tried to update the BIOS (as suggested on the kernel's
>  bugzilla) but the VIA Flash application corrupted my BIOS and now I'm
>  forced to change motherboard (I should get the replacement tomorrow).
>  Maybe I will not get the same motherboard.

Hmm... Happened to me too on a EPIA board. Fortunately I have access
to a programmer and could reprogram the BIOS externally.


>  BTW the comments about temperature calculation in the
>  /etc/sensors3.conf don't contain a formula for the C7 CPU and surely
>  I'm about to get a different motherboard with the same CPU (maybe a
>  different model so I can use e_powersaver). So the problem still is
>  there: how can I get the offset and scale parameters for calculating
>  the CPU temperature? Is there a method which doesn't imply to use
>  frequency scaling?

Not unless you're willing to drill a hole in your CPU heatsink and
stick a thermal probe on the case of the CPU and calculate your way
back to the die temp.


>  >  It also seems to be able to throttle the CPU when it gets hot. Maybe
>  >  you can play around with those parameters and set the temp threshold
>  >  low so that it always throttles. Page 54 of the manual also shows some
>  >  BIOS settings for CPU clock and ratio. Have you played with those?
>
>  Yes, I read it. Unfortunately the manual is very criptic about that
>  and doesn't explain how it does work. I played with those settings but
>  then I were unable to know if it worked or not (cpufreq-info doesn't
>  work and lm-sensors have always shown the VID voltage around 1.2V).

Can you send me the current settings from the 'Thermal Management'
page (pg 33 in the manual) and the 'Frequency/Voltage control' page
(pg 54)? I believe you have the knobs to run the CPU at different
frequencies.

Btw I asked my contact at VIA for the datasheet of the C7 CPU. He's
trying to get it for me.

...juerg


>  >  ...juerg
>
>  Bye, Alessandro.
>

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

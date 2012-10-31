From: Alejandro Jakubi <jakubi@df.uba.ar>
Date: Wed, 31 Oct 2012 02:18:00 +0000
Subject: Re: [lm-sensors] high value for CPUTIN
Message-Id: <alpine.DEB.2.02.1210302315430.3444@cosmos>
List-Id: <lm-sensors.vger.kernel.org>
References: <alpine.DEB.2.02.1210290159070.3309@cosmos>
In-Reply-To: <alpine.DEB.2.02.1210290159070.3309@cosmos>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> No. Problem is that PECI does not report an absolute temperature, but the
> difference to Tjmax, which is the maximum CPU temperature (reported as critical
> temperature by coretemp). The NCT6776F has a register which needs to be programmed
> to that value. Usually that is done in the BIOS. Looks like the BIOS did not
> program the correct value on your board.

I see. However, if this NCT6776F register were wrongly programed, it seems
to me like there should be a systematic error in the reported temperature.
However, this is not what I am observing. For instance, the value of PECI 0 in
my first post (showing the complete output) was 33.5C, with all the other
temperatures (except CPUTIN) in a close range. Now its value is about 30C (+/-
1C, I am following it with xsensors), again in close agreement with the other
readings.

So, it seems to me like something else caused yesterday that PECI 0 had
reported a value over 10C below "normal". Two things come to my mind: an
erratic failure of this device, or that previously to the reported low
reading, I had booted to Win 7 and installed SpeedFan 4.47 (as a check about
the high value reported for the CPU).

I will keep looking at the PECI 0 value as summer comes here shortly...

In any case, are the values reported by Core 0 to 3 more reliable?

Alejandro



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

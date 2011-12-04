From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 04 Dec 2011 10:03:45 +0000
Subject: Re: [lm-sensors] pwmconfig/fancontrol error (version 3.3.1)
Message-Id: <20111204110345.4665a150@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <4EDA21A1.6060301@catcons.co.uk>
In-Reply-To: <4EDA21A1.6060301@catcons.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Charles,

Please keep the list CC'd.

On Sun, 04 Dec 2011 12:29:34 +0530, Charles wrote:
> On 04/12/11 01:44, Jean Delvare wrote:
> > I finally gave it a try myself. Please fetch:
> > http://khali.linux-fr.org/devel/misc/fancontrol
> > and give it a try, it should work OK with multiple fans controlled by
> > one PWM output.
> 
> Thanks Jean ::)
> 
> Tested; no error messages and GKrellM shows sane processor core
> temperatures and fan speeds.
> 
> Sorry for the incomplete initial report:
> * I had applied the suggested workaround (thanks Jean and Guenter).

Hmm. Please test the updated version of the script _without_ the
workaround applied. That's the whole point of the update.

> * Connecting the case exahust fan to CPU_FAN is not an option because
> pwmconfig does not control it then, although it can control the stock
> Intel fan on the same header (subject to the ~1100 RPM minimum).

Most likely because the CPU fan header is a 4-pin header, and the Intel
CPU fan has 4 wires, while the case fan headers are 3-pin with a 3-wire
fan.

On 4-pin headers, the PWM signal is separated from the power. So you
can't control a 3-wire fan plugged in a 4-pin header (the PWM signal is
on the unconnected pin [1].) This also explains the minimum speed of
4-wire PWM-controlled fans. This is per design. If the minimum speed
doesn't please you, you have to either buy a different fan with a lower
minimum, or lower the fan voltage using a serial resistor (Noctua
amongst several other fan vendors includes such resistors in many of
their product packages.)

[1] Some boards have jumpers that will let you turn a 4-pin fan header
into a 3-pin one. You loose the benefits of 4-wire fans (such as linear
fan speed control and reliable readings at low speed) but are no longer
affected by the arbitrary fan minimum then.

> * PWR_FAN is not speed-controlled.
> 
> The present situation is not satisfactory (not an lm_sensors issue,
> reporting in case someone in a similar situation finds this) because the
> processor and case fans have very different signal/speed characteristics
> so, for example, the processor fan runs at 1400 while the case runs at
> 700 and the case exhaust air is warmer than ideal.

Indeed, it is only recommended to connect similar fans to the same
control output. There's a reason why board makers often connect the
case fans together, but usually have a separate fan control for the
CPU(s).

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

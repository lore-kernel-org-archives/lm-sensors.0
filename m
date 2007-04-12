From: "Juerg Haefliger" <juergh@gmail.com>
Date: Thu, 12 Apr 2007 22:57:14 +0000
Subject: Re: [lm-sensors] [PATCH 2/2 RESEND] hwmon: documentation for new
Message-Id: <191fb4ca0704121557o36a425c5mb6f12dbc2350de3a@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <191fb4ca0703220947s7e16453j4a5a7eb5eee77f1b@mail.gmail.com>
In-Reply-To: <191fb4ca0703220947s7e16453j4a5a7eb5eee77f1b@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean,

Thanks for the review, I appreciate it.


> > +Fan RPMs are measured with 16-bit resolution. The chip provides inputs for 6
> > +fan tachometers. All 6 inputs have an associated min limit which triggers an
> > +alarm when crossed. Fan inputs 1-4 provide type attributes that need to be set
> > +to the number of edges per fan revolution that the connected tachometer
> > +generates. Supported values are 2, 3, 5, and 9. Fan inputs 5-6 only support
> > +fans that generate 5 edges per revolution. Fan inputs 5-6 also provide a max
>
> I don't like this term "edges per revolution". It looks incorrect to
> me. The datasheet says that "five edges" correspond to "two pulses". I
> suspect that the 5th edge is needed to make sure we measured a full
> rotation of the fan (between 1st edge and 5th edge), but a standard
> 2-pulse-per-revolution (PPR) fan certainly only generates _4_ edges per
> revolution. (If not, someone really needs to explain to me where the
> mysterious 5th one comes from!)
>
> An easy test would be, change the value from 5 to 3, how does the
> reported fan speed change? I suspect it will be multiplied by exactly
> 2, not 5/3.
>
> The lm85 driver exports this value in PPR, and even though this isn't
> in our standard, I'd rather have the dme1737 driver do the same. 3
> edges would be 1 PPR, 5 edges would be 2 PPR and 9 edges would be 4
> PPR. I'm puzzled by the 2 edges option - how could a fan emit 1/2 PPR?
> Another mystery someone needs to explain to me.

You're correct. I just copied the terminology from the datasheet. Will
change it according to your suggestion.


> > +temp[1-3]_auto_point1_temp_hyst      RW      Auto PWM temp hyst point. This is the
>
> You could spell hysteresis in full here, to make it clearer.

OK.


> > +                                     temperature below which the associated
> > +                                     PWM output is set to 0% duty-cycle.
> > +temp[1-3]_auto_point2_temp_crit      RW      Auto PWM temp crit point. This is the
>
> And critical in full as well.

OK.


> > +pwm[5-6]_enable                      RO      Enable of PWM outputs 5-6. Always
> > +                                     returns 1 since these 2 outputs are
> > +                                     hard-wired to manual mode.
>
> Note that other drivers do not create the file in this case. It is
> assumed that PWM is always manual if pwmN exists and pwmN_enable
> doesn't.

I tried to make it consistent for this driver. If it breaks a common
standard I will remove these attributes.


> > +pmw[1-3]_ramp_rate           RW      Ramp rate of PWM output. Determines how
> > +                                     fast the PWM duty-cycle will change
> > +                                     when the PWM is in automatic mode.
> > +                                     Expressed in ms per PWM step size.
>
> s/step size/step/

Sorry, I don't get this.


> > +pwm[1-3]_auto_channels_temp  RW      PWM output to temp input mapping.
> > +                                     Supported values are:
> > +                                             1: temp1
> > +                                             2: temp2
> > +                                             4: temp3
> > +                                             6: highest of temp[2-3]
> > +                                             7: highest of temp[1-3]
>
> Might be good mentioning that it's a bitfield, in case the reader
> doesn't notice.

OK.

Regards
...juerg

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

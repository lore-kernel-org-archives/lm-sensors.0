From: Christopher Cordahi <christophercordahi@nanometrics.ca>
Date: Thu, 04 Sep 2014 03:19:40 +0000
Subject: Re: [lm-sensors] How to compute a voltage that may be positive or negative
Message-Id: <CAF_O4Jt8V307T_bObsRN03B4DOM3XP14k4FvG3m6HP5tn-1eVA@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <CAF_O4Js3aRF7iofSey0w+F8azTGbawX5vEe9cmHqybk9Qj=yvg@mail.gmail.com>
In-Reply-To: <CAF_O4Js3aRF7iofSey0w+F8azTGbawX5vEe9cmHqybk9Qj=yvg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> Well, 1.142 * 9.72340425532 - 9.95823902214 is 1.145. So I think the
> value is properly scaled, just it happens that for your specific value,
> the scaled value is almost the same as the original value, and that
> confused you.

Thank you very much Jean, that explains everything.

I was incorrectly assuming the hidden least significant digit was 0, i.e.
that the input was 1.140 V rather than 1.142 V, so I was expecting the
conversion to result in 1.13 (1.1264).

I should know better than to rely on tests performed on a Friday evening.

> The limited resolution of "sensors" admittedly does not help here, try
> "sensors -u" to see the 3rd digit.

With my sensors version 3.2.0, the -u option changes the output format, but
doesn't provide additional information.

# sensors --no-adapter ads1115-i2c-2-4a
ads1115-i2c-2-4a
in4:         -3.16 V
in5:         +0.70 V
in6:         +0.69 V

# sensors -u --no-adapter ads1115-i2c-2-4a
ads1115-i2c-2-4a
in4:
  in4_input: -3.16
in5:
  in5_input: 0.70
in6:
  in6_input: 0.69

I assume it is supposed to print the raw information obtained from /sys

# sensors --help | grep -- -u
  -u                    Raw output (debugging only)
# cat /sys/bus/i2c/devices/2-004a/in?_input
699
696
692

> Note that you have a wrong factor in the second half

Thanks for catching.  When I first read
http://www.lm-sensors.org/wiki/VoltageLabelsAndScaling I thought the value
was in mV, after using it, I correct its use in first half, but not the
second.


On Tue, Sep 2, 2014 at 4:34 AM, Jean Delvare <jdelvare@suse.de> wrote:

> Hi Christopher,
>
> On Fri, 22 Aug 2014 18:31:22 -0400, Christopher Cordahi wrote:
> > I'm wondering if this is a valid use case.  I need to perform both a
> > multiplication and a subtraction to compute an original voltage.
> >
> > lm sensors 3.2.0 is working fine on Linux 2.6.39.4 reading an ADS1115 ADC
> > chip that measures a voltage from 0 V to about 2 V.
> >
> > # uname -srmo
> > Linux 2.6.39.4 armv5tejl GNU/Linux
> > # sensors --version
> > sensors version 3.2.0 with libsensors version 3.2.0
> > # sensors --bus-list ads1115-i2c-2-4a
> > bus "i2c-2" "i2c-1-mux (chan_id 0)"
> > bus "i2c-1" "DaVinci I2C adapter"
> > # sensors --no-adapter ads1115-i2c-2-4a
> > ads1115-i2c-2-4a
> > in4:         +1.14 V
> > in5:         +1.14 V
> > in6:         +1.14 V
> >
> > My problem is that I'd like for the sensor utility to convert the ADC
> > voltages to the original voltage which are in the range from about -10 V
> to
> > about +10 V.
> >
> > If I modify the sensor configuration as follows, it appears to work
> > correctly.
> >
> > root@centaur-3_0009:~# tail -2 /etc/sensors3.conf
> > chip "ads1115-*"
> >     compute in4 @*10-10 , (@+10)*10
> > root@centaur-3_0009:~# sensors --no-adapter ads1115-i2c-2-4a
> > ads1115-i2c-2-4a
> > in4:         +1.41 V
> > in5:         +1.14 V
> > in6:         +1.14 V
> >
> > Unfortunately when I adjust the values to their more accurate values, it
> no
> > longer converts and reports the original ADC value instead.
>
> I tried but could not reproduce the bug here. I also looked at the
> source code and there is no arbitrary limit to the number of digits.
>
> > root@centaur-3_0009:~# tail -2 /etc/sensors3.conf
> > chip "ads1115-*"
> >      compute in4 @*9.72340425532-9.95823902214 ,
> > (@+9958.23902214)/9.72340425532
>
> Note that you have a wrong factor in the second half here, even though
> that's not related to your problem.
>
> > root@centaur-3_0009:~# sensors --no-adapter ads1115-i2c-2-4a
> > ads1115-i2c-2-4a
> > in4:         +1.14 V
> > in5:         +1.14 V
> > in6:         +1.14 V
>
> Well, 1.142 * 9.72340425532 - 9.95823902214 is 1.145. So I think the
> value is properly scaled, just it happens that for your specific value,
> the scaled value is almost the same as the original value, and that
> confused you.
>
> The limited resolution of "sensors" admittedly does not help here, try
> "sensors -u" to see the 3rd digit.
>
> --
> Jean Delvare
> http://jdelvare.nerim.net/wishlist.html
>



-- 
Chris
_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

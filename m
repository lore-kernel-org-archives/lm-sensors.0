From: Jean Delvare <jdelvare@suse.de>
Date: Thu, 04 Sep 2014 08:08:02 +0000
Subject: Re: [lm-sensors] How to compute a voltage that may be positive or negative
Message-Id: <20140904100802.38a74b5d@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <CAF_O4Js3aRF7iofSey0w+F8azTGbawX5vEe9cmHqybk9Qj=yvg@mail.gmail.com>
In-Reply-To: <CAF_O4Js3aRF7iofSey0w+F8azTGbawX5vEe9cmHqybk9Qj=yvg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Christopher,

On Wed, 3 Sep 2014 23:19:40 -0400, Christopher Cordahi wrote:
> > Well, 1.142 * 9.72340425532 - 9.95823902214 is 1.145. So I think the
> > value is properly scaled, just it happens that for your specific value,
> > the scaled value is almost the same as the original value, and that
> > confused you.
> 
> Thank you very much Jean, that explains everything.
> 
> I was incorrectly assuming the hidden least significant digit was 0, i.e.
> that the input was 1.140 V rather than 1.142 V, so I was expecting the
> conversion to result in 1.13 (1.1264).
> 
> I should know better than to rely on tests performed on a Friday evening.

;-) You're welcome.

> > The limited resolution of "sensors" admittedly does not help here, try
> > "sensors -u" to see the 3rd digit.
> 
> With my sensors version 3.2.0, the -u option changes the output format, but
> doesn't provide additional information.
> 
> # sensors --no-adapter ads1115-i2c-2-4a
> ads1115-i2c-2-4a
> in4:         -3.16 V
> in5:         +0.70 V
> in6:         +0.69 V
> 
> # sensors -u --no-adapter ads1115-i2c-2-4a
> ads1115-i2c-2-4a
> in4:
>   in4_input: -3.16
> in5:
>   in5_input: 0.70
> in6:
>   in6_input: 0.69
> 
> I assume it is supposed to print the raw information obtained from /sys

That's correct. But the 3rd decimal place was only added "recently" by:

------------------------------------------------------------------------
r5877 | khali | 2010-11-03 12:59:55 +0100 (mer. 03 nov. 2010) | 6 lignes

sensors: Display 3 decimal places in raw output.

This will make it easier for us to help users find out correct scaling
factors when needed. Instead of telling them to go read the raw sysfs
attributes, they can just report the output of "sensors -u -c /dev/null".

------------------------------------------------------------------------

so you'd need lm-sensors version >= 3.3.0.

> # sensors --help | grep -- -u
>   -u                    Raw output (debugging only)
> # cat /sys/bus/i2c/devices/2-004a/in?_input
> 699
> 696
> 692
> 
> > Note that you have a wrong factor in the second half
> 
> Thanks for catching.  When I first read
> http://www.lm-sensors.org/wiki/VoltageLabelsAndScaling I thought the value
> was in mV, after using it, I correct its use in first half, but not the
> second.

-- 
Jean Delvare
http://jdelvare.nerim.net/wishlist.html

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

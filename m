From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 29 Aug 2013 09:13:41 +0000
Subject: Re: [lm-sensors] Configuration file for ASUS P8H77-I motherboard
Message-Id: <20130829111341.6695acd2@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <CABFd1FYhZNcVNWK-Z-BDgsgAuJrKNQqp5sWNxpp0BB18khpq5g@mail.gmail.com>
In-Reply-To: <CABFd1FYhZNcVNWK-Z-BDgsgAuJrKNQqp5sWNxpp0BB18khpq5g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Victor,

On Thu, 29 Aug 2013 10:47:12 +0300, Victor Severov wrote:
> Hi all!
> 
> Here is my lm-sensors config file for Asus P8H77-I motherboard. This MB
> uses undocumented it8771e chip for voltage, temp and fan speed monitoring.
> 
> I hope this config may be useful to someone.
> Thank you.

I have added it to the wiki:
http://www.lm-sensors.org/wiki/Configurations/Asus/P8H77-I

Some comments :

> label in0 "Vcore"
> label in1 "Vram"
> label in2 "+12V"
> label in3 "+5V"
> label in4 "+3.3V"
> ignore in5
> ignore in6
> ignore in7

in7 is always VSB (+3.3V Stand-By) for this chip according to the
driver's source code, so it should be labelled as such, not ignored.
There's probably a note about this in the kernel logs when you load the
it87 driver.

> 
> compute in0 @+0.06, @-0.06

I've seen this a few times in the past but electrically it makes no
sense.

> compute in2 @*(72/12), @/(72/12)
> compute in3 @*(30/12), @/(30/12)
> compute in4 @*(1978/1200), @/(1978/1200)

I'm curious how you came up with this unusual scaling factor?

> set in0_min 0.92 * 0.90
> set in0_max 0.92 * 1.05

Modern CPUs tend to have variable voltage so the above makes little
sense. What CPU are you using?

> set in1_min 1.5*0.90
> set in1_max 1.5 * 1.05
> set in2_min 12.0 * 0.90
> set in2_max 12.0 * 1.05
> set in3_min 5.0 * 0.90
> set in3_max 5.0 * 1.05
> set in4_min 3.3 * 0.90
> set in4_max 3.3 * 1.05

The ATX specifications sets the limit to +/-5 % so all these * 0.90
should really be * 0.95 (or 0.94 if you want to take the resistor's
imperfection into account.)

> 
> label fan1 "CPU Fan"
> label fan2 "Chassis Fan"
> 
> label temp1 "CPU Temp"
> label temp2 "M/B Temp"
> ignore temp3

Thanks for your contribution.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

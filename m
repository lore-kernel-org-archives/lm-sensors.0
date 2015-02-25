From: Guenter Roeck <linux@roeck-us.net>
Date: Wed, 25 Feb 2015 14:51:29 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (gpio-fan) allow to use alarm support alone from DT
Message-Id: <54EDE171.7040403@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1424696334-14767-1-git-send-email-simon.guinot@sequanux.org>
 <54EB33D4.1000804@roeck-us.net> <20150223143416.GT1509@kw.sim.vm.gnt>
 <54EB3C84.30503@roeck-us.net> <20150225111430.GV1509@kw.sim.vm.gnt>
 <20150225135015.GA17992@lunn.ch>
In-Reply-To: <20150225135015.GA17992@lunn.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On 02/25/2015 05:50 AM, Andrew Lunn wrote:
>> Handle the GPIO fan alarm feature from the fan controller driver don't
>> look good either to me. This alarm mechanism is not a part of the fan
>> controller itself but rather something apart. Also I am afraid that the
>> result would really look like a hack.
>
> Hi Simon
>
> It sounds like you need to extract the alarm code from gpio-fan into a
> little library. Then put a wrapper around it to make a gpio-fan-alarm
> driver.
>

Please, the intend is to do the right thing, not to cause code bloat.

If it is in fact correct that the alarm mechanism in this case is not tied
to the fan controller, using the gpio-fan driver is ok. However, we need to
state and check in the code that _some_ property is mandatory. A driver with
only optional properties doesn't make sense.

Guenter


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

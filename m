From: Andrew Lunn <andrew@lunn.ch>
Date: Wed, 25 Feb 2015 13:50:15 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (gpio-fan) allow to use alarm support alone from DT
Message-Id: <20150225135015.GA17992@lunn.ch>
List-Id: <lm-sensors.vger.kernel.org>
References: <1424696334-14767-1-git-send-email-simon.guinot@sequanux.org>
 <54EB33D4.1000804@roeck-us.net>
 <20150223143416.GT1509@kw.sim.vm.gnt> <54EB3C84.30503@roeck-us.net>
 <20150225111430.GV1509@kw.sim.vm.gnt>
In-Reply-To: <20150225111430.GV1509@kw.sim.vm.gnt>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

> Handle the GPIO fan alarm feature from the fan controller driver don't
> look good either to me. This alarm mechanism is not a part of the fan
> controller itself but rather something apart. Also I am afraid that the
> result would really look like a hack.

Hi Simon

It sounds like you need to extract the alarm code from gpio-fan into a
little library. Then put a wrapper around it to make a gpio-fan-alarm
driver.

	Andrew

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

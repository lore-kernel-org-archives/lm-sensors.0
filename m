From: Andrew Lunn <andrew@lunn.ch>
Date: Wed, 25 Feb 2015 15:04:59 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (gpio-fan) allow to use alarm support alone from DT
Message-Id: <20150225150459.GE17992@lunn.ch>
List-Id: <lm-sensors.vger.kernel.org>
References: <1424696334-14767-1-git-send-email-simon.guinot@sequanux.org>
 <54EB33D4.1000804@roeck-us.net>
 <20150223143416.GT1509@kw.sim.vm.gnt> <54EB3C84.30503@roeck-us.net>
 <20150225111430.GV1509@kw.sim.vm.gnt>
 <20150225135015.GA17992@lunn.ch> <54EDE171.7040403@roeck-us.net>
In-Reply-To: <54EDE171.7040403@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

> However, we need to state and check in the code that _some_ property
> is mandatory. A driver with only optional properties doesn't make
> sense.

The patch to the binding documentation said:

Note: At least one the "gpios" and "alarm-gpios" properties should be set.

which i then suggested should be:

Note: At least one of "gpios" or "alarm-gpios" properties should be set.

What we could do is move this sentence into the Required Properties of
the documentation.

The patch Simon submitted also does check that this condition is
fulfilled.

	Andrew




_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

From: David Brownell <david-b@pacbell.net>
Date: Wed, 26 Sep 2007 16:28:45 +0000
Subject: Re: [lm-sensors] [patch 2.6.23-rc8 2/3] lm75: new style driver
Message-Id: <20070926162845.443CA239745@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <20070925051926.7349F23942D@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
In-Reply-To: <20070925051926.7349F23942D@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> >  - Save the original chip configuration, and restore it on exit.
> 
> I don't really see the value on this feature..

For one thing, it probably saves power:  in the typical case, the
chip isn't going to be doing constant ADC conversions when nobody's
there to watch it.

If you *want* it be active -- e.g. the overtemperature output is
driving a cooling fan -- then don't remove the driver.  It's not
normal with Linux to have devices running without the OS tending
them ... unless it the OS wasn't needed at all, and boot firmware
already set it up.  In which case this just restores what that
firmware set up, other than possibly the thermal limits.

- Dave


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

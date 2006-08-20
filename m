From: r.marek@sh.cvut.cz (Rudolf Marek)
Date: Sun, 20 Aug 2006 11:45:30 +0000
Subject: [lm-sensors] Tyan S2466N fan control help
Message-Id: <44E84B5A.1030204@sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <44CD6F57.3080001@gmail.com>
In-Reply-To: <44CD6F57.3080001@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jax,

> Is there anyone who can make it work with my motherboard or somethink
> like this from tyan?
> The problem not lm-sensors specific because I get the same with speedfan
> or motherboard monitor app in windows. I tryed to search but I go
> nowhere with google. Bios upgrade also impossible if it would be the
> problem, because tyan doesn't support this board anymore. The board has
> 6 fan connectors and I tried all but still the same results.

Perhaps they do not have PWM transitors connected so you cannot control the fan
speed.

If the fan speed measurements are zero, then you need to change something called
 "Fan divisor" Please check the sensors.conf file, find correct section and

set fan1_div 4

Add lines something like this (8 should be used for slower fans)

Then run sensors -s to apply the change.

As for the temps. 77 is a lot how do you cool it?

Regards
Rudolf


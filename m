From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:06 +0000
Subject: Third auto-fan control interface proposal
Message-Id: <20040725175521.33fc80b1.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <200407051449.i65Enjdq031467@zone3.gcu-squad.org>
In-Reply-To: <200407051449.i65Enjdq031467@zone3.gcu-squad.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Just noticed that I never anwsered this point:

> I don't see how this maps to it87 very well.
> In it87, just like the others, the temperature controls the fans,
> not vice versa. It's just that the pwm values are selected discretely.
> Your naming implied to me that the fan controls the temperature
> for it87??? confusing to me anyway.
> Shouldn't it87 use the same model as the others, with some additional
> entries if necessary?

The IT87xx does of course adapt fan speeds to the temperatures, not the
other way around (it a hardware monitor, not an oven ;)). The difference
with the ADM1031 is in how the fan speed is computed.

For the ADM1031, each temperature channels has its trip points. You use
them to compute a (virtual) fan speed, then for each fan, see which
temperature channels are linked to it, and pick the faster speed.

For the IT87xx, each *fan* (not temperature channel) has its trip
points. You use the fan vs. temperature mapping to find which
temperatures apply to this fan, pick the hottest temperature, and
determine the fan speed for that temperature.

The trick is that a fan can be driven by more than one temperature, and
one temperature can drive more than just one fan, which makes things
kinda complex, and, more importantly, makes both models incompatible as
far as I can see.

Feel free to read the IT87xx and ADM1031 datasheets again to confirm
that my descriptions of both chips are OK.

If you think it is possible to merge both models in a single interface,
let me know. I couldn't find a way. Or, if there is a way, it's so
complex that we would make the drivers unreadable, and we don't want to
do that, do we? And even then it's not perfect, IIRC.

I would like to propose a Documentation/i2c/sysfs-interface update quite
soon now, we have delayed this for too long already (although I am not
the only one to blame here - anyone can do it). The it87 and w83627hf
drivers have people interested in adding auto-fan control support, and
are basically blocked by the lack of standardized interface.

One point which was still debated is whether pwm_enable should have
value 2 in auto mode (MDS' proposal), or if we would simply rely on a
non-empty temperature vs. fan mapping to mean that auto mode is enabled
(my original proposal). Now that I come to think of it, I think that's
MDS' way is better, because it's more likely to match the chips
internals, and that way we can remember the temperature vs. fan mappings
when not in non-auto mode. It also makes it more clear that pwm_enable
is the master control. Comments?

Thanks.

-- 
Jean "Khali" Delvare
http://khali.linux-fr.org/

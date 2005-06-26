From: khali@linux-fr.org (Jean Delvare)
Date: Sun, 26 Jun 2005 11:23:05 +0000
Subject: [lm-sensors] Reading LM96000 on an Intel SE7221BK1 server board
Message-Id: <20050626112242.4ed923f8.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050622212816.GD7554@levanta.com>
In-Reply-To: <20050622212816.GD7554@levanta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Richard,

> Should I expect to see a 2c, 2d, or 2e in that output?

Yup, if the LM96000 was connected to that bus.

> As I don't, what does that mean?

That the LM96000 isn't there.

> Might it mean the chip is connected to some other i2c bus I
> havn't found yet,

Either that, or the ICH6 SMBus is multiplexed. This is common on Asus
boards, but I don't think we ever saw an Intel board do that.

> or I need to do something else to enable it, or what?

If you do, it has to be board specific so only Intel can tell you.

> Might I have done something that made the chip invisible?

I don't think so.

> I assume I'm correct in thinking that as it doesn't show up in
> i2cdetect output, there is no chance of the lm85 driver detecting it.

Absolutely.

> I also don't know what the i2c devices at 08, 42, 44, 60 and 69 are.
> 50 and 52 get picked up by the eeprom driver.

08 and 44 are special addresses for SMBus 2.0 stuff, 69 is most probably
a clock chip you so not want to play with. Remains 42 and 60, I have no
idea for these (except that these are not typical addresses for hardware
monitoring chips).

> I'm running an FC3 2.6.10-1.766_FCsmp kernel atm, but I'm guessing
> that wouldn't have an impact on i2cdetect output.

No impact, true.

> Any suggestions on how to access the LM96000 welcome.  The board
> has a PC87427 too, and the motherboard doc suggests that has an "i2c
> interface to LM96000 sensors", but I'm not sure I believe that;
> the PC87427 has a SensorPath interface for talking to LMxx sensors,
> but I don't think the LM96000 talks SensorPath.

Correct again.

> The PC87427 has an SMbus slave interface too, and I didn't see
> anything that looked like that in the i2cdetect or i2cdump output
> either.

True again, it would show at 30 or 6c if I trust the preliminary
datasheet I have, and these addresses did not work in i2cdetect.

So your analysis is correct, I wouldn't have come up with a different
conclusion. Your best chance now is probably to ask Intel themselves for
help and details on the wiring.

Good luck,
-- 
Jean Delvare

From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:33 +0000
Subject: CPU temp does not update
Message-Id: <iDcUe6bd.1106741671.8705550.khali@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <200501241750.44403.jrclarke@btinternet.com>
In-Reply-To: <200501241750.44403.jrclarke@btinternet.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi John,

> here is lsmod immediately after reboot
> (...)

(no w83627hf)

> and here is
> # isadump 0x295 0x296 1
> (..)
> 50: 2d 80 01 7a 00 7f 00 ff ff ff ff ff ff ff ff ff

To my great surprise, temp2 is *already* disabled at this point. This
suggests the following things:
1* This is probably the hardware default, contrary to what the datasheet
says.
2* Your BIOS doesn't enable temp2 on regular boot, although it obviously
enables it when you enter the setup screen (you saw the temperature
update there).

> I have now done modprobe w83627hf init=0
> (...)
> Unfortunately it does not change (I ran cpuburn for a few minutes, fan
> speed increased as expected but no change to temp2)

You are lucky that the fan speed changed at all. If it was based solely
on the CPU temperature it wouldn't have. I guess it somehow also
depends on the system temperature (which is not disabled and probably
cannot be). Unless this is a self-regulating fan?

Skipping the init would have preserved a correct setup done by the BIOS,
but since such a setup was not done in the first place, it didn't help.
No surprise here.

So, what next? You can just reconfigure the chip on the fly, thanks to
the following command sequence:

isaset -y 0x295 0x296 0x4e 0x01
isaset -y 0x295 0x295 0x52 0x00
isaset -y 0x295 0x296 0x4e 0x00

Preferably you would prepare the lines in a script so as to run them all
in a row. It is important to make sure that nobody accesses the chip
between the commands.

You can run this sequence either before loading the w83627hf driver, in
which case you would still need "init=0", or after the w83627hf driver
has been loaded.

This should hopefully re-enable temp2, for good this time. Of course this
is only a temporary method. Now that I know what should be done, I will
update the drivers so as to enable the temperature channels by default -
maybe with a warning in the logs since the channels may actually not be
used (no remote sensor connected). Expect some delay before the update
reaches your distribution kernel though.

Thanks,
--
Jean Delvare

From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 12 May 2008 15:26:25 +0000
Subject: Re: [lm-sensors] [PATCH] i2c-piix4: Blacklist two mainboards
Message-Id: <20080512172625.5a5ed069@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20080504183048.177fc0b4@hyperion.delvare>
In-Reply-To: <20080504183048.177fc0b4@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, 12 May 2008 17:02:39 +0200, Achim Gottinger wrote:
> 
> > This is how you hit the problem, but there are many other ways people
> > could hit it, such as using i2cdump, i2cget or i2cset, or even just
> > loading a hardware monitoring driver which happens to probe I2C address
> > 0x2e. While we fixed sensors-detect by now, not everyone will upgrade
> > to the new version of the script immediately, and all the other ways to
> > screw it up are still available. So, the only safe thing to do at the
> > moment is to disable the SMBus on your motherboard completely.
> >
> > In the future, we could refine this and allow access again with
> > restrictions, such as no probing allowed from kernel drivers, and no
> > access from user-space (there's some more work needed before we can do
> > that.) Or we could limit the blacklisting to specific addresses (that's
> > easier to implement).
>
> But that way you can not run it on the DFI and Sapphire boards even if 
> the latest lm-sensors version is in use.

Right now there's not much interesting on the SMBus anyway on these
boards. Except for the SPD EEPROMs, none of the other chips have drivers
available. And SPD EEPROMs aren't that interesting. Or at least they
are not worth letting users break their hardware.

> How about a kernel config flag to disable this patch? Also I 

No. If we decide we want to give people access to their SMBus on these
boards, then we have to do it in a safe and clean way, and that's a
long way to go. Having an config option "let me break my hardware"
doesn't sound good at all. I understand that you are into overclocking,
but me, I am into taking my responsibilities to not let users burn their
hardware.

> noted that you added infos on the website about this board.
> The DFI Lanparty UT 790FX-M2R is not mentioned there but this board is 
> also affected, two users reported they had to rma
> board and/or cpu after running sensors-detect meanwile.

Can you please provide references? I will update the website.

> > I am worried that "hwmod" is too similar to "hwmon" and this will lead
> > to confusion. What about "overclock" or a similarly explicit term?
>
> I'm concerned about that similarity here also. I don't want to put the 
> focus on overclocking, so
> i picked hwmod (hardware modification)

Misnomer anyway, you are not modifying the hardware with these chips
(except for the unfortunate case where you start with working hardware
and end up with dead hardware, that is.)

> for now, can use hwchange,hwshift 
> or hwco (hardware change/clock over)
> also. It's easy to change this in future.

> (...)
> Is this list the right place to discuss i2c related kernel modules? I 
> dont want to get off topic here.

No it's indeed not, i2c stuff should be discussed on the i2c mailing
list:
http://lists.lm-sensors.org/mailman/listinfo/i2c

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

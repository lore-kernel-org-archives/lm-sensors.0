From: juergh@gmail.com (Juerg Haefliger)
Date: Sat, 26 Aug 2006 22:40:47 +0000
Subject: [lm-sensors] [PATCH 1/2 RESEND 2] hwmon: new vt1211 driver
Message-Id: <191fb4ca0608261540i5333588fld413b48551c1aef3@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <191fb4ca0605311844n3d24f429k8942ffaa15e864a8@mail.gmail.com>
In-Reply-To: <191fb4ca0605311844n3d24f429k8942ffaa15e864a8@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean,

> > Thinking about this some more I fail to see how the data cache can
> > ever be out of sync (assuming the update function gets called during
> > initialization). The only way for the registers to  change is through
> > a callback and the callbacks always update the cache as well. How can
> > they ever get out of sync?
>
> Several things can happen.
>
> Firstly, the user can write to the registers from user-space. Granted,
> we don't really care, a user doing this is on his/her own.
>
> Secondly, the chip itself could change some of the bits in a given
> register. For example imagine a chip with two fans, and a register
> containing the fan clock dividers (6 bits) and the alarm status (2
> bits) for these fans. The alarm bits could change anytime, so you need a
> fresh read from the register if you want to update one of the clock
> dividers. Of course this depends on the chip, the VT1211 may not have
> any such register.
>
> Lastly, and more importantly, something else (BIOS, ACPI...) can access
> the chip in your back. This is not a conspiracy theory, we DID see this
> several times already. Limits changing depending on the CPU frequency,
> for example. If you never read back from the limit registers, assuming
> that they never change unless you write to them, then the user will
> never see the phenomenon happen. He or she will, however, notice
> inconsistencies, such as alarm flags not matching the values and
> limits. And the user reports to us, and we spend hours figuring out
> what's going on...
>
> For this reason, we do not assume the register values to be constant
> over time, in any driver. I agree it has a performance cost, but we
> decided it was better than hiding strange phenomenons when they happen.

Well in that case I fail to see the purpose of the register cache at
all. It gets refreshed every time a read callback is executed and in a
write callback we're assuming it's stale and refresh it as well. We
never use the cached values for anything so why bother? Wouldn't it be
simpler to split up the vt1211_refresh_device function and just read
the registers that we're interested in in the individual read
callbacks as oposed to calling vt1211_refresh_device and read
everything?

...juerg


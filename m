From: hmh@debian.org (Henrique de Moraes Holschuh)
Date: Tue, 25 Oct 2005 16:00:07 +0000
Subject: [lm-sensors] Patch for 'w83627thf' Chipset add SmartFan control
Message-Id: <20051025135944.GA7506@khazad-dum.debian.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <4A9A21CEA07B1F4A973CFCD89B9446C90111853C@sermaila.itesoft.local>
In-Reply-To: <4A9A21CEA07B1F4A973CFCD89B9446C90111853C@sermaila.itesoft.local>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, 25 Oct 2005, Jean Delvare wrote:
> Can you please develop on this? Which drivers were broken? What
> functionality was taken away?

The LM85 driver was hosed by it (well, it probably was broken before, but
one could fix the mess from userspace before the interface change).  AMD1027
*requires* proper setup to work in autofan mode, it *must* be put into
pwm-aware tachometer mode, or it screws up completely: all fan readings go
berserk, and the fan keeps changing speeds widly, which makes an awful
ammount of noise.  ADT7463 is likely to work the same way.  EMC6D100
fortunately only has the pwm-aware mode, so you can't break it.  EMC6D102 is
an unknown, and so is LM85B/C.

Granted, some BIOSes do the proper ADM1027 setup, so that reduces the number
of people hit by the issue (the driver is very careful and does not mess
with what it doesn't have any reason to), and thus will preserve the
tachometer mode).  Unfortunately (or fortunately, or I'd never have noticed
it) the Intel D875PBZ Desktop board BIOS doesn't.

I have this fixed already, but I don't like the current interface I added to
LM85 to do it completely (i.e. add the missing acuostics enhancement control
that was removed when the chip-specific interfaces were deleted), so I did
not send in patches yet.

> There is. Read Documentation/hwmon/sysfs-interface, it's all there, in
> the PWM section, since 2.6.10-rc1.

That thing is incomplete in the sense that it does not cover everything the
drivers used to be capable of (it certainly lacks acoustics enhancement
control that LM85 used to have), and does not match userspace reality.
Unless Debian unstable is shipping borked userspace, that is.

> This interface was discussed a long time ago on this list, it even made
> some noise if I recall properly.

Well, I wasn't around then, or I'd have raised the need for an acoustics
enhancement interface.

> BTW, it's really great that you are proposing to help us. Our project
> really needs good souls willing to spend their time reviewing and
> integrating code, analyzing and fixing bugs, and supporting users, for
> free. As you may have noticed, there is more work that the volunteers
> can currently deal with. More manpower is always welcome.

Hmm. Ok. So, exactly HOW am I supposed to address missing interfaces? Just
write the code including a patch to the docs and be done with it?

> As said above, the interface already exists. No need to draft anything as
> far as I can see. If the interface doesn't fit your needs, please
> explain why.

It has no way to deal with acoustincs enhancements.  It is all in the email
that was ignored, Message-ID: <20050911211327.GA23393@khazad-dum.debian.net>
and in a small correction I did on Message-ID:
<20050916153433.GA28335@khazad-dum.debian.net>

> That's fine with me. Not everything fits in the standard. The additional
> sysfs names must simply not interfere with the current or future
> standard names.

Please let us have a namespace *reserved* for that, then. It is the sane
thing to do.

How about chipspecific_* ?  If you're OK with it, I will send the patch for
the docs.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh

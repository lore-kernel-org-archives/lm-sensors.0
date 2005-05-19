From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:52 +0000
Subject: Centrino (855PM, ICH4-M): 82801DBM w/o LPC Bridge/SMBus?
Message-Id: <1081859511.407bddb789d20@imp.gcu.info>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040412152503.GD6820@neu.nirvana>
In-Reply-To: <20040412152503.GD6820@neu.nirvana>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> I renamed p4b_smbus.c to 82801_smbus.c, as the problems is not
> isolated to a specific motherboard.

You shouldn't do that. I agree that the name is not perfect and somewhat
error-prone, but renaming files under CVS means losing their history
(well it's still there but it's more difficult to access it, since you
have to know the old name as well, and still the history is split in
two parts). I don't think it's worth renaming the file anyway,
documenting well enough should be OK.

Personally I don't really care, to say the truth (just mention the old
name in the new commit message), but I know for sure that MDS will not
like it at all ;)

> The README.p4b mentioned that recent kernels (2.4.23 upwards) have
> the i801 SMBus detection and activation patched in.

Oh, nice. I though that only 2.5/2.6 kernels could do that.

> I just checked and the patch is less than a dozen lines, and very
> easily extendable to Centrino laptops with hidden SMBus. But it is
> in the quirks.c, which means that it needs a kernel patching.

Well, that can be done. It's just a bit more complex than usual because
it depends on the kernel version (I guess that we don't do anything if
version < 2.4.23). Just provide the needed patch and I'll try to teach
mkpatch how to do the same.

You could also send that patch to Marcelo for inclusion into the 2.4
tree if this is trivial.

And you could also send a similar patch to whoever is in charge of that
part in Linux 2.6 it it applies there too.

> Any chance that detection/enabling could enter i2c-i801.c? Should I
> give it a try and merge p4b_smbus.c/quicks.c bits into i2c-i801.c?

I don't know why it wasn't done that way in the first place. Maybe it
was decided that "regular" user should be allowed to keep the driver as
simple as it was, with no additional stuff? Or maybe it is because
p4b_smbus needs CONFIG_HOTPLUG? In this case I guess that we can enable
that part if and only if CONFIG_HOTPLUG is set, it shouldn't affect the
rest of the driver.

Actually, the fact that this part has moved to quirks.c means that the
driver doesn't have to care anymore, so it's just fine that it was put
in a different module in the first place. Any idea about what would
happen if the code was both in quirks.c and in i2c-i801.c? Would the
i2c-i801 part just be left unused, or should we fear more conflicts?

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/

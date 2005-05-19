From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:55 +0000
Subject: LM99 support
Message-Id: <1083141401.408f6d196a1af@imp.gcu.info>
List-Id: <lm-sensors.vger.kernel.org>
References: <1082749445.2933.5.camel@c211-30-214-50.rivrw3.nsw.optusnet.com.au>
In-Reply-To: <1082749445.2933.5.camel@c211-30-214-50.rivrw3.nsw.optusnet.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> Hi Jean, hope you are well.

I'm fine thanks :) Although slightly overbooked, but who isn't?

> 1) Do I need to apply the patch u sent me or is it now in the CVS?
> When attempting to apply the path i get this:
> 
> [kernel] # patch -p1 < linux-2.6.3-i2c-lm99.diff
> can't find file to patch at input line 3
> Perhaps you used the wrong -p or --strip option?
> (...)
> ** So I haven't done the patch.

The command is correct, you just probably didn't run it from the
correct location. I suppose that you entered the "kernel" subdirectory
of lm_sensors2 and ran the command there. This isn't correct.

I think a quick summary of how things work will help. The lm_sensors2
CVS repository contains two different things: 2.4 kernel drivers (under
the "kernel" directory) and user-space tools (almost all other
directories). Additionally, official 2.6 kernel trees have sensors
drivers included. So, depending on the kernel you use (2.4 or 2.6) the
installation procedure differs.

For a 2.4 kernel, everything comes from the CVS repository. You do
"make" and "make install".

For a 2.6 kernel, the drivers come from the kernel tree (nothing to do)
and you only want the user-space tools from lm_sensors2. You do "make
user" and "make user_install".

You are in the second case.

However, this is a bit more complex in your case because you want to
update your kernel tree with the patch I sent to you.

From what you say below, I guess that you never actually configured and
compiled a kernel by yourself, but got it from a Mandrake package. This
means that you may not even have the source tree on your system. If you
do it should be found under /usr/src/linux or maybe
/usr/src/linux-2.6.3. Maybe you can get the sources from a source RPM
package, I don't know Mandrake enough to tell.

If you do have the tree there, it should be rather easy. Apply the
patch to it (same command you did, from the /usr/src/linux directory),
then do "make modules && make modules_install" and it should
(hopefully) be OK.

If you don't, it's more tricky. You need to get the kernel source tree
from wherever you want (either a Mandrake RPM or kernel.org), configure
it (preferably starting from your current configuration, which you
should find under /boot/config and copy to
/usr/src/linux-whatever/.config), then "make", "make modules_install"
and copy the kernel to /boot. I usually do something like (from the
/usr/src/linux-2.6.3 directory):

cp arch/i386/boot/bzImage /boot/vmlinuz-2.6.3
cp .config /boot/config-2.6.3
cp System.map /boot/System.map-2.6.3

Then edit /etc/lilo.conf to add the new entry (copy from an old one and
change the kernel path and the label), then save and run "lilo" to
update the boot sector.

The exact correct things to do may depend on your configuration and
distribution, I just wrote what *I* do on my system. Remember that I am
an old-school guy.

Beware that all of this is relatively complex and tricky, especially if
you have never been messing around wth a kernel compilation before.
Depending on how much time and will to destroy your system you have ;)
you may consider waiting for the patch to be included to the official
kernel tree (not before 2.6.7) and that Mandrake builds a RPM for it.
This may take some time.

BTW, if Mandrake is likely to have a RPM for a 2.6.5 kernel soon, you
can start with this. It of course won't support the LM99 out of the
box, but you will be able to force the driver to handle it as a LM90,
which should work.

> 2) when I do 'make user' and 'make user_install' i see no references
> to lm90 (or any other modules) being compiled or installed. The
> original modules are still in my
> /lib/modules/2.6.3-7mdk/kernel/drivers/i2c/chips.
> The documentation states: "The kernel modules in this package will
> not compile for 2.6/2.5; use the drivers already in the 2.5 kernel
> development tree." 

No wonder, see what I said above. "make user" and "make user_install"
compile and install user-space tools only, and this is the correct
thing to do for a 2.6 kernel.

> 3) These issues are probably a victim of question 2. After removing
> my lm_sensors and liblm_sensors RPM and getting the files from the
> CVS and doing 'make user', 'make user_install' and doing
> sensors-detect and following the instructions to do ldconfig and
> removing libsensors.* from /usr/lib i get this:
> (...)
> asb100-i2c-3-2d
> Adapter: SMBus Via Pro adapter at e800
> ERROR: Can't get IN data! (0x0001)
> ERROR: Can't get IN data! (0x0002)
> ERROR: Can't get IN data! (0x0003)
> ERROR: Can't get IN data! (0x0004)
> ERROR: Can't get IN data! (0x0005)
> ERROR: Can't get IN data! (0x0006)
> ERROR: Can't get IN data! (0x0007)
> ERROR: Can't get FAN data! (0x0031)
> ERROR: Can't get FAN data! (0x0032)
> ERROR: Can't get FAN data! (0x0033)
> ERROR: Can't get TEMP data! (0x0051)
> ERROR: Can't get TEMP data! (0x0054)
> ERROR: Can't get TEMP data! (0x0057)
> ERROR: Can't get TEMP data! (0x005a)
> ERROR: Can't get VID data!

There was an interface change between 2.6.3 and 2.6.5 kernels. You have
a 2.6.3 kernel (old interface) while the CVS repository of course uses
the new one. This means that you need at least a 2.6.5 kernel if you
want to use the CVS repository's user-space tools.

The patch I sent to you for the LM99 would have updated the lm90 driver
to the new interface, but not the other drivers, and I see you need the
asb100 driver as well. I'm a bit stupid, I should have thought of
that.

So at this point you have two options:

1* Configure, compile and install a kernel by yourself. In this case
you
want to use the most recent kernel available (2.6.6-rc1 or later) and
apply the 2.6.6-rc1 patch I sent to you before. You have true LM99
support (if what I did works).

2* Wait for a 2.6.5 kernel package from Mandrake and use that, together
with their sensors user-space tools or our CVS repository, at your
option. You don't have LM99 support but can force the lm90 driver to
recognize your chip.

The second choice is obviously easier but you'll probably have to wait
some times before Mandrake provides the RPM you need.

Good luck.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/

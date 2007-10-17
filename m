From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 17 Oct 2007 21:42:31 +0000
Subject: Re: [lm-sensors] [PATCH] On n2100 systems,
Message-Id: <20071017234231.2ec0133b@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20071016100857.GA25544@kos.to>
In-Reply-To: <20071016100857.GA25544@kos.to>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Lennert,

On Wed, 17 Oct 2007 17:19:35 +0200, Lennert Buytenhek wrote:
> On Wed, Oct 17, 2007 at 04:57:00PM +0200, Jean Delvare wrote:
> 
> > > On thecus n2100, the bootloader does not setup fans to run. In order
> > > to protect the user from frying their gear, start up fans on boot.
> > 
> > Why don't you fix the "bootloader" (whatever it is in your context)
> 
> The bootloader is Redboot.  It is shipped as the default bootloader
> in the flash of the device as sold, and it runs directly after power
> on.  (In that regard, it's kind of like the PC BIOS in x86 machines.)

OK, thanks for the clarification.

> While I would agree that fixing this in the bootloader is the cleanest
> approach, I'm pretty sure that even if we do manage to build a new
> version of the bootloader (I'm not even sure whether we have the source
> for it),

Can't you contact whoever sells this system? If the "BIOS" is broken,
that's really up to them to fix it.

>          I'm sure many users would be very reluctant to flash a new
> bootloader into their device.

If their machine fries when they don't, I'm pretty sure they will ;)

> We do work around PC BIOS bugs in the Linux kernel as well.  This
> isn't a very different situation from that, I think.

I'm not aware of such workarounds to prevent machines from frying. For
such critical cases, system vendors typically bother releasing a BIOS
update.

What I would like to understand is how we came in to the current
situation. As I said, stopped fans is not the default for the F75375S
chip. This really suggests that the fans are stopped on purpose by
whoever wrote that Redboot thing. I would appreciate if somebody could
confirm this. Also, are the fans really stopped, of set into automatic
mode and just happen not to spin because the temperature isn't high
enough? Can I see a dump of the chip before the Linux driver is loaded?

So, someone is selling hardware that fries when used because they
disabled the fans on purpose. How can this be? Is this hardware
supposed to be used with another OS, and that other OS does kick the
fans in as you suggest Linux should do? Please clarify the situation.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

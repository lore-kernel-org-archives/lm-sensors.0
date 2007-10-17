From: Lennert Buytenhek <buytenh@wantstofly.org>
Date: Wed, 17 Oct 2007 22:51:48 +0000
Subject: Re: [lm-sensors] [PATCH] On n2100 systems,
Message-Id: <20071017225148.GA350@xi.wantstofly.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20071016100857.GA25544@kos.to>
In-Reply-To: <20071016100857.GA25544@kos.to>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, Oct 17, 2007 at 11:42:31PM +0200, Jean Delvare wrote:

> Hi Lennert,

Hey Jean,


> > While I would agree that fixing this in the bootloader is the cleanest
> > approach, I'm pretty sure that even if we do manage to build a new
> > version of the bootloader (I'm not even sure whether we have the source
> > for it),
> 
> Can't you contact whoever sells this system? If the "BIOS" is broken,
> that's really up to them to fix it.

These systems are sold by Thecus.  (www.thecus.com)  The n2100 looks
something like this:

	http://www.trustedreviews.com/images/article/inline/2559-frontleft.jpg

In the default firmware, the bootloader automatically boots an ARM
Linux kernel which contains a fan controller driver.  Meaning, the
default kernel that runs on the machine (which is the only kernel that
the manufacturer has envisioned ever running on the machine -- and most
users of the device won't actually realise that there is a Linux kernel
running on the device at all) handles thermal management correctly.

The n2100 is sold as a purpose-built NAS appliance, not as a
general-purpose ARM hack box.  Even though it's not too hard to hack
the firmware and run your own software on the machine, it's not
something that the product is advertised for.

I'm not sure whether the bootloader explicitly disables the fans or
whether they just don't kick in because the temperature isn't high
enough.


> >          I'm sure many users would be very reluctant to flash a new
> > bootloader into their device.
> 
> If their machine fries when they don't, I'm pretty sure they will ;)

Luckily, their machine won't fry if they don't. :)


> > We do work around PC BIOS bugs in the Linux kernel as well.  This
> > isn't a very different situation from that, I think.
> 
> I'm not aware of such workarounds to prevent machines from frying. For
> such critical cases, system vendors typically bother releasing a BIOS
> update.
> 
> What I would like to understand is how we came in to the current
> situation. As I said, stopped fans is not the default for the F75375S
> chip. This really suggests that the fans are stopped on purpose by
> whoever wrote that Redboot thing.

As I understand, Redboot was written by Red Hat.  It's probably
one of the most widely used ARM bootloaders out there.

The port of Redboot to the IOP 80219 (which is the CPU in the n2100)
was done by Intel, and the port to the n2100 board specifically was
done by Thecus.

As I said above, I am not entirely sure what Redboot does.  Riku, do
you have the source code for the Redboot used in the n2100?


> I would appreciate if somebody could
> confirm this. Also, are the fans really stopped, of set into automatic
> mode and just happen not to spin because the temperature isn't high
> enough?

I'm not entirely sure.


> Can I see a dump of the chip before the Linux driver is loaded?

Riku?


> So, someone is selling hardware that fries when used because they
> disabled the fans on purpose.

It's not as dramatic as that. :)


> How can this be? Is this hardware
> supposed to be used with another OS, and that other OS does kick the
> fans in as you suggest Linux should do? Please clarify the situation.

I don't think other OSes run on this machine.

Well, maybe one of the BSDs do -- but I'm not sure how they handle
the fans.

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

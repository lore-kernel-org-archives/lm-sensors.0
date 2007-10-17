From: Lennert Buytenhek <buytenh@wantstofly.org>
Date: Wed, 17 Oct 2007 15:19:35 +0000
Subject: Re: [lm-sensors] [PATCH] On n2100 systems,
Message-Id: <20071017151935.GB29029@xi.wantstofly.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20071016100857.GA25544@kos.to>
In-Reply-To: <20071016100857.GA25544@kos.to>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, Oct 17, 2007 at 04:57:00PM +0200, Jean Delvare wrote:

> > On thecus n2100, the bootloader does not setup fans to run. In order
> > to protect the user from frying their gear, start up fans on boot.
> 
> Why don't you fix the "bootloader" (whatever it is in your context)

The bootloader is Redboot.  It is shipped as the default bootloader
in the flash of the device as sold, and it runs directly after power
on.  (In that regard, it's kind of like the PC BIOS in x86 machines.)

While I would agree that fixing this in the bootloader is the cleanest
approach, I'm pretty sure that even if we do manage to build a new
version of the bootloader (I'm not even sure whether we have the source
for it), I'm sure many users would be very reluctant to flash a new
bootloader into their device.

We do work around PC BIOS bugs in the Linux kernel as well.  This
isn't a very different situation from that, I think.

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

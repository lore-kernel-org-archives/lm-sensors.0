From: daniel.n.nilsson@home.se (Daniel Nilsson)
Date: Thu, 15 Dec 2005 19:15:35 +0000
Subject: [lm-sensors] Kernel hangs with i2c-i801 driver?
Message-Id: <20051215191535.GA28437@dnil.homelinux.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <20051123100021.GA29473@oden.homeip.net>
In-Reply-To: <20051123100021.GA29473@oden.homeip.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean,

On Thu, Dec 08, 2005 at 10:22:40PM +0100, Jean Delvare wrote:
> 
> > The picture attached is a very simple drawing showing the south bridge in one
> > box and the w83792d in another box. There is one arrow from the south 
> > bridge to
> > the w83792d labelled "SMI bus" and the there is one arrow from the w83792d to
> > the south bridge labelled interrupt.
> > 
> > Does this provide any more insight? Could this be more of an issue with the
> > interrupt coming into the south bridge causing a hang since no code is
> > servicing that interrupt? I don't know the kernel that well to guess any
> > further though...
> 
> I don't know much either, but the schematics would need to mention pin
> numbers or names so that we know *which* GPIOs of the i801 are
> involved. Is that the case? Without that information, it probably
> doesn't help us much.

I've got another answer fro GBT Support:

"We are sorry for the late response. Here is an answer from our R&D team:
The GPI7 is the interrupt pin of 83792. Please disable the SMI bus of
GPI7 from South bridge.

Hope this helps.

Best regards,

GBT Tech Support"

I actually didn't expect to get this questin answered from GBT, not
that the answers are that exhaustive but at least we are getting bits
and pieces here and there...

So I assume we are talking about GPI7 on my ICH7R bridge. In the
datasheet,

http://download.intel.com/design/chipsets/datashts/30701301.pdf

of the ICH7R I understand that this pins can be set to cause either
SCI and/or SMI#. This should be programmed by the BIOS though, right?
Linux should be messing around with these chipset registers?
Regardless, the register of interrest I think is the one in chapter
10.8.1.5. Now how would I read the value in that register from user
space in Linux? It says that the registers that this specific register
is part of is distributed within PCI Device 31:Function 0 space as
well as a separate I/O range but this still doesn't tell me much on
how to read it...

Thanks!
Daniel


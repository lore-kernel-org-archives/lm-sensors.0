From: r.marek@sh.cvut.cz (Rudolf Marek)
Date: Fri, 16 Dec 2005 19:59:47 +0000
Subject: [lm-sensors] Kernel hangs with i2c-i801 driver?
Message-Id: <43A31CB3.6030204@sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <20051123100021.GA29473@oden.homeip.net>
In-Reply-To: <20051123100021.GA29473@oden.homeip.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> I've got another answer fro GBT Support:
> 
> "We are sorry for the late response. Here is an answer from our R&D team:
> The GPI7 is the interrupt pin of 83792. Please disable the SMI bus of
> GPI7 from South bridge.
> 
> Hope this helps.
> 
> Best regards,
> 
> GBT Tech Support"
> 
> I actually didn't expect to get this questin answered from GBT, not
> that the answers are that exhaustive but at least we are getting bits
> and pieces here and there...
> 
> So I assume we are talking about GPI7 on my ICH7R bridge. In the
> datasheet,
> 
> http://download.intel.com/design/chipsets/datashts/30701301.pdf
> 
> of the ICH7R I understand that this pins can be set to cause either
> SCI and/or SMI#. This should be programmed by the BIOS though, right?
> Linux should be messing around with these chipset registers?

Linux should not unless there is something wrong like this...

The real question is WHAT is failing. What exactly in the SMM mode handler will fail...
This is very hard to debug, perhaps with the need of real hardware debugger.

So we have two ways how to handle this:

Method 1) to disable the SMI via GPI7

we need to know:
 1) how to identify this motherboard, (DMI, PCI subsystem ID (subsystem ID is needed to ask them))
 2) will the disabled SMI affect the emergency shutdown of CPU?
   (we can answer this by ourselfs, I think the W83792D has OVT pin for this)
    Better to have it confirmed.

 3) then we will develop a patch to quirks.c

Method 2) try to uncover why the SMI failes
   This is very difficult. Maybe we can ask them for some special bios version
   with modified SMM handler to see if it fails too.

   We can ask them to provide the SMM BIOS handler code and try to look around...

   Are you using USB keyboard or mouse?
   (SMM is used for emulation this devices as legacy PS/2)

So question is what to try....

Maybe we can disable the GPI7 and see if there are no hangs. If so then we can try to find real reason. If it fails
we can implement method1.

> Regardless, the register of interrest I think is the one in chapter
> 10.8.1.5. Now how would I read the value in that register from user
> space in Linux? It says that the registers that this specific register
> is part of is distributed within PCI Device 31:Function 0 space as
> well as a separate I/O range but this still doesn't tell me much on
> how to read it...


PCI space => lspci -x -x -x
IO space => isadump -f

So for our case

lspci -x -x -x

Is enough. (enough is even the listing from PCI Device 31:Function 0)

Regards
Rudolf

BTW: Intel left little secret in that datasheet look to page 54 (printed) to the picture...
     There is free space in righ bottom corner. Now use mouse to copy that area and you will be surprised ;)
     Well not so much  but it is funny way to hide information rather then delete.


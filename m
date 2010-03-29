From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 29 Mar 2010 15:08:42 +0000
Subject: Re: [lm-sensors] Support for W83627DHG
Message-Id: <20100329170842.652b1fc7@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <4BB0BE38.2090502@kaskonetworks.it>
In-Reply-To: <4BB0BE38.2090502@kaskonetworks.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Fabio,

On Mon, 29 Mar 2010 16:50:32 +0200, fabio.antonini@kaskonetworks.it wrote:
> Dear all
> I'm working on a board based on a ATOM Z530. The CPU module is called 
> MSC_Q7 US15W and the mother board is named Q7-MB-RP.
> At the moment I have succesfully booted a Ubuntu 9.10 distribution. All 
> drivers seem to be
> working except the SuperIO W83627. The chip is rightly detected but it's 
> not loaded because the
> driver (w83627ehf) claims that (from dmesg)
> 
> "Refusing to enable a Super-I/O device with a base I/O port 0"
> 
> The section of the driver involved on this step is
> 
>      /* We have a known chip, find the HWM I/O address */
>      superio_select(sioaddr, W83627EHF_LD_HWM);
>      val = (superio_inb(sioaddr, SIO_REG_ADDR) << 8)
>          | superio_inb(sioaddr, SIO_REG_ADDR + 1);
>      *addr = val & IOREGION_ALIGNMENT;
>      if (*addr = 0) {
>          printk(KERN_ERR DRVNAME ": Refusing to enable a Super-I/O "
>                 "device with a base I/O port 0.\n");
>          superio_exit(sioaddr);
>          return -ENODEV;
>      }
> 
> My feeling is that the SIO_REG_ADDR contains a 0x0 instead of a real
> address. Who should set this address? Do I need another kernel module
> that sets this address?

It is the BIOS' job. Check in the BIOS is there is any option to enable
hardware monitoring.

Also check the documentation. The W83627DHG is a Super I/O chip with
many functions, hardware monitoring is only one of them, and it is
possible that hardware monitoring pins are simply not wired and that's
the reason why the address isn't set.

> The output of sensors-detect is
> (...)
> As you can see the chip has been detected but no address has been 
> specified:
> 
> Found `Winbond W83627DHG Super IO Sensors'
>      (but no address specified)
> 
> Where can I set this address?

There's no easy, standard way (because it is not normally needed.)

> What's missing?

BIOS initialization, if anything.

> Has this driver been tested before on this board on Ubuntu 9.10?

There are so many boards and so many Linux distributions out there that
the probability that someone on this list can answer this question is
next to zero.

> Do I need to enable anything in the BIOS?

This is one possibility, yes.

> Do I need load the driver passing any parameter?

No.

> Any help will appreciated.

If you really want to, you can set the I/O base to an arbitrary port
(e.g. 0x290, check in /proc/ioports that 0x290-0x297 is free first) and
see if it helps. You can do this using the "isaset" command (be careful
with that command, don't go writing to random I/O ports, it would hurt.)

-- 
Jean Delvare
http://khali.linux-fr.org/wishlist.html

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

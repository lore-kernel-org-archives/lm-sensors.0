From: Shaohua Li <shaohua.li@intel.com>
Date: Mon, 17 Dec 2007 01:59:39 +0000
Subject: Re: [lm-sensors] 2.6.24-rc4 hwmon it87 probe fails
Message-Id: <1197856779.7782.2.camel@sli10-desk.sh.intel.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20071204215154.7f26285e.mikeserv@bmts.com>
	 <20071209000554.GF20441@stusta.de>
	 <20071208212234.e00b74cd.mikeserv@bmts.com>
	 <20071209105028.06ed52a6@hyperion.delvare>
	 <E1J1TRp-0000ZF-6J@asgard.prans.org> <20071209220430.GK20441@stusta.de>
	 <1197253887.27516.2.camel@sli10-desk.sh.intel.com>
	 <20071209230211.1c2077cf.mikeserv@bmts.com>
In-Reply-To: <20071209230211.1c2077cf.mikeserv@bmts.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mike Houston <mikeserv@bmts.com>
Cc: Adrian Bunk <bunk@stusta.de>, Elvis Pranskevichus <el@prans.net>, Jean Delvare <khali@linux-fr.org>, mhoffman@lightlink.com, linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org, Bjorn Helgaas <bjorn.helgaas@hp.com>, Adam Belay <ambx1@neo.rr.com>, Zhao Yakui <yakui.zhao@intel.com>, Thomas Renninger <trenn@suse.de>, lenb@kernel.org, linux-acpi@vger.kernel.org


On Sun, 2007-12-09 at 23:02 -0500, Mike Houston wrote:
> On Mon, 10 Dec 2007 10:31:27 +0800
> Shaohua Li <shaohua.li@intel.com> wrote:
> > This should exist in previous kernel (before we remove acpi
> > motherboard driver) too. Basically it's a broken BIOS. Could below
> > patch work around it?
> > 
> > Thanks,
> > Shaohua
> > 
> > Index: linux/drivers/pnp/system.c
> > =================================> > --- linux.orig/drivers/pnp/system.c	2007-12-10
> > 10:17:46.000000000 +0800 +++ linux/drivers/pnp/system.c
> 
> Thanks Shaohua, I tested this as well and it appears to have worked
> around the issue for me.
> 
> Now, in dmesg, I get:
> 
> system 00:01: ioport range 0x290-0x29f has been reserved
> (...)
> system 00:01: ioport range 0x290-0x294 could not be reserved
> 
> In /proc/ioports I see:
> 
> 0290-029f : pnp 00:01
>   0290-0297 : it87
>     0290-0297 : it87
Unfortunately this can't solve all such issues.

Adam & Bjorn,
Could we just reserve IO ports >= 0x1000 in pnp system driver? The
purpose of the driver is to avoid resource conflict with PCI device, and
PCI device can't user io port < 0x1000.

Thanks,
Shaohua


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

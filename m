From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 18 Nov 2008 12:57:46 +0000
Subject: Re: [lm-sensors] [PATCH 1/2] k8temp warn about errata
Message-Id: <20081118135746.7ca8a874@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <48E3F505.40401@assembler.cz>
In-Reply-To: <48E3F505.40401@assembler.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, 18 Nov 2008 12:26:12 +0100, Andreas Herrmann wrote:
> Hi Rudolf,
> 
> On Thu, Oct 02, 2008 at 12:09:09AM +0200, Rudolf Marek wrote:
> > Index: linux-2.6.27-rc7/drivers/hwmon/k8temp.c
> > =================================> > --- linux-2.6.27-rc7.orig/drivers/hwmon/k8temp.c	2008-09-28 11:01:45.855284456 +0200
> > +++ linux-2.6.27-rc7/drivers/hwmon/k8temp.c	2008-09-28 11:13:42.396117790 +0200
> > @@ -155,6 +158,18 @@
> >  		goto exit;
> >  	}
> >  
> > +	/* get real PCI based cpuid, prior revF of fam 0Fh, this reg is 0 */
> > +	pci_read_config_dword(pdev, REG_CPUID, &cpuid);
> 
> I am just curious whether you have tested this on  a CPU revision prior revF.
> Because "BIOS and Kernel Developer's Guide for AMD Athlon 64 and AMD
> Opteron Processors" suggests that this register exists for those older CPUs:
> 
> "CPUID Fn[8000_0001,0000_0001]_EAX Family, Model, Feature Identifiers
> 
>  This register provides identical information to Function 3, Offset FCh."
> 
> (I don't have access to such a CPU model at the moment and thus can't
> double-check this now.)

For what it's worth, I have the following K8 CPU models here: 15/31/0
and 15/28/0, and both of them have value 0x00 in Function 3, Offset FCh.
That doesn't mean that all pre-rev.F CPUs do though... and it would
probably be trivial to handle both cases in the code if we have any
doubt.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

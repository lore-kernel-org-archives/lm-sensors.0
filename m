From: Clemens Ladisch <clemens@ladisch.de>
Date: Thu, 26 Nov 2009 07:46:35 +0000
Subject: Re: [lm-sensors] [PATCH v4] k10temp: temperature sensor for AMD
Message-Id: <4B0E325B.7060203@ladisch.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <4AF91F70.10106@ladisch.de>	<4B06501B.8080509@ladisch.de>	<87ws1l5wcl.fsf@depni.sinp.msu.ru>	<4B0673D7.5010006@ladisch.de>	<20091120123016.19d98ab4@hyperion.delvare>	<4B068402.7020606@ladisch.de>	<20091120131855.7f8f8722@hyperion.delvare>	<4B0A3DB6.9090703@ladisch.de>	<20091123145154.5b2b5735@hyperion.delvare>	<4B0AAA55.3040702@ladisch.de>	<20091123200527.1114cbc2@hyperion.delvare>	<4B0B9CBB.2050107@ladisch.de> <20091125114544.df69cc98.akpm@linux-foundation.org>
In-Reply-To: <20091125114544.df69cc98.akpm@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Jean Delvare <khali@linux-fr.org>, Serge Belyshev <belyshev@depni.sinp.msu.ru>, linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org, x86@kernel.org

Andrew Morton wrote:
> Clemens Ladisch <clemens@ladisch.de> wrote:
> > This adds a driver for the internal temperature sensor of AMD Family 10h
> > and 11h CPUs.
> > ...
> > +#define REG_HARDWARE_THERMAL_CONTROL	0x64
> > +#define  HTC_ENABLE			0x00000001
> > +
> > +#define REG_REPORTED_TEMPERATURE	0xa4
> > +
> > +#define REG_NORTHBRIDGE_CAPABILITIES	0xe8
> > +#define  NB_CAP_HTC			0x00000400
> 
> These definitions relate to register addresses within the AMD CPUs,
> yes?

Yes, in the PCI configuration space of the internal northbridge.

> I wonder if these should be placed in some header file in
> arch/x86/include/asm/ where other such things are described.

There is no such header.  The files that also access PCI cfg registers:
  arch/x86/kernel/k8.c
  arch/x86/kernel/quirks.c
  arch/x86/oprofile/op_model_amd.c
define their own private symbols or use magic numbers.


Best regards,
Clemens

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

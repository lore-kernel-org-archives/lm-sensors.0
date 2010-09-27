From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Mon, 27 Sep 2010 12:16:50 +0000
Subject: Re: [lm-sensors] x86/hwmon: conditionalize coretemp's dependency on
Message-Id: <20100927121650.GB31847@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <4C8E18790200007800015AF7@vpn.id2.novell.com>
 <20100924185509.GA20155@ericsson.com>
 <4CA05F220200007800018F81@vpn.id2.novell.com>
In-Reply-To: <4CA05F220200007800018F81@vpn.id2.novell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jan Beulich <JBeulich@novell.com>
Cc: "r.marek@assembler.cz" <r.marek@assembler.cz>, "fenghua.yu@intel.com" <fenghua.yu@intel.com>, "khali@linux-fr.org" <khali@linux-fr.org>, "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Mon, Sep 27, 2010 at 03:08:50AM -0400, Jan Beulich wrote:
[...]

> >>  
> >>  config SENSORS_CORETEMP
> >>  	tristate "Intel Core/Core2/Atom temperature sensor"
> >> -	depends on X86 && PCI && EXPERIMENTAL
> >> +	depends on X86 && EXPERIMENTAL
> >> +	depends on PCI || (!MATOM && !GENERIC_CPU && !X86_GENERIC)
> >>  	help
> >>  	  If you say yes here you get support for the temperature
> >>  	  sensor inside your CPU. Most of the family 6 CPUs
> > 
> > Resending my reply to this one as well. Again, apologies if there is 
> > duplication.
> > 
> > The coretemp code unconditionally calls pci functions, even if PCI is not 
> > defined.
> > I am concerned that this might cause problems. It might be better to stick 
> > with
> > the more generic dependency instead of trying to optimize too much.
> 
> pci.h takes care to define stub inline functions for the !CONFIG_PCI
> case. It seemed largely odd for a driver like this to depend on PCI
> at all, and hence I think it is more transparent to make the needs
> explicit.
> 
Seems to me the dependency should not exist in the first place, then.
Otherwise, the driver would still be disabled for GENERIC_CPU, which isn't
good either.

Are there examples of other drivers which are not defining the PCI dependency
but are conditionally calling pci functions ?

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

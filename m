From: Thomas Renninger <trenn@suse.de>
Date: Fri, 14 Mar 2008 09:03:16 +0000
Subject: Re: [lm-sensors] [PATCH 1/2] thermal: add hwmon sys I/F for thermal
Message-Id: <1205485397.21619.35.camel@queen.suse.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <1204072670.10256.111.camel@acpi-hp-zz.sh.intel.com>
	 <200803120029.09505.lenb@kernel.org> <200803130109.45531.lenb@kernel.org>
	 <1205405941.29877.341.camel@queen.suse.de>
	 <20080313230919.GG30864@khazad-dum.debian.net>
In-Reply-To: <20080313230919.GG30864@khazad-dum.debian.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: Len Brown <lenb@kernel.org>, "Zhang, Rui" <rui.zhang@intel.com>, linux-acpi <linux-acpi@vger.kernel.org>, lm-sensors <lm-sensors@lm-sensors.org>, Hans de Goede <j.w.r.degoede@hhs.nl>

On Thu, 2008-03-13 at 20:09 -0300, Henrique de Moraes Holschuh wrote:
> On Thu, 13 Mar 2008, Thomas Renninger wrote:
> > This also happens in drivers/misc/thinkpad_acpi.c.
> 
> I was sure I had removed __exit from every thinkpad-acpi exit handler that
> was also called from __init a long time ago...
> 
> Let's see... nope, there isn't a single instance of __exit in
> thinkpad-acpi.c, so I must have misunderstood you.  I do have lots of
> __init code, but I don't get any warnings from gcc 4.3 about that on ia32.

Ahh, I just checked that the module_init function calls the module_exit
function...
But the module_exit function probably because of this is not declared
__exit.

This looks a bit uncommon. I don't know whether it should be avoided,
but I cannot see why it should hurt.

  Thomas


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

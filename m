From: Hans de Goede <j.w.r.degoede@hhs.nl>
Date: Tue, 18 Mar 2008 09:25:27 +0000
Subject: Re: [lm-sensors] [PATCH 1/2] thermal: add hwmon sys I/F for thermal
Message-Id: <47DF8A87.2010506@hhs.nl>
List-Id: <lm-sensors.vger.kernel.org>
References: <1203975102.10256.82.camel@acpi-hp-zz.sh.intel.com>	 <47C3D04E.6090609@hhs.nl>  <20080317133732.05b79f4d@hyperion.delvare> <1205805569.3171.23.camel@acpi-hp-zz.sh.intel.com>
In-Reply-To: <1205805569.3171.23.camel@acpi-hp-zz.sh.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Zhang, Rui" <rui.zhang@intel.com>
Cc: Jean Delvare <khali@linux-fr.org>, linux-acpi <linux-acpi@vger.kernel.org>, lm-sensors <lm-sensors@lm-sensors.org>, Matthew Garrett <mjg59@srcf.ucam.org>, Thomas Renninger <trenn@suse.de>, "Thomas, Sujith" <sujith.thomas@intel.com>, "Mark M. Hoffman" <mhoffman@lightlink.com>, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Len Brown <lenb@kernel.org>, Richard Hughes <hughsient@gmail.com>

Zhang, Rui wrote:
> On Mon, 2008-03-17 at 20:37 +0800, Jean Delvare wrote:
>> The
>> labelling issue could be solved by adding temp*_label files, but this
>> still prevents the user from overriding a label.

> why user needs to override the label?

Well allowing the user to specify user visible names is always good. But that 
can still be done with temp*_label files. Last time I checked (when I wrote the 
_label sysfs atrr support code) it would only check for and use a foo#_label 
file if no label was specified in sensors.conf.

This would of course require the temp# numbering to be consistent over reboots 
and kernel versions.

Regards,

Hans

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 18 Mar 2008 09:44:28 +0000
Subject: Re: [lm-sensors] [PATCH 1/2] thermal: add hwmon sys I/F for thermal
Message-Id: <20080318104428.5c9d4996@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1203975102.10256.82.camel@acpi-hp-zz.sh.intel.com>
	<47DE6A24.7040705@hhs.nl>
	<20080317144811.12b7d6cb@hyperion.delvare>
	<200803180112.58655.lenb@kernel.org>
In-Reply-To: <200803180112.58655.lenb@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Len Brown <lenb@kernel.org>
Cc: Hans de Goede <j.w.r.degoede@hhs.nl>, "Zhang, Rui" <rui.zhang@intel.com>, linux-acpi <linux-acpi@vger.kernel.org>, lm-sensors <lm-sensors@lm-sensors.org>, Matthew Garrett <mjg59@srcf.ucam.org>, Thomas Renninger <trenn@suse.de>, "Thomas, Sujith" <sujith.thomas@intel.com>, "Mark M. Hoffman" <mhoffman@lightlink.com>, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Richard Hughes <hughsient@gmail.com>

On Tue, 18 Mar 2008 01:12:58 -0400, Len Brown wrote:
> While ACPI is currently the only customer of the generic thermal I/F,
> there is a future platform in the pipeline that has no ACPI
> and it too will use the generic thermal I/F.

A future platform that has no ACPI? Yeeehoooo! :)

(Sorry couldn't resist.)

> > (...)
> > Rui, Len, how did you originally envision the coexistence (or not) of
> > different types of thermal zones?
> 
> Right now we seem to be ACPI and then non-ACPI on different systems.
> However, I don't see any reason that both can't be on the same system.

OK, in this case this confirms that the current model (all thermal
zones in one hwmon device) is not correct.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Date: Thu, 20 Mar 2008 14:58:22 +0000
Subject: Re: [lm-sensors] [PATCH 1/2] thermal: add hwmon sys I/F for thermal
Message-Id: <20080320145822.GB5615@khazad-dum.debian.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1203975102.10256.82.camel@acpi-hp-zz.sh.intel.com> <47C3D04E.6090609@hhs.nl> <20080317133732.05b79f4d@hyperion.delvare> <47DE6A24.7040705@hhs.nl> <20080317144811.12b7d6cb@hyperion.delvare> <1205811952.3171.80.camel@acpi-hp-zz.sh.intel.com> <20080318110618.735572d2@hyperion.delvare>
In-Reply-To: <20080318110618.735572d2@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean Delvare <khali@linux-fr.org>
Cc: "Zhang, Rui" <rui.zhang@intel.com>, Hans de Goede <j.w.r.degoede@hhs.nl>, Len Brown <lenb@kernel.org>, linux-acpi <linux-acpi@vger.kernel.org>, lm-sensors <lm-sensors@lm-sensors.org>, Matthew Garrett <mjg59@srcf.ucam.org>, Thomas Renninger <trenn@suse.de>, "Thomas, Sujith" <sujith.thomas@intel.com>, "Mark M. Hoffman" <mhoffman@lightlink.com>, Richard Hughes <hughsient@gmail.com>

On Tue, 18 Mar 2008, Jean Delvare wrote:
> Maybe I have not been clear, but my question was not about the generic
> thermal driver itself. I understand that it's only adding an interface
> to other drivers and not creating anything new. My question was about
> thermal zones in general, i.e.: Do we expect systems to have more than
> one thermal zone type at a given time, or not? Len seems to think we do.

We do, unless we decide to emulate ACPI-style zones to hide that.

Thinkpads have at least two types *always*, for example.  EC ones, and the
ACPI ones... and there is some variable overlap between them.  And there are
at least four devices related to the thermal control (CPU, GPU, gig-E, fan),
of which one (fan) is systemic and works for all zones.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

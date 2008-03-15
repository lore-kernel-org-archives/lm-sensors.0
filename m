From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Date: Sat, 15 Mar 2008 04:25:06 +0000
Subject: Re: [lm-sensors] [PATCH 1/2] thermal: add hwmon sys I/F for	thermal
Message-Id: <20080315042506.GC4922@khazad-dum.debian.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1204072670.10256.111.camel@acpi-hp-zz.sh.intel.com> <200803120029.09505.lenb@kernel.org> <200803130109.45531.lenb@kernel.org> <1205405941.29877.341.camel@queen.suse.de> <20080313230919.GG30864@khazad-dum.debian.net> <1205485397.21619.35.camel@queen.suse.de>
In-Reply-To: <1205485397.21619.35.camel@queen.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Thomas Renninger <trenn@suse.de>
Cc: linux-acpi <linux-acpi@vger.kernel.org>, "Zhang, Rui" <rui.zhang@intel.com>, lm-sensors <lm-sensors@lm-sensors.org>, Hans de Goede <j.w.r.degoede@hhs.nl>, Len Brown <lenb@kernel.org>

On Fri, 14 Mar 2008, Thomas Renninger wrote:
> Ahh, I just checked that the module_init function calls the module_exit
> function...
> But the module_exit function probably because of this is not declared
> __exit.
> 
> This looks a bit uncommon. I don't know whether it should be avoided,
> but I cannot see why it should hurt.

Well, I didn't see a reason to duplicate code just to save a few hundred
bytes (if that much!) of text for those who don't use a modular
thinkpad-acpi...

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

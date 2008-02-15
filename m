From: Matthew Garrett <mjg59@srcf.ucam.org>
Date: Fri, 15 Feb 2008 11:56:15 +0000
Subject: Re: [lm-sensors] The new thermal management sysfs class, and hwmon
Message-Id: <20080215115614.GA31489@srcf.ucam.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20080203022622.GA995@khazad-dum.debian.net> <1202031072.3042.54.camel@acpi-sony.sh.intel.com> <20080203164410.GL20687@jupiter.solarsys.private> <20080203175006.GB9159@khazad-dum.debian.net> <05B550FD4BD2014E841D83547B626008029899FE@bgsmsx411.gar.corp.intel.com> <20080205135725.GO20687@jupiter.solarsys.private> <05B550FD4BD2014E841D83547B626008029BF29B@bgsmsx411.gar.corp.intel.com> <1202915450.7977.607.camel@queen.suse.de> <20080214140855.GB12412@srcf.ucam.org> <05B550FD4BD2014E841D83547B62600802AA6977@bgsmsx411.gar.corp.intel.com>
In-Reply-To: <05B550FD4BD2014E841D83547B62600802AA6977@bgsmsx411.gar.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Thomas, Sujith" <sujith.thomas@intel.com>
Cc: Thomas Renninger <trenn@suse.de>, "Mark M. Hoffman" <mhoffman@lightlink.com>, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, "Zhang, Rui" <rui.zhang@intel.com>, linux-acpi@vger.kernel.org, lm-sensors@lm-sensors.org, Jean Delvare <khali@linux-fr.org>, Len Brown <lenb@kernel.org>, Richard Hughes <hughsient@gmail.com>

On Fri, Feb 15, 2008 at 04:34:34PM +0530, Thomas, Sujith wrote:

> Len had mentioned in one of his responses that there is scope for
> evolving
> and we can do that. As you pointed out if there are 
> differences in the way temperatures are reported out, we can go ahead
> and
> fix it.

That's fine, but it *needs* to be done before 2.6.25 is released. 
Otherwise we're stuck with the broken one forever, which is somewhat 
longer than ideal.

-- 
Matthew Garrett | mjg59@srcf.ucam.org

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

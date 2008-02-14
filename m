From: Matthew Garrett <mjg59@srcf.ucam.org>
Date: Thu, 14 Feb 2008 14:08:55 +0000
Subject: Re: [lm-sensors] The new thermal management sysfs class, and hwmon
Message-Id: <20080214140855.GB12412@srcf.ucam.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20080203022622.GA995@khazad-dum.debian.net> <1202031072.3042.54.camel@acpi-sony.sh.intel.com> <20080203164410.GL20687@jupiter.solarsys.private> <20080203175006.GB9159@khazad-dum.debian.net> <05B550FD4BD2014E841D83547B626008029899FE@bgsmsx411.gar.corp.intel.com> <20080205135725.GO20687@jupiter.solarsys.private> <05B550FD4BD2014E841D83547B626008029BF29B@bgsmsx411.gar.corp.intel.com> <1202915450.7977.607.camel@queen.suse.de>
In-Reply-To: <1202915450.7977.607.camel@queen.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Thomas Renninger <trenn@suse.de>
Cc: "Thomas, Sujith" <sujith.thomas@intel.com>, "Mark M. Hoffman" <mhoffman@lightlink.com>, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, "Zhang, Rui" <rui.zhang@intel.com>, linux-acpi@vger.kernel.org, lm-sensors@lm-sensors.org, Jean Delvare <khali@linux-fr.org>, Len Brown <lenb@kernel.org>, Richard Hughes <hughsient@gmail.com>

On Wed, Feb 13, 2008 at 04:10:50PM +0100, Thomas Renninger wrote:

> Why do you want to still export the temperature via ACPI sysfs paths
> then?
> Once it is there and userspace progs make use of it, you will have to
> maintain it forever and HAL is getting crazy and must take care about:
>   - How to find the ACPI thermal node
>   - Find the hwmon node
>   - Both interfaces provide temeratures
>   - Parse different output of temperature values (totally crazy)
> 

Quite. There's still been no indication that anyone cares about fixing 
this interface, and I'm upset that it was merged despite there being 
clear and valid concerns about it. Do we have a commitment that it's 
going to be cleaned up before final? If not, it should be pulled before 
userspace starts depending on it. The only hardware where this currently 
matters isn't going to be running 2.6.25 anyway.

-- 
Matthew Garrett | mjg59@srcf.ucam.org

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

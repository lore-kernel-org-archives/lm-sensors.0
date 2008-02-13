From: Thomas Renninger <trenn@suse.de>
Date: Wed, 13 Feb 2008 15:10:50 +0000
Subject: Re: [lm-sensors] The new thermal management sysfs class, and hwmon
Message-Id: <1202915450.7977.607.camel@queen.suse.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <20080203022622.GA995@khazad-dum.debian.net>
	 <1202031072.3042.54.camel@acpi-sony.sh.intel.com>
	 <20080203164410.GL20687@jupiter.solarsys.private>
	 <20080203175006.GB9159@khazad-dum.debian.net>
	 <05B550FD4BD2014E841D83547B626008029899FE@bgsmsx411.gar.corp.intel.com>
	 <20080205135725.GO20687@jupiter.solarsys.private>
	 <05B550FD4BD2014E841D83547B626008029BF29B@bgsmsx411.gar.corp.intel.com>
In-Reply-To: <05B550FD4BD2014E841D83547B626008029BF29B@bgsmsx411.gar.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Thomas, Sujith" <sujith.thomas@intel.com>
Cc: "Mark M. Hoffman" <mhoffman@lightlink.com>, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, "Zhang, Rui" <rui.zhang@intel.com>, linux-acpi@vger.kernel.org, lm-sensors@lm-sensors.org, Jean Delvare <khali@linux-fr.org>, Len Brown <lenb@kernel.org>, Richard Hughes <hughsient@gmail.com>

On Wed, 2008-02-06 at 10:53 +0530, Thomas, Sujith wrote:
...

> I absolutely don't have any issue with this. I feel that's the way to
> go. Hwmon can roll out a patch which can report out temperature of
> thermal sensors which are connected to EC and which follows ACPI spec.

Why do you want to still export the temperature via ACPI sysfs paths
then?
Once it is there and userspace progs make use of it, you will have to
maintain it forever and HAL is getting crazy and must take care about:
  - How to find the ACPI thermal node
  - Find the hwmon node
  - Both interfaces provide temeratures
  - Parse different output of temperature values (totally crazy)


   Thomas


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

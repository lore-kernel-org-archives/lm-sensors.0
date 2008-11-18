From: Andreas Herrmann <andreas.herrmann3@amd.com>
Date: Tue, 18 Nov 2008 10:10:37 +0000
Subject: Re: [lm-sensors] [PATCH 1/2] k8temp warn about errata
Message-Id: <20081118101037.GB12127@alberich.amd.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <48E3F505.40401@assembler.cz>
In-Reply-To: <48E3F505.40401@assembler.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sun, Nov 09, 2008 at 08:56:54PM +0100, Rudolf Marek wrote:
> > If most but not all of these CPUs are affected, then it would make
> > sense to disable them by default but give the user a chance to still
> > enable them (using a module parameter.)
> 
> I tried hard to get this info from AMD. All versions are affected, but some may
> be fixed/not tested.

> > If there are more revision F and later CPUs with working thermal
> > diodes, and working ones can be told from non-working ones based on the
> > exact revision, we could implement blacklisting and/or whitelisting
> > base on the revision.
> 
> The errata is for all revs.

IMHO it is not possible to do blacklisting/whitelisting. CPU revision
guide for family 0xf says all models/steppgings of revG and revF CPUs
are affected by erratum 141.

> > Does anyone have an idea about the ratio of working/broken revision F
> > and later CPU models?
> 
> Dont sorry.

No idea (yet). Will see, whether it's possible to get additional information
about this.

   <snip>

> Andreas can you test please the second patch too? I'm especially curious if you
> see  the high limit when running sensors command.

What do you mean by "if you see the high limit when running sensors
command". (What lm_sensors version should I use? Any additional patches?)
I've patched lm_sensors on some of my test machines. With
that version I get for a dual socket machine following values.

fam10temp-pci-00c3
Adapter: PCI adapter
Core Temp:   +18 C

fam10temp-pci-00cb
Adapter: PCI adapter
Core Temp:   +14 C

Of course the temperature limit is shown in sysfs:

(family 0x11:)
neon ~ # find /sys -name temp1*
/sys/devices/pci0000:00/0000:00:18.3/temp1_input
/sys/devices/pci0000:00/0000:00:18.3/temp1_max
neon ~ # find /sys -name temp1* | xargs cat
56500
100000

(family 0x10:)
brandon sys # find /sys -name temp1*
/sys/devices/pci0000:00/0000:00:18.3/temp1_input
/sys/devices/pci0000:00/0000:00:18.3/temp1_max
/sys/devices/pci0000:00/0000:00:19.3/temp1_input
/sys/devices/pci0000:00/0000:00:19.3/temp1_max
brandon sys # find /sys -name temp1* | xargs cat
19000
70000
16500
70000

(and another family 0x10:)
attila #  find /sys -name temp1*
/sys/devices/pci0000:00/0000:00:18.3/temp1_input
/sys/devices/pci0000:00/0000:00:18.3/temp1_max
attila # find /sys -name temp1* | xargs cat
26125
70000


> Once second patch is in, I would like to rewrite the driver with the help of
> heuristic and put there more generic logic for "place/core" selectors and temp1_
> etc sysfs files creation logic.

BTW, what is the submission chain for hwmon -- especially k8temp?

  Is it "patch -> you -> Jean -> Linus"?



Regards,

Andreas



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

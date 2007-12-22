From: "Jean Delvare" <khali@linux-fr.org>
Date: Sat, 22 Dec 2007 11:21:41 +0000
Subject: Re: [lm-sensors] 2.6.24-rc4 hwmon it87 probe fails
Message-Id: <w9NvZsoO.1198322501.4301280.khali@gcu-squad.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <200712211200.30947.bjorn.helgaas@hp.com>
In-Reply-To: <200712211200.30947.bjorn.helgaas@hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: bjorn.helgaas@hp.com
Cc: Elvis Pranskevichus <el@prans.net>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Adrian Bunk <bunk@stusta.de>, Zhao Yakui <yakui.zhao@intel.com>, mhoffman@lightlink.com, Mike Houston <mikeserv@bmts.com>, Shaohua Li <shaohua.li@intel.com>, Adam Belay <ambx1@neo.rr.com>, lm-sensors@lm-sensors.org, Thomas Renninger <trenn@suse.de>, lenb@kernel.org


Hi Bjorn,

Le 21/12/2007, "Bjorn Helgaas" <bjorn.helgaas@hp.com> a =E9crit:

>On Tuesday 18 December 2007 10:59:18 am Jean Delvare wrote:
>> My initial idea was to identify the faulty motherboard using DMI and to
>> force pnpacpi=3Doff on the faulty motherboards. If this is considered too
>> aggressive, maybe we can just reject resource declarations that
>> intersect (but don't match) 0x290-0x297 for these motherboards. Either
>> way, we have to do something, and we have to do it quickly. 2.6.24
>> final isn't too far away, and more importantly, the patch that revealed
>> the problem has been backported to 2.6.23.10 so people are experiencing
>> regressions already.
>
>What do you think of something like the following patch?  If we do
>this, I don't think we'd need to force pnpacpi=3Doff or change the
>way PNP reserves resources.
>
>I'll be on vacation until about January 2, so I won't be able to
>do much with this until then.
>
>
>
>[patch] it87: request only Environment Controller ports
>
>The IT8705F and related parts are Super I/O controllers that contain
>many separate devices.
>
>Some BIOSes describe IT8705F I/O port usage under a motherboard device
>(PNP0C02) with overlapping regions, e.g., 0x290-0x29f and 0x290-0x294.
>
>The it87 driver supports only the Environment Controller, which requires
>only two ISA ports, but it used to request an eight-port range.  If that
>range exceeds a range reported by the BIOS, as 0x290-0x297 would, the
>request fails, and the it87 driver cannot claim the device.
>
>This patch makes the it87 driver request only the two ports used for the
>Environment Controller device.

The problem is that the IT87xxF chips do decode 4 ports (recent chips,
0x294-0x297) or 8 ports (older chips, 0x290-0x297), not 2 as the
datasheets say. The ITE Super-I/O chips differ from the Winbond
Super-I/O chips in this respect. The it87 driver only needs to access
ports 0x295 and 0x296, true, but the device itself decodes more
addresses than that. So, with this proposed patch, ports which are busy
will be shown as being free. This pretty much voids the point of
resource declarations, doesn't it? This might not cause too much
trouble in practice, but to me this still looks like the wrong way to go.

The resource declarations made by these motherboard BIOSes are totally
bogus. 0x290-0x29f is much larger than what the chip decodes.
0x290-0x294 is a subset that doesn't make any sense. The GA-K8N Ultra 9
is even funnier with 0x295-0x314, which again doesn't correspond to
anything real. All these happen to not intersect with 0x295-0x296 but I
wouldn't count on it. If Gigabyte (and possibly others) care that
little about these declarations, pretty much anything could be seen. So
while your proposed workaround happens to fix the problem at hand, it is
not really correct technically, and could break again soon.

I'd rather fix the problem at its source, or, as fixing it as the source
isn't very realistic in this case, as near of the source as possible.
That would mean DMI-based quirks for the affected motherboards, that
would discard or adjust the bogus resource declarations. I have not yet
looked at what the code would look like, as I am not familiar with the
pnp system driver, I don't know what it would take to implement my
proposal.

I also don't fully understand what pnpacpi is useful for. I have heard
about PCI drivers that might request resources that the motherboard
doesn't want them to touch, but I don't know the details, I also
don't know if it is a theoretical issue or if it really happens on some
systems, and I don't know if there are other uses for pnpacpi. I'm
asking because I want to know if forcing pnpacpi=3Doff on the faulty
motherboards would be good enough or if we really need finer-grained
quirks (assuming that we go the DMI-based quirks route at all.) The
former would obviously be easier.

>
>Systems where this problem has been reported:
>    Gigabyte GA-K8N Ultra 9
>    Gigabyte M56S-S3
>    Gigabyte GA-965G-DS3
> (...)

Thanks,
--
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

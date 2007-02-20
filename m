From: kronos.it@gmail.com (Luca Tettamanti)
Date: Tue, 20 Feb 2007 15:33:56 +0000
Subject: [lm-sensors] Could the k8temp driver be interfering with ACPI?
Message-Id: <68676e00702200733l6e7f13a5o201bc70fed98528b@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <45D5EA88.7090300@redhat.com> <45D6DDCE.5050803@assembler.cz>
	 <45D7461A.2040808@redhat.com>
	 <20070218183805.5a4fd813.khali@linux-fr.org>
	 <20070220151813.GA6581@srcf.ucam.org>
In-Reply-To: <20070220151813.GA6581@srcf.ucam.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Jean Delvare <khali@linux-fr.org>, linux-acpi@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>, Chuck Ebbert <cebbert@redhat.com>, lm-sensors@lm-sensors.org

On 2/20/07, Matthew Garrett <mjg59 at srcf.ucam.org> wrote:
> On Sun, Feb 18, 2007 at 06:38:05PM +0100, Jean Delvare wrote:
>
> > ACPI is broken here, not k8temp, so let's fix ACPI instead. ACPI
> > doesn't conflict with only k8temp, but with virtually all hardware
> > monitoring drivers, all I2C/SMBus drivers, and probably other types of
> > drivers too. We just can't restrict or blacklist all these drivers
> > because ACPI misbehaves.
>
> No, the simple fact of the matter is that if you're running on an ACPI
> platform you need to change some of your assumptions. ACPI owns the
> hardware. The OS doesn't. To an extent this has always been true on
> laptops and servers /anyway/ - the BIOS is free to have a wide variety
> of SMM insanity that invalidates basic assumptions like "If I hold this
> lock, nothing can interrupt me between this write and this read". That's
> simply not true.
>
> So this isn't about fixing ACPI. It's about trying to find a mechanism
> that allows ACPI and raw hardware drivers to coexist, which is made
> somewhat harder by it not being a situation that the platform designers
> have considered in the slightest.

Motherboard vendors usually provide tools for $(TheOtherOS) that can
read from all thermal  / fan / voltage / whatever sensors, so I guess
it's possible to make the ACPI driver and the "raw" one play nice with
each other[1].

Luca
[1] Unless their solution is "poke at the hardware and hope that ACPI
doesn't blow up", that is.


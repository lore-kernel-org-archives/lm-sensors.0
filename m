From: khali@linux-fr.org (Jean Delvare)
Date: Wed, 21 Feb 2007 14:59:46 +0000
Subject: [lm-sensors] Could the k8temp driver be interfering with ACPI?
Message-Id: <20070221155946.ff622cf9.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <45D5EA88.7090300@redhat.com>
	<45D6DDCE.5050803@assembler.cz>
	<45D7461A.2040808@redhat.com>
	<20070218183805.5a4fd813.khali@linux-fr.org>
	<20070220151813.GA6581@srcf.ucam.org>
	<68676e00702200733l6e7f13a5o201bc70fed98528b@mail.gmail.com>
In-Reply-To: <68676e00702200733l6e7f13a5o201bc70fed98528b@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Luca Tettamanti <kronos.it@gmail.com>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, linux-acpi@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>, Chuck Ebbert <cebbert@redhat.com>, lm-sensors@lm-sensors.org

Hi Luca,

On Tue, 20 Feb 2007 16:33:56 +0100, Luca Tettamanti wrote:
> Motherboard vendors usually provide tools for $(TheOtherOS) that can
> read from all thermal  / fan / voltage / whatever sensors, so I guess
> it's possible to make the ACPI driver and the "raw" one play nice with
> each other[1].
> 
> Luca
> [1] Unless their solution is "poke at the hardware and hope that ACPI
> doesn't blow up", that is.

Without the sources it's hard to tell. And all these applications are
vendor-specific, so if they indeed have ways to avoid conflicting
accesses between ACPI and the rest of the system, these ways are likely
to be vendor-specific as well, and not documented.

Either way, this means we need the support from hardware vendors to
solve this concurrent access problem, and unfortunately I doubt this
happens anytime soon :(

-- 
Jean Delvare


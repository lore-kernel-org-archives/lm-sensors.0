From: drstorm@data.pl (Marcin DrStorm Sliwinski)
Date: Sat, 10 Mar 2007 22:11:28 +0000
Subject: [lm-sensors] PC8374L SuperIO chip
Message-Id: <20070310231128.0b52ced0@beast>
List-Id: <lm-sensors.vger.kernel.org>
References: <20070310181650.33ed8ef7@beast>
In-Reply-To: <20070310181650.33ed8ef7@beast>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sat, 10 Mar 2007 22:57:46 +0100
Hans de Goede <j.w.r.degoede at hhs.nl> wrote:

> Writing a driver should be quite doable. My only concern is that this 
> chip breathes acpi / tastes like acpi. It very much seems designed to 
> make implementing acpi easy (thermal zones instead of sensors, etc).

Bad part is that ACPI on my board don't show any data about sensors, thermal zones or fans.
Probably it wasn't implemented in bios (AMI, worst bios i ever saw)
Even on my old Toshiba laptop i get at least cpu temperature from ACPI.

> So I'm afraid we might have some collisions with acpi here. Either way I 
> would like to write a little userspace test program (for starters) to 
> see if we can get some info out of the chip.

If You write it I will be very happy to test it.
Basic info about my box (I don't know if You need it)
CPU: Core 2 Duo
OS: Gentoo Linux 64bit with 2.6.20.2 kernel

Best regards
DrStorm
P.S. Sorry for my bad english
P.S.2 Sorry for private message. I simply hit Reply


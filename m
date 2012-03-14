From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Wed, 14 Mar 2012 19:11:48 +0000
Subject: Re: [lm-sensors] ERROR: could not insert 'w83627ehf': Device or resource busy
Message-Id: <1331752308.32717.70.camel@groeck-laptop>
List-Id: <lm-sensors.vger.kernel.org>
References: <4F60A0AA.2050107@gmail.com>
In-Reply-To: <4F60A0AA.2050107@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, 2012-03-14 at 15:01 -0400, David Kremer wrote:
> Guenter, I tested your module with the makefile I sent you.
> 
> Here is the result. I can't still load your module into my kernel.
> 
>   [42029.144832] nct6775: Found NCT6776F chip at 0x290
>   [42029.144852] ACPI: resource nct6775 [io 0x0295-0x0296] conflicts 
> with ACPI region HWRE [io 0x290-0x299]
>   [42029.144853] ACPI: If an ACPI driver is available for this device, 
> you should use it instead of the native driver
> 
> Tell me if you see something else than to force ACPI.

David,

that driver will (and can) not solve the acpi resource problem, so you
will still have to force-load it. It can only help with automatic fan
control (which, after being configured, runs automatically in the NCT
chip).

The problem with acpi vs. driver access is that there is no
synchronization between acpi accesses (through the bios) and linux
driver accesses. If both are active, there are potential access
conflicts, with unpredictable results. There is really nothing we can do
about that.

Guenter



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

From: "Darrick J. Wong" <djwong@us.ibm.com>
Date: Mon, 08 Mar 2010 19:30:15 +0000
Subject: Re: [lm-sensors] ACPI powermeter Invalid PMC data
Message-Id: <20100308193015.GE22820@tux1.beaverton.ibm.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Fri, Mar 05, 2010 at 08:13:13PM +0100, Oliver Niehoerster wrote:
> Dear Darrick Wong,
>
> I'm using the acpi_power_meter module of kernel 2.6.33 on Ubuntu 9.10.
> Linux 2.6.33 #4 SMP Fri Mar 5 18:51:10 CET 2010 x86_64 GNU/Linux
> [    0.007951] ACPI: Core revision 20091214
>
> I got this error message:
> [    1.211390] power_meter ACPI000D:00: power_meterInvalid _PMC data
> [    1.211490] power_meter: probe of ACPI000D:00 failed with error -14
>
> Do you know the problem? Have you an idea for solving the error?

It means that either ACPI isn't presenting meter data in the correct format, or
my code is buggy. :)

Send me a disassembly of the DSDT/SSDT tables and I can have a look.

[cc'ing mailing list]

--D

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

From: Guenter Roeck <linux@roeck-us.net>
Date: Mon, 27 May 2013 16:17:23 +0000
Subject: Re: [lm-sensors] ITE IT8518E supported in coreboot, helpful?
Message-Id: <20130527161723.GA14701@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <519F374B.3070101@gmail.com>
In-Reply-To: <519F374B.3070101@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, May 27, 2013 at 07:10:13AM +0200, Santi Villalba wrote:
> Hi Guenter,
> 
> On 24/05/13 19:34, Guenter Roeck wrote:
> >On Fri, May 24, 2013 at 11:47:55AM +0200, Santi Villalba wrote:
> >>This controller is giving people some trouble, as it is shipped in
> >>more and more laptops [1] and the fans can become quite annoying in
> >>these systems.
> >>
> >>In the past it was said that the main problem was the lack of a
> >>datasheet from ITE [2]. Recently there has been progress from the
> >>coreboot projects getting the info for quanta firmware on IT8518
> >>[3]. Can this particular file help with the lack of specs or it
> >>depends on other factors?
> >>http://review.coreboot.org/gitweb?p=coreboot.git;a=blob;f=src/ec/quanta/it8518/acpi/ec.asl;hu49fa283da69b9b1fca8589b1fc7f59fd30f7a4;hb~568559634199668859b7c662aea7f6b41f3920
> >>
> >I may be missing something, but my understanding is that the chip
> >has an embedded microcontroller (EC) which handles the actual fan
> >control. While the chip data sheet describes the hardware accessible
> >to the EC, and the API between CPU and EC, it does not describe
> >the logical interface between the two. Problem is that this
> >interface is not well defined and depends on the microcode
> >running on the EC.
> >
> >The file referenced above seems to provide that information for the
> >specific board and for the microcode running on the EC in that board
> >(which appears to be the referenced 'quanta' firmware). That does
> >not mean, however, that it would be the same for other boards,
> >including yours.
> >
> >A second potential problem is that the ACPI data provided above suggests
> >that the EC may be controlled through ACPI, which means that ACPI most
> >likely reserves the memory space needed to access the controller.
> >If this is the case in your system, which is quite likely, your best
> >option would be an ACPI driver.
> 
> That was my fearsome first guess. So I will look around a bit more
> to check if there is any spec available on the concrete EC firmware
> running clevo machines. If I find it I will try the ACPI driver
> route first.
> 
I don't think you need the firmware spec if ACPI is used. All you need to do is
to decode the ACPI table, check which accessors it provides, and write a driver
using those accessors. [1] should help. I don't know much about ACPI, so I won't
be able to help much further.

Looking through coreboot, there are lots of laptops using embedded controllers,
and for most if not all of them the access methods used are different.

Guenter

[1] http://smackerelofopinion.blogspot.com/2009/10/dumping-acpi-tables-using-acpidump-and.html

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

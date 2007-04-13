From: Pavel Machek <pavel@ucw.cz>
Date: Fri, 13 Apr 2007 20:07:46 +0000
Subject: Re: [lm-sensors] Could the k8temp driver be interfering with ACPI?
Message-Id: <20070413200746.GD28264@elf.ucw.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <45D5EA88.7090300@redhat.com> <20070302114023.GD2163@elf.ucw.cz> <20070302150313.198b6053.khali@linux-fr.org> <200704131218.44045.bjorn.helgaas@hp.com>
In-Reply-To: <200704131218.44045.bjorn.helgaas@hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: Jean Delvare <khali@linux-fr.org>, Chuck Ebbert <cebbert@redhat.com>, Rudolf Marek <r.marek@assembler.cz>, linux-acpi@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>, lm-sensors@lm-sensors.org

Hi!

> > ... The primary issue is the concurrent access
> > to resources, which cause lots of trouble which are hard to investigate.
> > If ACPI reserves the ports, then the SMBus or hardware monitoring
> > drivers (or any other conflicting driver) will cleanly fail to load,
> > which would be a move in the right direction. ...
> > 
> > So, can ACPI actually reserve the ports it accesses?
> 
> Sorry to join this discussion so late.
> 
> ACPI tells us the resources used by devices.  Today, we don't
> reserve

Problem seems to be that ACPI does _not_ tell us which ports it
accesses from AML code.

But we already found a lock we can take; AFAICT we know how to solve
this problem.
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

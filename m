From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Date: Sun, 15 Apr 2007 20:31:41 +0000
Subject: Re: [lm-sensors] Could the k8temp driver be interfering with ACPI?
Message-Id: <200704151431.41503.bjorn.helgaas@hp.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <45D5EA88.7090300@redhat.com> <200704131459.45867.bjorn.helgaas@hp.com> <20070415114159.05026483@hyperion.delvare>
In-Reply-To: <20070415114159.05026483@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean Delvare <khali@linux-fr.org>
Cc: Pavel Machek <pavel@ucw.cz>, Chuck Ebbert <cebbert@redhat.com>, Rudolf Marek <r.marek@assembler.cz>, linux-acpi@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>, lm-sensors@lm-sensors.org

On Sunday 15 April 2007 03:41, Jean Delvare wrote:
> On Fri, 13 Apr 2007 14:59:45 -0600, Bjorn Helgaas wrote:
> > Of course, there are always BIOS defects.  But if we could make a
> > case that a BIOS that doesn't declare the resources used by the AML
> > is defective, we could add quirks to reserve the undeclared resources.
> 
> Only realistic if the list of systems needing a quirk is small. Do you
> think that would be the case?

I don't know.  I confess that I don't clearly understand the problem
yet.  It sounds like the sensor drivers want to talk to hardware that
ACPI methods might also use.

But I missed the details, such as the specific devices in question,
which ports they use, how they are described in ACPI, which AML
methods use those ports, and which non-ACPI drivers also use them.

It also sounds like the non-ACPI drivers provide much more
functionality than ACPI exposes.  I'd like to understand this,
too, because an  obvious way to solve the problem would be to
drop the non-ACPI drivers.  Is this extra functionality available
on Windows?  If so, do we know whether Windows uses non-ACPI drivers
or whether they have some smarter way to use ACPI?  In the long
run, I think the easiest, most reliable route would be to use the
system in a similar way.  Then we'd be doing things the way the
manufacturer intended and we'd take advantage of all the Windows-
focused firmware testing.

Bjorn

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

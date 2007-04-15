From: "Luca Tettamanti" <kronos.it@gmail.com>
Date: Sun, 15 Apr 2007 20:59:00 +0000
Subject: Re: [lm-sensors] Could the k8temp driver be interfering with ACPI?
Message-Id: <68676e00704151359g18bf6935wcb2144bcbcf4edd2@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <45D5EA88.7090300@redhat.com>
	 <200704131459.45867.bjorn.helgaas@hp.com>
	 <20070415114159.05026483@hyperion.delvare>
	 <200704151431.41503.bjorn.helgaas@hp.com>
In-Reply-To: <200704151431.41503.bjorn.helgaas@hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: Jean Delvare <khali@linux-fr.org>, Pavel Machek <pavel@ucw.cz>, linux-kernel <linux-kernel@vger.kernel.org>, lm-sensors@lm-sensors.org, linux-acpi@vger.kernel.org, Chuck Ebbert <cebbert@redhat.com>

On 4/15/07, Bjorn Helgaas <bjorn.helgaas@hp.com> wrote:
> On Sunday 15 April 2007 03:41, Jean Delvare wrote:
> > On Fri, 13 Apr 2007 14:59:45 -0600, Bjorn Helgaas wrote:
> > > Of course, there are always BIOS defects.  But if we could make a
> > > case that a BIOS that doesn't declare the resources used by the AML
> > > is defective, we could add quirks to reserve the undeclared resources.
> >
> > Only realistic if the list of systems needing a quirk is small. Do you
> > think that would be the case?
>
> I don't know.  I confess that I don't clearly understand the problem
> yet.  It sounds like the sensor drivers want to talk to hardware that
> ACPI methods might also use.

Exactly.

> But I missed the details, such as the specific devices in question,
> which ports they use, how they are described in ACPI, which AML
> methods use those ports, and which non-ACPI drivers also use them.

The original report was about the temperature sensors of K8 cpus. It
happens that ACPI reads the sensors while the linux driver is using it
and gets garbage (and shut down the system). The problem is more
generic though, and applies to all hardware monitoring chips for which
a driver exists.

> It also sounds like the non-ACPI drivers provide much more
> functionality than ACPI exposes.  I'd like to understand this,
> too, because an  obvious way to solve the problem would be to
> drop the non-ACPI drivers.

Problem is that ACPI may access the sensors anyway (e.g. via SMM).

> Is this extra functionality available
> on Windows?  If so, do we know whether Windows uses non-ACPI drivers
> or whether they have some smarter way to use ACPI?

Usually ACPI exposes 1 or 2 temperature readings (CPU and
motherboard), while the hw driver can also provide fans and voltages
measurements.

Vendors usually provides a monitoring utility for Win that also
exposes these information. It's not known whether there's a way to
avoid conflicting accesses between ACPI and the raw driver; it's
possible that it's vendor-specific and not documented.

Luca

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

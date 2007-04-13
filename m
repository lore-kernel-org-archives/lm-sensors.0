From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Date: Fri, 13 Apr 2007 18:18:43 +0000
Subject: Re: [lm-sensors] Could the k8temp driver be interfering with ACPI?
Message-Id: <200704131218.44045.bjorn.helgaas@hp.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <45D5EA88.7090300@redhat.com> <20070302114023.GD2163@elf.ucw.cz> <20070302150313.198b6053.khali@linux-fr.org>
In-Reply-To: <20070302150313.198b6053.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean Delvare <khali@linux-fr.org>
Cc: Pavel Machek <pavel@ucw.cz>, Chuck Ebbert <cebbert@redhat.com>, Rudolf Marek <r.marek@assembler.cz>, linux-acpi@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>, lm-sensors@lm-sensors.org

On Friday 02 March 2007 07:03, Jean Delvare wrote:
> ... The primary issue is the concurrent access
> to resources, which cause lots of trouble which are hard to investigate.
> If ACPI reserves the ports, then the SMBus or hardware monitoring
> drivers (or any other conflicting driver) will cleanly fail to load,
> which would be a move in the right direction. ...
> 
> So, can ACPI actually reserve the ports it accesses?

Sorry to join this discussion so late.

ACPI tells us the resources used by devices.  Today, we don't reserve
ACPI resources until a driver claims a device.  PCI does some sort of
reservation up front, before the driver claims devices.  Conceptually,
I think ACPI should do the same thing, and I don't think it's that
hard to do.

But breaking things like lmsensors would make the transition painful.

Bjorn

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

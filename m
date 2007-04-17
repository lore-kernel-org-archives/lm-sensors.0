From: "Luca Tettamanti" <kronos.it@gmail.com>
Date: Tue, 17 Apr 2007 23:50:29 +0000
Subject: Re: [lm-sensors] Could the k8temp driver be interfering with ACPI?
Message-Id: <68676e00704171650t604e30f4j3749b7c5a8ddc5c5@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <45D5EA88.7090300@redhat.com>
	 <200704151857.03115.bjorn.helgaas@hp.com>
	 <20070416211411.GA16150@dreamland.darkstar.lan>
	 <200704161628.47707.bjorn.helgaas@hp.com>
In-Reply-To: <200704161628.47707.bjorn.helgaas@hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: Jean Delvare <khali@linux-fr.org>, Pavel Machek <pavel@ucw.cz>, linux-kernel <linux-kernel@vger.kernel.org>, lm-sensors@lm-sensors.org, linux-acpi@vger.kernel.org, Chuck Ebbert <cebbert@redhat.com>

On 4/17/07, Bjorn Helgaas <bjorn.helgaas@hp.com> wrote:
> On Monday 16 April 2007 15:14, Luca Tettamanti wrote:
> > Problem is that ACPI methods are not documented at all (how am I
> > supposed to know that "G6T6" is the reading of the 12V rail?) while the
> > datasheet of hw monitoring chips (w83627ehf in my case) are public (more
> > or less).
>
> Yes, I see that it's attractive to use a single w83627ehf.c driver.
> For an ACPI driver, we'd have to build a list of PNP IDs, and possibly
> information about which methods read which information.  That's
> certainly more work.
>
> On the other hand, the ACPI driver would avoid the synchronization
> issues that started this whole thread.  That's a pretty compelling
> advantage.
>
> > Furthermore, sensor driver exposes all the reading of the chip
> > (e.g. in the DSDT I can't find the VSB or battery voltage).
>
> Maybe Asus didn't hook up those readings on the board.  I would
> guess that PC Probe doesn't expose the VSB or battery voltage either.

PC Probe does not. But the lines are wired and the readings (from
Linux) are sensible.

> I'm sure you've seen these:
>   http://lists.lm-sensors.org/pipermail/lm-sensors/2005-October/014050.html
>   http://www.lm-sensors.org/wiki/AsusFormulaHacking

Actually I haven't, I've happily ignored ACPI until now ;-) My DSDT
doesn't look too bad, I may give it a try...

Luca

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

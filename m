From: Alistair John Strachan <alistair@devzero.co.uk>
Date: Sun, 06 Sep 2009 14:41:05 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (abituguru3) Support multiple DMI
Message-Id: <200909061541.05356.alistair@devzero.co.uk>
List-Id: <lm-sensors.vger.kernel.org>
References: <1252170780-4141-1-git-send-email-alistair@devzero.co.uk>
In-Reply-To: <1252170780-4141-1-git-send-email-alistair@devzero.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Rune,

(Fixed CCs)

On Sunday 06 September 2009 15:15:58 Rune Svendsen wrote:
> On Sun, 2009-09-06 at 14:03 +0200, Jean Delvare wrote:
> [snip]
> 
> > > @@ -947,7 +951,7 @@ static int __devinit abituguru3_probe(struct
> > > platform_device *pdev) "ID: %04X\n", (unsigned int)id);
> > >
> > >  #ifdef CONFIG_DMI
> > > -	if (!abituguru3_motherboards[i].dmi_name) {
> > > +	if (!abituguru3_motherboards[i].dmi_name[0]) {
> > >  		printk(KERN_WARNING ABIT_UGURU3_NAME ": this motherboard was "
> > >  			"not detected using DMI. Please send the output of "
> > >  			"\"dmidecode\" to the abituguru3 maintainer "
> >
> > This test is no longer as perfect as it used to be. Now that you admit
> > that each ID can correspond to more than one board model, it is
> > possible that the board was _not_ detected using DMI but this message
> > will not show (because another board with this ID is already known.)
> > While this is not a blocker, I still think it would be worth improving.
> >
> > Maybe I am missing something obvious, but why isn't this message
> > printed in abituguru3_dmi_detect() directly? This would be more
> > efficient and more elegant too IMHO.
> 
> After speaking with Alistair I've been thinking about this as well.
> Right now, when I'm running a kernel that doesn't support inserting the
> abituguru3 module without using the "force=1" option (a kernel to which
> this patch has not been applied), I don't receive a message in my kernel
> log about sending the output of "dmidecode" - precisely because of what
> you mention here.

There's a bit of history associated with the DMI message. Before I added DMI 
support to the driver the legacy probe method (which doesn't really work at 
all on IP35 Pro) was used to detect the other 20-or-so supported mainboards.
On a lot of the boards in this list, this detection is reliable, and the 
message I added was a useful helper to get people to send in their DMI info.

Unfortunately your case has fallen through the cracks of obscurity where both 
DMI was broken (because of a bug) and legacy probing didn't work (because it 
doesn't work on IP35 Pro). You board appears to the driver to be just like any 
other unsupported hardware.

You're right that it's suboptimal there are no kernel messages displayed, but 
consider the distro/script case where driver loading may be attempted 
automatically on unsupported hardware. In this case it is customary for Linux 
drivers to reject the modprobe with -ENODEV but *not* print a message. 
Printing a verbose one about sending DMI info to the uguru maintainer would 
certainly not be desirable!

So yes, it's not perfect, and maybe we could improve it a la "if it's an Abit 
board, the message could be printed" but anything you do is really just a 
heuristic.

-- 
Cheers,
Alistair.

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

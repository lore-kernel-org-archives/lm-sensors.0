From: daniel.n.nilsson@home.se (Daniel Nilsson)
Date: Sun, 08 Jan 2006 14:31:59 +0000
Subject: [lm-sensors] Kernel hangs with i2c-i801 driver?
Message-Id: <20060108143158.GA12697@dnil.se>
List-Id: <lm-sensors.vger.kernel.org>
References: <20051123100021.GA29473@oden.homeip.net>
In-Reply-To: <20051123100021.GA29473@oden.homeip.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi All,

On Sat, Jan 07, 2006 at 09:42:44PM +0100, Rudolf Marek wrote:
> OK thanks. I'm just curious how did you contact them via standard
> support for on their pages?  Maybe you have some VIP support?

No, just standard support... I'm surprised to get an answer actually,
which probably speaks more about my low expectations on these kinds of
support sites;

http://tw.giga-byte.com/Company/ContactUs/contact_us.htm


> > After shutting off that bit 14 for enabling SMI on GPIO7 that machine
> > does not hang any longer! I've tried a couple things that used to make
> > the machine hang and none of them did any harm any longer! To prove
> > that a different way I re-enabled that bit again using 
> > 
> > setpci -s 00:1f.0 b8.l014000
> > 
> > which caused the machine to hang right away (ie, the setpci command
> > didn't return). Looks like we might have a workaround!
> 
> Perhaps the SMI was already asserted so it just went through when it was enabled.

Yes, that is my theory as well.

> 
> I have developed a quirk to linux kernel. Please see the
> attachment. It compiles and thats all I know ;) If it works you
> should see in kernel syslog/messages that the Gigabyte motherboard
> was detected (see the code for actual messages)

Well I can tell that is works too! 

dmesg | grep -i giga
Gigabyte GA-4MXSV motherboard detected:<4>Disabling SMI routing from W83792D.

While looking for this I also noticed that the following quirk is
activated on this motherboard:

PCI: PXH quirk detected, disabling MSI for SHPC device

But I concluded that MSI in this regard is the interrupt handling used
on PCI-Express which should be completely irrelevant to the problems
we have been debugging here.

> If it produces correct message please try to hang it again. If it
> produces correct message and hangs I missed something in the PCI
> handling routine. (But I think it should be OK)

It works fine, it is detected and bit 14 is cleared. The machine does
not hang any longer.

> The patch is against 2.6.15 but it should work with earlier versions too.
> It will work in both 32 bit and 64bit kernel mode.

I used it against 2.6.14 to not introduce a new kernel version in the
mix. Applied and compiled just fine.

> Lycka till ;)

Tack s? mycket f?r hj?lpen :-)

Now this pretty much solved this issue for me, but I'm wondering if we
should give Gigabyte a week or two to respond to my request to have
them debug the root cause? If they don't want to do that I guess we
could consider this patch to be required in order to use the sensor
devices on this motherboard....

Best Reagards
-- 
Daniel Nilsson


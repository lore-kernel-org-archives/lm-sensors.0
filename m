From: r.marek@sh.cvut.cz (Rudolf Marek)
Date: Sat, 07 Jan 2006 20:42:44 +0000
Subject: [lm-sensors] Kernel hangs with i2c-i801 driver?
Message-Id: <43C027C4.9030906@sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <20051123100021.GA29473@oden.homeip.net>
In-Reply-To: <20051123100021.GA29473@oden.homeip.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi all,

> Back from vacationing, time to get this issue resolved :-)
Good.

> Sounds like I should put some pressure on Gigabyte to fix the route
> cause, I don't think we will be able to do so but since this is a
> server motherboard one would think the Gigabyte should be interested
> in fixing the root cause... I'll try and let you all know how that goes.
>

OK thanks. I'm just curious how did you contact them via standard support for on their pages?
Maybe you have some VIP support?
> So setpci seems to work:
Good.
> After shutting off that bit 14 for enabling SMI on GPIO7 that machine
> does not hang any longer! I've tried a couple things that used to make
> the machine hang and none of them did any harm any longer! To prove
> that a different way I re-enabled that bit again using 
> 
> setpci -s 00:1f.0 b8.l014000
> 
> which caused the machine to hang right away (ie, the setpci command
> didn't return). Looks like we might have a workaround!

Perhaps the SMI was already asserted so it just went through when it was enabled.

> 
> The output of dmidecode and lspci -v -v -v is attached since it is
> rather long. 
> 

Good thanks.

> oden:~# dmidecode
OT: Gods should not have broken SMI...

I have developed a quirk to linux kernel. Please see the attachment. It compiles and thats all I know ;)
If it works you should see in kernel syslog/messages that the Gigabyte motherboard was detected (see the code for
actual messages)

If it produces correct message please try to hang it again. If it produces correct message and hangs I missed something
in the PCI handling routine. (But I think it should be OK)

If you cant see any message it means that the DMI detection is not working. Please look to dmi.h file and
find a combination that works for you (hint: use the dmidecode output to get values)
(for example leave only the manufacturer field or try different macro DMI_MATCH(something else here)

The patch is against 2.6.15 but it should work with earlier versions too.
It will work in both 32 bit and 64bit kernel mode.

Lycka till ;)

Thanks,

Regads
Rudolf
-------------- next part --------------
An embedded and charset-unspecified text was scrubbed...
Name: giga_smi
Url: http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20060107/0a70dfe1/giga_smi.pl

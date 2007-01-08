From: christophe.dr@free.fr (Christophe de =?iso-8859-1?q?Rivi=E8re?=)
Date: Mon, 08 Jan 2007 07:39:25 +0000
Subject: [lm-sensors]
Message-Id: <200701080839.31792.christophe.dr@free.fr>
List-Id: <lm-sensors.vger.kernel.org>
References: <87ekb9s3tn.wl%info@wore.ma.cx>
In-Reply-To: <87ekb9s3tn.wl%info@wore.ma.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Le Dimanche 7 Janvier 2007 15:30, Rudolf Marek a ?crit?:
> Hello,
>
> > But now that i want to jump to a newer distro, none of them is able to
> > detect this smbus in spite of the quirks (see above) that is present in
> > the kernel : $ cat /usr/src/linux/drivers/pci/quirks.c |grep -i w1
> >                         case 0x184b: /* W1N notebook */
> > The same lack occured occured on ubuntu 6.10 , suse 10.1, mandriva 2007
> > and suse 10.2 with recent kernels ranging from 2.6.16 to 2.6.18 . No
> > smbus is appears on the lspci for any of these distro.
> >[...]
> Answer is simple. There were some problems with suspend resume, when the
> smbus was enabled. (from 2.6.17-2.6.19) It is fixed in 2.6.20. You need to
> disable the ACPI sleep support to re-enable the quirk. I guess it is not
> what you want.
> http://www.lm-sensors.org/browser/lm-sensors/trunk/prog/hotplug/unhide_ICH_
>SMBus?format=raw

You are simply great ! It simply worked like a charm this morning on a suse 
10.2 and i suppose it will work on any other distro. !

> > The sensor monitor and fan speed control is a very interesting featur[...]
>
> Please can you attach the DSDT table to your mail?
>
> cat /proc/acpi/dsdt > /tmp/dsdt.bin

Attached to this email.

> Rudolf

Thanks again for your generous help !!!

-- 
christophe
-------------- next part --------------
A non-text attachment was scrubbed...
Name: dsdt
Type: application/octet-stream
Size: 27981 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20070108/827fafb3/attachment-0001.obj 
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 191 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20070108/827fafb3/attachment-0001.bin 

From: christophe.dr@free.fr (Christophe de =?iso-8859-1?q?Rivi=E8re?=)
Date: Sun, 14 Jan 2007 20:41:47 +0000
Subject: [lm-sensors] No smbus on asus w1n laptop in spite of quirk > no
Message-Id: <200701142141.52752.christophe.dr@free.fr>
List-Id: <lm-sensors.vger.kernel.org>
References: <200701071107.50461.christophe.dr@free.fr>
In-Reply-To: <200701071107.50461.christophe.dr@free.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Le Dimanche 14 Janvier 2007 19:26, Rudolf Marek a ?crit?:
> >[...]
> >> Please can you attach the DSDT table to your mail?
> >> cat /proc/acpi/dsdt > /tmp/dsdt.bin
> >
> > Attached to this email.
>
> Careful your DSDT bytecode contains SMBUS access functions! Do not load the
> thermal module from ACPI. (the code does not use the HW semaphore)
>
> There is some ASUS mutex called P4SM in ACPI namespace but it seems that it
> is this board specific.
>
> Rudolf

Ah..!? On kubuntu 6.10, i use ksensors and it seems that it can monitor 
temperature from acpi and from lm_sensors. Both lm85 and thermal modules are 
loaded. The 2 temperatures are consistent : they are almost the same. And i 
had no crash.
And, i don't have yet ksensors on suse 10.2 but both thermal and lm85 modules 
are loaded and no crash detected.
What is the risk ?

-- 
christophe
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 191 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20070114/f7af6bf5/attachment.bin 

From: r.marek@assembler.cz (Rudolf Marek)
Date: Sun, 07 Jan 2007 14:30:46 +0000
Subject: [lm-sensors] No smbus on asus w1n laptop in spite of quirk >
Message-Id: <45A10416.1020503@assembler.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <200701071107.50461.christophe.dr@free.fr>
In-Reply-To: <200701071107.50461.christophe.dr@free.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello,

> But now that i want to jump to a newer distro, none of them is able to detect 
> this smbus in spite of the quirks (see above) that is present in the kernel :
> $ cat /usr/src/linux/drivers/pci/quirks.c |grep -i w1
>                         case 0x184b: /* W1N notebook */
> The same lack occured occured on ubuntu 6.10 , suse 10.1, mandriva 2007 and 
> suse 10.2 with recent kernels ranging from 2.6.16 to 2.6.18 . No smbus is 
> appears on the lspci for any of these distro.
> I reported this problem here :
> http://www.suseforums.net/index.php?showtopic%980
> http://qa.mandriva.com/show_bug.cgi?id%281
> But i had no answers.

Answer is simple. There were some problems with suspend resume, when the smbus
was enabled. (from 2.6.17-2.6.19) It is fixed in 2.6.20. You need to disable the
ACPI sleep support to re-enable the quirk. I guess it is not what you want.

However you are lucky, I developed yesterday a simple bash script which will
re-enable the bus for you.

Check it here:
http://www.lm-sensors.org/browser/lm-sensors/trunk/prog/hotplug/unhide_ICH_SMBus?format=raw

download, run as root. You are done. Now you can access the bus again.

> The sensor monitor and fan speed control is a very interesting feature on this 
> laptop for battery saving reasons.
> I'd be really glad if someone could help .
> Or please someone point me to a better place to report this problem.

Please can you attach the DSDT table to your mail?

cat /proc/acpi/dsdt > /tmp/dsdt.bin

Rudolf


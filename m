From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 02 Nov 2008 20:22:04 +0000
Subject: Re: [lm-sensors] GM965 IGP temperature detector
Message-Id: <20081102212204.3e036a7d@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <73511e6c0810260733h27877c9o25dd5c346a97e9c2@mail.gmail.com>
In-Reply-To: <73511e6c0810260733h27877c9o25dd5c346a97e9c2@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sun, 26 Oct 2008 14:33:47 +0000, lu zhihe wrote:
> Dear all:
> 
>        I just write a little tool to detect my GM965 IGP's temperatue, it
> bases on coreboot's inteltool.
>        Several people try it ,and it seems work.
>        Do you think it can be adapt to Lm-sensors ?
>        It just use PCI read/write, maybe don't fall on i2c,isa or acpi bus.

Yes, it should be easy to adapt to lm-sensors, all you need to do is
move the code to a Linux kernel driver and add sysfs attributes to
export the temperature to users-space.

The fact that this is a PCI device isn't a problem at all, we already
have several hwmon drivers for PCI devices: k8temp, sis5595, via686a,
vt8231 and, I believe, i5k_amb.

>       The code is here:
> 
> http://www.coreboot.org/pipermail/coreboot/attachments/20081026/0f52e1e7/attachment-0001.gz
> 
>       It's format is tar.gz

A couple notes:

* You make use of PCI_FILL_CLASS while as far as I can tell you don't
need it. This prevents your tool from building with older pci header
files so you may want to stop using it.

* On my laptop with an ICH7, the tool reports "Your GPU temperature is
under 40 degrees Centigrade". This laptop has an ATI Radeon graphics
chip so the Intel IGP isn't used. So I am curious if the value returned
by your tool is meaningful or not?

* Note that the correct unit name is degree Celsius, not degree
Centigrade.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

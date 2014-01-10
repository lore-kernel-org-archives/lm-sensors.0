From: Phil Perry <phil@pendre.co.uk>
Date: Fri, 10 Jan 2014 16:03:08 +0000
Subject: Re: [lm-sensors] ASUS KGPE-D16 and CentOS 6.5
Message-Id: <52D019BC.5070302@pendre.co.uk>
List-Id: <lm-sensors.vger.kernel.org>
References: <E4175F3D57744A468314267E51135306@W710>
In-Reply-To: <E4175F3D57744A468314267E51135306@W710>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 09/01/14 22:24, Seth Bardash wrote:
> Jean,
>
> That did it.
>
> New i2c-piix4 driver plus w83795 driver and the previously
> mentioned addition to the /etc/sensors3.conf now has all the
> sensors working.
>
> The CPU sensors seem a bit low but the extra thermocouples
> included with the motherboard are reading right on.
> Now I will know if the machine has a fan failure or cooling is
> bad.
>
> Thanks very much for your help.
> If you want I can post exactly what was done so that CentOS 6.5
> support for the ASUS KGPE-D16 is documented.
>
> Best Regards,
>
> Seth Bardash
>


Seth,

elrepo.org is a community repository providing kernel-ABI tracking RPM 
packages for RHEL (and CentOS) to provide additional (backported) 
hardware support for unsupported devices in RHEL. The advantage of kABI 
tracking kmod packages is that they don't need to be recompiled against 
each new kernel and thus work seamlessly against each RHEL/CentOS kernel 
update.

If you like I can assist with packaging and maintaining these backported 
drivers for RHEL/CentOS (or I can assist you in maintaining them should 
you prefer). Please feel free to head over to the elrepo.org mailing 
list or bug tracker (registration required) and drop us a line.

Regards,

Phil



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

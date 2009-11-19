From: Hans de Goede <j.w.r.degoede@hhs.nl>
Date: Thu, 19 Nov 2009 09:56:29 +0000
Subject: Re: [lm-sensors] ipmisensors module ported to 2.6.29
Message-Id: <4B05164D.9070506@hhs.nl>
List-Id: <lm-sensors.vger.kernel.org>
References: <1258584180.8521.102.camel@pharper_desktop.arrs.arrisi.com>
In-Reply-To: <1258584180.8521.102.camel@pharper_desktop.arrs.arrisi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

On 11/18/2009 11:43 PM, Paul Harper wrote:
> I have ported the ipmisensors module to kernel version 2.6.29 and
> corrected the issues with fatal errors on loading and swizzling of
> device data.  On my IBM development platform (3650) the module now works
> as expected and data from ipmitool and lm-sensors is in sync.
>
> I then did a test on a SuperMicro chassis and the module could not
> connect to the bmc.  ipmitool works as expected on the SuperMicro.  In
> examination of the ipmitool code, it appears that they have moved to
> IPMB comms rather than a direct connect to the BMC.
>
> Before I start changing ipmisensors to use IPMB comms, is there another
> preferred module to use when exposing sensors to lm-sensors and the
> vendor provides impi support?
>

This is just my 2 cents, so before you actually act on this, it would be
good to get a second opinion, say Jean Delvare's .

Given that there already are various userspace options to reading ipmi
sensors, which I assume work as non root (iow no direct io banging). An
alternative to using a kernel driver might be the extend libsensors
to be able to read sensor info from other sources then the hwmon
sysfs interface.

what I envision is:
1) abstraction of sensor source enumeration and reading in libsensors
2) a plugin architecture to add support for different sensor sources
3) Various plugins for example:
    hwmon sysfs (of course)
    something to read harddisk temps using smart
    code to read ipmi info

I think this would be really nice to have as currently many applications
have support for both libsensors and have separate code for things like
harddisks temps, etc. libsensors seems like a logical place to consolidate
this.

I must warn though, that this will require some surgery to libsensors, it was
never designed to do this.

If you are willing to spend effort on this, I would be happy to help were I
can!

Regards,

Hans

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

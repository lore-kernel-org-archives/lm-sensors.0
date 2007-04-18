From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 18 Apr 2007 08:06:54 +0000
Subject: Re: [lm-sensors] Compiling device drivers without compiling the
Message-Id: <20070418100654.6837e4ac@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <461685C1.6050904@physics.ucsd.edu>
In-Reply-To: <461685C1.6050904@physics.ucsd.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Terrence,

On Fri, 06 Apr 2007 10:39:13 -0700, Terrence Martin wrote:
> I have a Centos 4.4 system, and I was wondering if it is possible or if 
> there are instructions for compiling the drivers for sensors that did 
> not come stock with the centos kernel? I found the k8temp online, 
> unfortunately the kernel complains the module is in the wrong format.

It is possible, but in fact the compilation step isn't really the
problem. You'll have to backport the driver to your older kernel first,
and that's the most difficult part, especially as the version
difference between kernels increases.

Assuming that Centos 4.4 is using a 2.6.9 kernel, you will have a hard
time backporting the k8temp driver, because kernels up to 2.6.13 assume
that sensors are on the I2C bus, while the K8 sensors show as a PCI
device. You'd need to convert the k8temp to an i2c-isa driver or
something similar. Whatever you do it'll be ugly and very different
from the original driver.

The simple truth is that you can't stick to a 3-year-old kernel and
expect brand new hardware and drivers to work on it without lots of
efforts.

> The related question is there any docs out there for getting lm sensors 
> with newer sensors working on RHEL4.x based systems (eg. Centos?).

Not that I know of, nor do I think such documentation is really needed.
You need to backport the new driver to your older kernel, and to upgrade
the user-space tools to a version that includes support for that
driver. This is a generic driver backporting procedure, not really
lm-sensors specific.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

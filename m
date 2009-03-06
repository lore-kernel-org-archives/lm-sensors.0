From: Jean Delvare <khali@linux-fr.org>
Date: Fri, 06 Mar 2009 08:14:18 +0000
Subject: Re: [lm-sensors] Building sensor drivers outside the kernel tree
Message-Id: <20090306091418.3f0e5306@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <49AAFDC8.20607@gmx.de>
In-Reply-To: <49AAFDC8.20607@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hallo Reinhard,

On Sun, 01 Mar 2009 22:27:36 +0100, Reinhard Nissl wrote:
> is there a chance to compile for example Asus atk0110 driver for
> my distros default kernel?

No, this is not possible. You could compile the atk0110 driver itself
easily, however it requires a hook in the ACPI subsystem which is
missing in standard kernels. So unfortunately you need to rebuild your
kernel for this part.

> I'd like to stay with openSUSE-11.1's kernel-default-2.6.27.19-3.2.1.
> 
> I'm used to build modules outside of the kernel tree in the
> v4l-dvb project. So I wonder why it shouldn't be possible to
> achieve the same for the above driver.

In general it is possible. We don't have an external tree but the hwmon
API is so simple that it is very stable, which means that you can
often pick the latest version of a driver in the upstream kernel tree,
an build it for your kernel using a standalone Makefile. The only case
where it doesn't work is when a given hwmon driver builds on other APIs
which _did_ change. This is the case of acpi for the atk0110 driver, or
of i2c for a number of other hwmon drivers. Sometimes it is possible to
update the code to take API changes into account backwards, but when
there was no equivalent API in the old kernel (which is the case for the
atk0110 driver) this is simply not possible.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

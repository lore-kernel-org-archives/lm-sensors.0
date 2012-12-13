From: "Henrik Rydberg" <rydberg@euromail.se>
Date: Thu, 13 Dec 2012 07:20:11 +0000
Subject: Re: [lm-sensors] [PATCH v2] applesmc: add sysfs file to report OSK
Message-Id: <20121213072011.GA515@polaris.bitmath.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20121210195414.GA642@polaris.bitmath.org>
 <20121210222313.GF2097@hedwig.ini.cmu.edu>
 <20121212230128.GE16373@lobsang.ini.cmu.edu>
In-Reply-To: <20121212230128.GE16373@lobsang.ini.cmu.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Gabriel L. Somlo" <somlo@cmu.edu>
Cc: Guenter Roeck <groeck-dsl@sbcglobal.net>, khali@linux-fr.org, linux@roeck-us.net, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org, agraf@suse.de, rene@exactcode.com

Hi Gabriel,

> I could try to hardcode the OSK inside QEMU, or I could try to include
> it as a default config file entry, but I'm quite certain the QEMU project
> would be uncomfortable "distributing" a string on which Apple claims
> copyright. Even if that happened, distros might then balk at shipping
> QEMU as part of their package repositories, for the exact same reason.

I understand this is frustrating, and I believe you have made a good
case for the rationale. However, the technical issues remain. Also,
there might still be other, simpler, solutions.

> The only viable (from a legal CYA standpoint) thing I can think of is
> to make it easy to acquire the OSK automatically, on demand, directly
> from the hardware. Right now, the logical place for that is applesmc.ko.
> It already controls access to the SMC, and already reports values for
> various keys.

How about encrypting the string with a key only found on an Apple
computer? There are strings available in both ACPI and EFI that could
serve such a purpose.

Regarding the patch, I agree with Guenter that putting more unrelated
things into the hwmon subsystem makes no sense. Most of the
information in applesmc should go into the hwmon, thermal, backlight
and input subsystems, but some strings should go somewhere else (maybe
/sys/firmware/smc/?). The reluctance you experience here is a
technical one; someone will need to make an effort to create a good
place for your string, and it does not help that the string is, in
fact, a constant. :-)

So, don't give up hope, but please do not expect an immediate solution.

Thanks.
Henrik

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:51 +0000
Subject: ADM1030 query
Message-Id: <1081337822.4073e7dedf99c@imp.gcu.info>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040406215731.401d32c1.khali@linux-fr.org>
In-Reply-To: <20040406215731.401d32c1.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> Actually I've written a driver from specs yesterday using the pdf
> datasheet. It is based on the 2.6.4 kernel sensors driver. I will
> clean it up tonight, and, if you are interrested, I'll post it to
> you.

Sure we are interested :)

I will review your code, and then invite you to send it (as a patch
against the latest MM kernel) to Greg KH for inclusion into the main
kernel tree.

> I have also one question:
> 
> - The ADM1030 can either control the fan speed, by default it is set
> to automatic. Is it safe to enable the user to go into manual mode
> (dangerous) and how it has to be handled (interface with /sys
> filesystem).

Various chips do have manual mode and we enable it. Several chips also
have automatic mode and we sometimes support it, although no common
interface was defined yet.

Typically, you have a sysfs file "pwm1_enable" holding a boolean value.
0 means always full speed, 1 means that manual speed control is
enabled. The value of the file "pwm1" (between 0 and 255) then defines
the desired speed.

We still have to find a common interface for the various automatic
modes. Names vary between chips (smart fan, qfan, smart guardian...)
and the number and natures of the registers that control the automatic
mode differ too, which makes designing a common interface harder.

As far as the mode itself is concerned, I can think of two different
approaches. Either add a file "pwm1_auto", holding a boolean value. Or
add value "2" = "automatic mode" to the file "pwm1_enable". I don't
know which would be better, it may depend on chips implement it (but
again this may differ between chips).

We would have to compare the different hardware implementations in deep
in order to correctly define a common interface.

> I've also made modifications to the sensors 2.8.4 package, and I
> wonder what is the meaning of the SYSCTL #define's are they related
> to the kernel or it is only for program / libsensors interface.

Both kernel and user-space. In 2.4 there are two ways to access the
driver's values: procfs and system calls. SYSCTL defines are used for
the second access method, which is the one used by libsensors. So the
use of these defines is mandatory if you want your driver to be
supported by libsensors and the various applications that rely on it
(sensors and xsensors for example).

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/

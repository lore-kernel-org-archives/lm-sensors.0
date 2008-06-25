From: Len Brown <lenb@kernel.org>
Date: Wed, 25 Jun 2008 23:12:12 +0000
Subject: Re: [lm-sensors] [PATCH 2.6.26-rc] ACPI Thermal Zone driver breaks
Message-Id: <alpine.LFD.1.10.0806251845160.3279@localhost.localdomain>
List-Id: <lm-sensors.vger.kernel.org>
References: <fa.4PGqX9CuLbgiTimfCcon+PlAMxk@ifi.uio.no>
 <fa.PWu620xEt5OlYdOezvRtQriuNjM@ifi.uio.no> <48605935.5070407@shaw.ca>
 <alpine.LFD.1.10.0806232004480.2926@woody.linux-foundation.org>
 <1214279258.3001.76.camel@rzhang-dt.sh.intel.com>
 <20080624121455.GM7306@mars.solarsys.private> <48613130.7090004@keyaccess.nl>
In-Reply-To: <48613130.7090004@keyaccess.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Rene Herman <rene.herman@keyaccess.nl>
Cc: "Mark M. Hoffman" <mhoffman@lightlink.com>, Zhang Rui <rui.zhang@intel.com>, Linus Torvalds <torvalds@linux-foundation.org>, Robert Hancock <hancockr@shaw.ca>, Hans de Goede <j.w.r.degoede@hhs.nl>, Jean Delvare <khali@linux-fr.org>, linux-acpi@vger.kernel.org, lm-sensors@lm-sensors.org, Linux Kernel <linux-kernel@vger.kernel.org>


> Len suggested the default be hwmon support enabled

I think you were right and I was wrong on that part,
lets default =n.

What is new here is thermal I/F to hwmon.
Distros what want it will know they need libsensors 2.10.7
or libsensors 3.x before they turn it on.

libsensors <= 2.10.6 users who upgrade their kernel to 2.6.26
without distro support will get no bad surprises.

The down-side is simply that we are being less aggressive about
exposing these temperature readings via hwmon.
I'm not going to lose any sleep over that.

-Len









_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

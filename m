From: Matthew Garrett <mjg59@srcf.ucam.org>
Date: Thu, 26 Jun 2008 00:17:31 +0000
Subject: Re: [lm-sensors] [PATCH 2.6.26-rc] ACPI Thermal Zone driver breaks
Message-Id: <20080626001731.GA2618@srcf.ucam.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <fa.4PGqX9CuLbgiTimfCcon+PlAMxk@ifi.uio.no> <fa.PWu620xEt5OlYdOezvRtQriuNjM@ifi.uio.no> <48605935.5070407@shaw.ca> <alpine.LFD.1.10.0806232004480.2926@woody.linux-foundation.org> <1214279258.3001.76.camel@rzhang-dt.sh.intel.com> <20080624121455.GM7306@mars.solarsys.private> <48613130.7090004@keyaccess.nl> <alpine.LFD.1.10.0806251845160.3279@localhost.localdomain>
In-Reply-To: <alpine.LFD.1.10.0806251845160.3279@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Len Brown <lenb@kernel.org>
Cc: Rene Herman <rene.herman@keyaccess.nl>, "Mark M. Hoffman" <mhoffman@lightlink.com>, Zhang Rui <rui.zhang@intel.com>, Linus Torvalds <torvalds@linux-foundation.org>, Robert Hancock <hancockr@shaw.ca>, Hans de Goede <j.w.r.degoede@hhs.nl>, Jean Delvare <khali@linux-fr.org>, linux-acpi@vger.kernel.org, lm-sensors@lm-sensors.org, Linux Kernel <linux-kernel@vger.kernel.org>

On Wed, Jun 25, 2008 at 07:12:12PM -0400, Len Brown wrote:

> libsensors <= 2.10.6 users who upgrade their kernel to 2.6.26
> without distro support will get no bad surprises.
> 
> The down-side is simply that we are being less aggressive about
> exposing these temperature readings via hwmon.
> I'm not going to lose any sleep over that.

I'd agree. I don't think this is strictly necessary, but it makes life 
easier for users rolling their own kernel. Exposing these values via 
hwmon is nice, but not vital. They're not going to be able to make use 
of it without the new code.

-- 
Matthew Garrett | mjg59@srcf.ucam.org

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

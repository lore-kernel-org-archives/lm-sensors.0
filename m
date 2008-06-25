From: Rene Herman <rene.herman@keyaccess.nl>
Date: Wed, 25 Jun 2008 23:38:44 +0000
Subject: Re: [lm-sensors] [PATCH 2.6.26-rc] ACPI Thermal Zone driver breaks
Message-Id: <4862D704.80607@keyaccess.nl>
List-Id: <lm-sensors.vger.kernel.org>
References: <fa.4PGqX9CuLbgiTimfCcon+PlAMxk@ifi.uio.no> <fa.PWu620xEt5OlYdOezvRtQriuNjM@ifi.uio.no> <48605935.5070407@shaw.ca> <alpine.LFD.1.10.0806232004480.2926@woody.linux-foundation.org> <1214279258.3001.76.camel@rzhang-dt.sh.intel.com> <alpine.LFD.1.10.0806251913090.3279@localhost.localdomain>
In-Reply-To: <alpine.LFD.1.10.0806251913090.3279@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Len Brown <lenb@kernel.org>
Cc: Zhang Rui <rui.zhang@intel.com>, Linus Torvalds <torvalds@linux-foundation.org>, Robert Hancock <hancockr@shaw.ca>, "Mark M. Hoffman" <mhoffman@lightlink.com>, Hans de Goede <j.w.r.degoede@hhs.nl>, Jean Delvare <khali@linux-fr.org>, linux-acpi@vger.kernel.org, lm-sensors@lm-sensors.org, Linux Kernel <linux-kernel@vger.kernel.org>

On 26-06-08 01:16, Len Brown wrote:
> 
>> +config THERMAL_HWMON
>> +	bool "Hardware monitoring support"
>> +	depends on HWMON=y || HWMON=THERMAL
> 
> 
> for
> CONFIG_HWMON=m
> CONFIG_THERMAL=y
> CONFIG_THERMAL_HWMON=n, always.
> 
> This is not a change to the logic of the existing ifdefs,
> but was wondering if this was your intent, Rui.

My intentioon in this case. Yes, this should be. THERMAL_HWMON is a bool 
(as in, not a tristate) that just changes THERMAL.

If THERMAL=y, we need HWMON=y or we'd get a link failure. If THERMAL=m, 
we're okay with either HWMON=y and HWMON=m and if THERMAL=n, we don't 
care one hoot about THERMAL_HWMON...

Rene.

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

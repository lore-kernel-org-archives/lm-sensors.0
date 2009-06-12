From: Harald Welte <HaraldWelte@viatech.com>
Date: Fri, 12 Jun 2009 12:54:50 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: Add driver for VIA CPU
Message-Id: <20090612125450.GK30843@prithivi.gnumonks.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20090609083406.GE25316@prithivi.gnumonks.org> <20090611153255.ba8d6c54.akpm@linux-foundation.org> <20090612101200.3fe6d494@hyperion.delvare> <200906120646.48615.lkml@morethan.org>
In-Reply-To: <200906120646.48615.lkml@morethan.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Michael S. Zick" <lkml@morethan.org>
Cc: Jean Delvare <khali@linux-fr.org>, Tomaz Mertelj <tomaz.mertelj@guest.arnes.si>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org

On Fri, Jun 12, 2009 at 06:46:45AM -0500, Michael S. Zick wrote:
> > Temperature values are supposed to be expressed in millidegrees C, not
> > degrees C as it seems to be doing (although 25 degrees C seems pretty
> > low for a CPU temperature?) The drivers needs to multiply values by
> > 1000 before exporting them to sysfs. Then "sensors" will report the
> > correct temperature value.
> > 
> 
> Ah, 25 degrees C is room temperature - real hard for the junction temperature
> to be 25 degrees C with power applied; lacking an infinitely perfect heatsink.
> 
> Look for an "off by one" error in shifting or masking the value.

there is no shifting and the masking is 0xffffffff :)

it might be that the BIOS is doing something wrong when programming the
calibration MSR's at early botoup.  I would need the contents of MSR 
0x1160 ... 0x116C as well as 0x1152 and 0x1153 to be able to determine that.

-- 
- Harald Welte <HaraldWelte@viatech.com>	    http://linux.via.com.tw/
======================================
VIA Free and Open Source Software Liaison

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 19 May 2009 14:36:30 +0000
Subject: Re: [lm-sensors] [PATCH v2 0/3] tmp401: Add support for TI's
Message-Id: <20090519163630.647aa3f7@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20090519080556.GA5200@ubuntu>
In-Reply-To: <20090519080556.GA5200@ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, 19 May 2009 10:29:33 +0200, Hans de Goede wrote:
> On 05/19/2009 10:05 AM, Andre Prendel wrote:
> > Hello Jean, Hans,
> >
> > this is version v2 of the tmp401 driver patch series.
> >
> > I've added some documentation and fixed the issues of your review (see
> > changes in patch 2/3).
> >
> 
> All 3 look good!
> 
> Acked-by: Hans de Goede <hdegoede@redhat.com>

Good. I've applied all 3 patches. I did some cleanups between patch 1
and patch 2 so that patch 2 doesn't change the coding style for code
that was just added by patch 1. The end result is pretty much the same,
but this makes patch 2 much easier to read.

All 3 patches are now visible at:
ftp://ftp.kernel.org/pub/linux/kernel/people/jdelvare/linux-2.6/jdelvare-hwmon/
and are scheduled for merge into kernel 2.6.31.

Please update wiki/Devices to reflect the current status.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

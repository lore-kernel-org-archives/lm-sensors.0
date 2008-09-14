From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 14 Sep 2008 14:49:25 +0000
Subject: Re: [lm-sensors] hwmon: Add a driver for the ADT7475 thermal sensor
Message-Id: <200809141649.25274.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20080908174853.GG24308@cosmic.amd.com>
In-Reply-To: <20080908174853.GG24308@cosmic.amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: lm-sensors@vger.kernel.org

Hi Hans, Jordan,

Le samedi 13 septembre 2008, Hans de Goede a écrit :
> Jordan Crouse wrote:
> > Okay - I have generated a new patch.  I implemented all of your suggestions -
> > the only one I had any concerns about was the hystersis (hystersis makes
> > more sense to me as an offset rather then an absolute), but consistancy
> > among hwmon drivers is rather more important.
> > 
> > There is one possible issue in the patch - I pulled the decimal point
> > from the pwmX_freq numbers since I wasn't sure if we wanted to express
> > the number in milihertz.  If we do, then it is an easy fix.
> > 
> > Compile tested and run on an ADT7475 platform.
> > 
> 
> Hi Jordan et all,
> 
> I've given this a quick review (not as thorough as I would have liked to do but 
> I simply don't have enough time for a really thorough review) and I've found no 
> issues. So this patch is now:
> 
> Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Am I the only one seeing these warnings at build time?

  CC [M]  drivers/hwmon/adt7475.o
drivers/hwmon/adt7475.c: In function ‘adt7475_update_device’:
drivers/hwmon/adt7475.c:1043: warning: array subscript is above array bounds
drivers/hwmon/adt7475.c:1044: warning: array subscript is above array bounds
drivers/hwmon/adt7475.c:1045: warning: array subscript is above array bounds
drivers/hwmon/adt7475.c: In function ‘set_temp’:
drivers/hwmon/adt7475.c:381: warning: array subscript is above array bounds
drivers/hwmon/adt7475.c:381: warning: array subscript is above array bounds
drivers/hwmon/adt7475.c:382: warning: array subscript is above array bounds
drivers/hwmon/adt7475.c:382: warning: array subscript is above array bounds
drivers/hwmon/adt7475.c:384: warning: array subscript is above array bounds
drivers/hwmon/adt7475.c:384: warning: array subscript is above array bounds
drivers/hwmon/adt7475.c:385: warning: array subscript is above array bounds
drivers/hwmon/adt7475.c:385: warning: array subscript is above array bounds
drivers/hwmon/adt7475.c:388: warning: array subscript is above array bounds

Apparently struct adt7475_data should be changed from
	s16 temp[6][3];
to
	s16 temp[7][3];

Thanks,
-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

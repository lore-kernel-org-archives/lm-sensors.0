From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 29 Nov 2007 18:52:10 +0000
Subject: Re: [lm-sensors] [PATCH] libsensors: No longer depend on libsysfs
Message-Id: <20071129195210.6e10f90d@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20071129120153.26879145@hyperion.delvare>
In-Reply-To: <20071129120153.26879145@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Hans,

On Thu, 29 Nov 2007 19:16:39 +0100, Hans de Goede wrote:
> Jean Delvare wrote:
> > Hi all,
> > 
> > Here is a proposed patch to make libsensors no longer depend on
> > libsysfs. Instead, it accesses sysfs directly, using 3 embedded helper
> > functions. My motivations for doing this are:
> > * As far as I know, libsysfs is no longer maintained.
> > * libsysfs does much more than we need. For example, when asking for a
> >   device attribute list, libsysfs will read the contents and permissions
> >   of all attributes. Not only does this waste CPU cycles per se, but in
> >   the case of hwmon driver it also triggers register reads, which can be
> >   slow for SMBus chips.
> > * libsysfs enforces the difference between devices and class devices,
> >   while future changes will be easier if we can handle both types alike.
> > 
> 
> Good work!
> 
> I'm afraid I don't have the time to review this atm though, any other takers?

If you have the possibility to test the patch, that would be
appreciated as well, and less time-consuming than a review. Different
kernel versions and configurations can make the sysfs tree look a bit
different. Also, i2c and non-i2c chips have different code paths. I've
tested as much as I could on my systems, but more testing can't hurt.

Thanks,
-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

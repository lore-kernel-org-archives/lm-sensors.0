From: Henrique de Moraes Holschuh <hmh@debian.org>
Date: Mon, 06 Jul 2009 16:04:10 +0000
Subject: Re: [lm-sensors] Intel Moorestown Platform Thermal Driver
Message-Id: <20090706160410.GE753@khazad-dum.debian.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <20090706212531.GA15120@intel.com>
In-Reply-To: <20090706212531.GA15120@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, 06 Jul 2009, Kalhan Trisal wrote:
> Moorestown Platform has EMC1403 chip which support three thermal devices,
> one thermal zone is used by the EMC1403 chip itself and second is used by
> processor and third one is used for platform (skin temperature).Driver
> support poll and interrupt mode,min/max/crit configuration can be done
> using sysfs interface. 

If it is a generic chip, why does the driver name makes it sound like it is
moorestown-specific?  Wouldn't it make more sense for this to be named the
emc1403 driver, instead?

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

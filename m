From: "Trisal, Kalhan" <kalhan.trisal@intel.com>
Date: Tue, 07 Jul 2009 04:46:20 +0000
Subject: Re: [lm-sensors] Intel Moorestown Platform Thermal Driver
Message-Id: <3CA6C6D9F70D314CA34352990B57DA153303F300@bgsmsx502.gar.corp.intel.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20090706212531.GA15120@intel.com>
In-Reply-To: <20090706212531.GA15120@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Henrique
   I thought about that but then the interrupt logic is very much specific to Moorestown platform. I am comfortable in renaming the driver to emc1403.

Thanks 
Kalhan 

-----Original Message-----
From: Henrique de Moraes Holschuh [mailto:hmh@debian.org] 
Sent: Monday, July 06, 2009 9:34 PM
To: Trisal, Kalhan
Cc: khali@linux-fr.org; lm-sensors@lm-sensors.org
Subject: Re: [lm-sensors] Intel Moorestown Platform Thermal Driver

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

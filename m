From: "Trisal, Kalhan" <kalhan.trisal@intel.com>
Date: Tue, 07 Jul 2009 15:11:14 +0000
Subject: Re: [lm-sensors] Intel Moorestown Platform Thermal Driver
Message-Id: <3CA6C6D9F70D314CA34352990B57DA153303F958@bgsmsx502.gar.corp.intel.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20090706212531.GA15120@intel.com>
In-Reply-To: <20090706212531.GA15120@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I have renamed the driver with emc1403 driver as the driver is generic enough to be used for emc1403 chip. The interrupt part is kept inside the flag so that code gets enabled only when Power management in the Moorestown platform is enabled.

-----Original Message-----
From: Henrique de Moraes Holschuh [mailto:hmh@debian.org] 
Sent: Tuesday, July 07, 2009 8:20 PM
To: Trisal, Kalhan
Cc: khali@linux-fr.org; lm-sensors@lm-sensors.org
Subject: Re: [lm-sensors] Intel Moorestown Platform Thermal Driver

On Tue, 07 Jul 2009, Trisal, Kalhan wrote:
> Hi Henrique
>    I thought about that but then the interrupt logic is very much specific to Moorestown platform. I am comfortable in renaming the driver to emc1403.

Can it be made to work with DMI matches so that it enables the interrupt
logic on moorestown, and uses a generic approach otherwise?

Either that, or split it in two files, one with the moorestown specific
stuff, the other with the generic chip driver?

Anyway, if it is too difficult to do that or it doesn't make much sense
because nobody else uses the emc1403, the fact that it has
moorestown-specific stuff in it does excuse the name... but in that case,
I'd call it moorestown_hwmon or something, to avoid clashes.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

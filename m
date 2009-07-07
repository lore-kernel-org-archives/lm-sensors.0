From: Henrique de Moraes Holschuh <hmh@debian.org>
Date: Tue, 07 Jul 2009 14:49:36 +0000
Subject: Re: [lm-sensors] Intel Moorestown Platform Thermal Driver
Message-Id: <20090707144936.GA28840@khazad-dum.debian.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <20090706212531.GA15120@intel.com>
In-Reply-To: <20090706212531.GA15120@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

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

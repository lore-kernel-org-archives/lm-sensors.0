From: johnpol@2ka.mipt.ru (Evgeniy Polyakov)
Date: Thu, 07 Jul 2005 10:22:43 +0000
Subject: [lm-sensors] [Patch 4/5] w1: sysfs, select-slave, ds2433
Message-Id: <1120724541.3379.143.camel@uganda.factory.vocord.ru>
List-Id: <lm-sensors.vger.kernel.org>
References: <200506300918.17966.bgardner@wabtec.com>
In-Reply-To: <200506300918.17966.bgardner@wabtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, 2005-07-05 at 10:27 -0400, BGardner@Wabtec.com wrote:
> Evgeniy,
> 
> Thanks for the feedback.
> I will change the id to be a hex number, ie "236cdc1c00000043\n".

Please pad it with zeroes at the begining, i.e. to allow %016Lx reading.

> (Qoute about the thermal attribute 'w1_slave')
> > I would like to create this files automatically by w1 core and only
> > let slave drivers to create it's "private" files themselves.
> 
> I'm curious as to why.
> I've looked at types of families out there
> (http://owfs.sourceforge.net/family.html).
> As far as I can tell, only a few of them are thermal class.
> Do we really want a generic name 'w1_slave' that means something
> different for each family? 
> 
> I removed 'w1_slave' from the core because w1_therm is the only family
> that uses it.
> 
> IMO, the core should only create entries for attributes that are
> applicable to all families. 
> The only attribute that is present for all families is the 64-bit id.

Main idea behind w1_slave was t provide the most valuable information
from any family in this file. I.e. thermal family will put there a
temeperature, simple ID will put there it's number, voltage monitor will
store current voltage there and so on, so this file was always created
by w1 core with provided in initialistion time family callback.

> Thanks,
> Ben
> 


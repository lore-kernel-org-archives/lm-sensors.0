From: "George Joseph \(dev\)" <gtj.devel@peakin.com>
Date: Sun, 22 Jul 2007 14:31:16 +0000
Subject: Re: [lm-sensors] Intel D975XBX2 motherboard "no sensors found"
Message-Id: <22E26940476D1E48AA6F292B5316C9C3386F@bes1.peakin.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <46A310EE.4080206@arcor.de>
In-Reply-To: <46A310EE.4080206@arcor.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

The Intel975XBX2 has an Andigilog aSC7621 chip and is supported by the
following patch.  http://www.peakin.com/download/asc76xx-2.6.21.patch

Hopefully I'll have time to finish the docs and get it submitted for
review in the next few weeks.
 

-----Original Message-----
From: lm-sensors-bounces@lm-sensors.org
[mailto:lm-sensors-bounces@lm-sensors.org] On Behalf Of Hans de Goede
Sent: Sunday, July 22, 2007 8:18 AM
To: mike corn
Cc: LM Sensors
Subject: Re: [lm-sensors] Intel D975XBX2 motherboard "no sensors found"

mike corn wrote:
> Motherboard: Intel D975XBX2
> CPU: Core 2 Quad 6600
> Linux: Ubuntu 7.04
> lm-sensors: 2.10.1
> 
> Your online docs are in shambles, so perhaps I did not understand
them.
> Here is exactly what I did:
> 
> 1. sensors-detect: found i2c-i801 and eeprom
> (I answered YES to all queries, including the auto add to
/etc/modules)
> 2. modprobe i2c-i801 and eeprom


> 3. sensors --> "no sensors found"

Thats normal, no supported sensors were found on your motherboard, only
supported eeproms, but those are not sensors.

So it seems that your motherboard currently is not supported most likely
it
uses Intels new AMT technology, we want to support this in the future,
but
sofar there is no concrete plan for this.

Regards,

Hans


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

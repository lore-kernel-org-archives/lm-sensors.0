From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 14 Apr 2011 07:57:23 +0000
Subject: Re: [lm-sensors] Will there ever be EMC6w201 support?
Message-Id: <20110414095723.4a717cf0@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20110414034609.476411A9866@localhost.localdomain>
In-Reply-To: <20110414034609.476411A9866@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Harry,

On Wed, 13 Apr 2011 21:46:09 -0600, Harry G McGavran Jr wrote:
> The last time anyone supposedly looked into this
> was in 2006.
> 
> My Dell Precision 670 is still going great guns with
> Ubuntu Lucid, but lm_sensors can't deal with
> the EMC6w201 in it.
> 
> One can get the datasheet for this at:
> 
> http://www.datasheetarchive.com/pdf-datasheets/Datasheets-32/DSA-629474.html
> 
> It is a 150 page pdf which looks like it should have the info
> needed.  I have a copy, but don't know who to forward it to
> who might be able to conjure up a driver for it.

Will be difficult to find a developer motivated to write a driver for 2
users of 2006 hardware, I'm afraid. Do you have anything to offer in
return? I have a wishlist:
  http://khali.linux-fr.org/wishlist.html

Meanwhile I've added detection support to sensors-detect:
  http://khali.linux-fr.org/devel/misc/sensors-detect
If you could test and report, that would be great. Proper detection of
the chip may bring more user requests to support the chip (although the
old age of the chip makes this event rather unlikely.)

A register dump of the chip would be welcome too. You can obtain it by
loading the i2c-dev kernel driver and running i2cdump (from the
i2c-tools package):

# modprobe i2c-dev
# i2cdump N 0x2e

where N is the i2c bus number displayed by sensors-detect, and 0x2e the
actual chip address on that bus (can be one of 0x2c, 0x2d or 0x2e.)

While the EMC6W201 is a pretty complex chip with many advanced
features, basic monitoring of voltages, fans and temperatures shouldn't
be that hard to implement.

Ric, out of curiosity, are you still interested in EMC6W201 support?

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

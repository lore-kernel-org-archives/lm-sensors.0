From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Tue, 08 Feb 2011 17:10:26 +0000
Subject: [lm-sensors] tempX_source sysfs attribute needed ?
Message-Id: <20110208171026.GE13717@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi all,

in the recent months, I have seen two instances where a sysfs attribute 
identifying the source associated with a temperature sensor would have been 
helpful.

One is max6639. For this chip, the source of the second temperature channel
can be configured to be local or remote.

The others are W83677HG-B, NCT6775F, and NCT6776F. Those chips have four to six
temperature channels with a configurable source.

Current approach is to stick with whatever is configured by the BIOS for the Nuvoton
chips, and to use the local source for the max6639 driver. For the Nuvoton chips,
my prototype driver for NCT6775F and NCT6776F reports the temperature source 
in tempX_label.

Possible solutions might be:
- Stick with the current situation, ie do nothing.
- Use module parameters. Doesn't really work well for max6639 since it affects 
  all instances of the driver, and if the driver is built into the kernel.
- Use platform data. Might work for max6639, but not for the Nuvoton chips.
- Define a new sysfs attribute to make the temperature source configurable,
  and to report the current selection.

Any thoughts/comments ?

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

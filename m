From: mhoffman@lightlink.com (Mark M. Hoffman)
Date: Fri, 09 Dec 2005 16:51:01 +0000
Subject: [lm-sensors] [PLUG] lm_sensors and fan speed
Message-Id: <20051209165101.GA23690@jupiter.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Art:

(cc'ed lm_sensors mailing list)

> >* Art Alexion <art.alexion at verizon.net> [2005-12-08 09:29:59 -0500]:
> >>I set up lm_sensors with a display in the KDE panel, everything seems
> >>fine, except the fan occasionally slows down for a few seconds.  No
> >>noise.  Should I be concerned?  Temp remains constant at safe levels.  I
> >>have the side off the tower which should help with temp.

> Mark M. Hoffman wrote:
> >Did you notice this only *after* you set up lm_sensors?  

* Art Alexion <art.alexion at verizon.net> [2005-12-09 10:51:27 -0500]:
> Yes.
> 
> >If so, what kind
> >of hardware monitoring chip do you have?
> >  
> >
> Don't know.

Given the sensors-detect output, looks like Winbond w83627hf.

> >The standard questions...
> >
> >What version of lm_sensors? 
> >
> 2.8.8-7ubuntu2.1
> 
> >Installed from source or distro package?
> >  
> >
> .deb
> 
> >What kernel version?
> >  
> >
> 2.6

Be more specific please.  Output from 'uname -a' will suffice.

[I ask this because there has been a lot of w83627hf driver work recently -
for 2.6 kernels this happens in mainline (as opposed to lm_sensors CVS).]

> >What did sensors-detect report?
> >  
> >
> Driver `eeprom' (may not be inserted):
>   Misdetects:
>   * Bus `I810/I815 DDC Adapter' (Algorithm unavailable)
>     Busdriver `i2c-i810', I2C address 0x50
>     Chip `SPD EEPROM' (confidence: 1)
>   * Bus `I810/I815 DDC Adapter' (Algorithm unavailable)
>     Busdriver `i2c-i810', I2C address 0x51
>     Chip `SPD EEPROM' (confidence: 1)
>   * Bus `I810/I815 DDC Adapter' (Algorithm unavailable)
>     Busdriver `i2c-i810', I2C address 0x52
>     Chip `SPD EEPROM' (confidence: 1)
>   * Bus `I810/I815 DDC Adapter' (Algorithm unavailable)
>     Busdriver `i2c-i810', I2C address 0x53
>     Chip `SPD EEPROM' (confidence: 1)
>   * Bus `I810/I815 DDC Adapter' (Algorithm unavailable)
>     Busdriver `i2c-i810', I2C address 0x54
>     Chip `SPD EEPROM' (confidence: 1)
>   * Bus `I810/I815 DDC Adapter' (Algorithm unavailable)
>     Busdriver `i2c-i810', I2C address 0x55
>     Chip `SPD EEPROM' (confidence: 1)
>   * Bus `I810/I815 DDC Adapter' (Algorithm unavailable)
>     Busdriver `i2c-i810', I2C address 0x56
>     Chip `SPD EEPROM' (confidence: 1)
>   * Bus `I810/I815 DDC Adapter' (Algorithm unavailable)
>     Busdriver `i2c-i810', I2C address 0x57
>     Chip `SPD EEPROM' (confidence: 1)
> 
> Driver `ddcmon' (should be inserted):
>   Detects correctly:
>   * Bus `I810/I815 DDC Adapter' (Algorithm unavailable)
>     Busdriver `i2c-i810', I2C address 0x50 (and 0x51 0x52 0x53 0x54 0x55
> 0x56 0x57)
>     Chip `DDC monitor' (confidence: 8)
> 
> Driver `w83781d' (may not be inserted):
>   Misdetects:
>   * ISA bus address 0x0290 (Busdriver `i2c-isa')
>     Chip `Winbond W83627HF' (confidence: 8)
> 
> Driver `w83627hf' (should be inserted):
>   Detects correctly:
>   * ISA bus address 0x0290 (Busdriver `i2c-isa')
>     Chip `Winbond W83627HF Super IO Sensors' (confidence: 9)
> 
> 
> 
> >Did you modify /etc/sensors.conf at all?  
> >  
> >
> No.

OK, could you please send the output of 'sensors'.

One more question... does your BIOS have any kind of automatic fan controls?
They are usually on the same BIOS screen that shows temperatures.

Regards,

-- 
Mark M. Hoffman
mhoffman at lightlink.com



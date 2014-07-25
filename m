From: Jean Delvare <jdelvare@suse.de>
Date: Fri, 25 Jul 2014 17:34:51 +0000
Subject: Re: [lm-sensors] not fan detected chromebook c720
Message-Id: <20140725193451.17d88cf1@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <53D18E7E.4020308@gmail.com>
In-Reply-To: <53D18E7E.4020308@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Pietro,

Please keep the list Cc'd.

On Fri, 25 Jul 2014 11:46:39 -0500, Pietro Sammarco wrote:
> >I'm surprised by the designware stuff, instead I would expected
> >cros-ec-i2c-tunnel. Can you check if the i2c-cros-ec-tunnel driver is
> >loaded (as well as the cros_ec driver itself)?
> 
> In regard of this, i2c-cros-ec-tunnel cannot be found, while cros_ec 
> wasn't loaded. What are exactly those two kernel modules supposed to do?

The cros_ec driver is handing the "embedded controller" of some
ChromeOS laptops. See this as a gate to access other components /
features of the mainboard. i2c-cros-ec-tunnel is on of these
components, which gives access to a secondary I2C bus distinct from the
Intel PCH SMBus. My idea was that maybe there was some hardware
monitoring chip on that secondary I2C bus.

You should try to find out if the cros_ec driver is needed on your
laptop. Maybe it is, maybe not. BTW the cros_ec module itself is only a
helper module, the actual driver is cros_ec_i2c or cros_ec_spi
depending on the laptop model.

I don't know much about ChromeOS hardware myself, so I can only give
you vague hints, take these with a grain of salt, I may be off-track.

> I am going to go a bit offtopic now. The real issue whit my c720 in 
> particular is that the part of the motherboard at the opposite side of 
> the fan gets quite hotter after an hour of use (look the part numbered 5 
> in the c720 picture, that's exactly where the intense smell comes from 
> hthttp://www.chromium.org/_/rsrc/1381990807648/chromium-os/developer-information-for-chrome-os-devices/acer-c720-chromebook/c720-chromebook-annotated-innards.png 
> ), and its when the burning of electronic smells starts to come out. 
> Therefore I would assume the firmware that handles the fan speed simply 
> doesn't do enough for my chromebook, and since lm-sensors doesn't yet 
> work with it, I need to know a way to manually increase the fan speed 
> RPM min, max and per temperature so that there will be enough 
> ventilation all across the motherboard for the laptop to cool off properly.
> 
> At the same time I am going to do some further investigations in regard 
> of how ChromeOS exactly handles thermal and fan control.

You should be very careful, I doubt the hardware will last long in
these conditions. Using an external cooling system until you get things
sorted out may help.

Note that getting lm-sensors to work would probably not solve your
problem. In the best case, it will tell you how fast the fan is
spinning. It is unlikely that it will give your control of the fan
speed, that's almost always handled by the firmware on laptops.

Also note that the problem may not be the cooling per se. I have a
laptop with a discrete graphics chip which heats more than the CPU when
the graphics driver doesn't perform proper power management. That
machine worked fine with the binary graphics driver from the vendor.
Once I switched to the open source driver (I had no choice as the
binary driver was no longer maintained) the machine started overheating.

The thing marked with "1" in the picture you sent, seems to generate
some heat, and is not far away from the area you say is getting hot.

It could also be an issue with the CPU. You should check that things
like CPU idle and CPUFreq are working properly. If the CPU doesn't get
proper power management, the fan may be simply unable to cope with the
generated heat. So you should perform some analysis with tools such as
powertop.

-- 
Jean Delvare
SUSE L3 Support

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

From: j.w.r.degoede@hhs.nl (Hans de Goede)
Date: Sat, 17 Mar 2007 13:15:20 +0000
Subject: [lm-sensors] http://www.lm-sensors.org/ticket/2188
Message-Id: <45FBE9E8.5090800@hhs.nl>
List-Id: <lm-sensors.vger.kernel.org>
References: <191fb4ca0703150941v6af08f75k7f8ef5dea70d8264@mail.gmail.com>
In-Reply-To: <191fb4ca0703150941v6af08f75k7f8ef5dea70d8264@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org



Juerg Haefliger wrote:
> Hans,
> 
> Yes, the deal is on.
> Do you have a datasheet you could share?
Abit doesn't release (probably doesn't even have) a datasheet for this chip, my 
driver is reverse engineered, but has been tested successfully by about 6 
people on 5 different abit motherboards.

> Unfortunately I can't share the datasheet for the DME1737, I'm under NDA.
> 
> I'll try to take a look at your patch next week.
> 

Some first comments as a result of looking at the documentation, do we really 
want these options: ?
+* force_temp_map: bool	Force the temp-to-zone mapping to the default, which is
+			temp1->zone1, temp2->zone2, temp3->zone3. The driver
+			currently only supports the default mapping and will
+			not load if the mapping is different, unless this
+			parameter is used.
+
+* force_fan_map: bool	Force the fan-to-pwm mapping to the default which is
+			fan1->pwm1, fan2->pwm2, fan3->pwm3. The driver
+			currently only supports the default mapping and will
+			not load if the mapping is different, unless this
+			parameter is used.

I find them rather dangerous both could mess up the cooling. If one must pass 
force_temp_map, then one must probably also change pwm[1-3]_auto_channels_temp 
to match, or otherwise the wrong temp is used for regulating the fan speed!
Maybe your driver could automaticly do this adjusting? Then it  would become 
less dangerous imho.

force_fan_map is even worse, then if indeed a fan is attached to fan sensor 1, 
but pwm output 2, the speed regulation becomes totally broken! I must say I 
cannot imagine a motherboard manufacturer doing something like this, and thus I 
question the usefullness of this option.

Atleast the doc should be much more clear that this is dangerous and could 
cause once computer to overheat.


Regards,

Hans


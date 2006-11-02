From: christian.mahr.ulm@arcor.de (Christian Mahr)
Date: Thu, 02 Nov 2006 21:45:08 +0000
Subject: [lm-sensors] ASUS P5B DELUXE WiFi with Winbond W83627DHG
Message-Id: <200611022245.08542.christian.mahr.ulm@arcor.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <4536788E.8010504@fibertel.com.ar>
In-Reply-To: <4536788E.8010504@fibertel.com.ar>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi David,

I did some more research on the 4 pin fan.

> > Fan2 seems to be connected to "CPU-FAN", the 4-pin connector. Here I am
> > still experimenting. The main problem is that the CPU cooler I do use now
> > has only 3 pins. If I connect any 3 pin fan to these 4 pins, the fan just
> > turns at high speed - no control. Is there any adapter for such purposes?
>
> The pins on a 3-pin fan are (not in order): ground, PWM signal
> (typically +12V, but the signal switches on and off rapidly) and RPM
> sensor. The problem is that the RPM sensor is powered by the PWM
> signal, resulting in an inaccurate RPM reading. The pins on a 4-pin
> fan are (not in order): ground, PWM signal drives the fan, power for
> the RPM sensor (I think it's +12V, or it might be +5V) and the RPM
> reading. This gives a more accurate reading. If you found the ground,
> PWM, and RPM pins, you could connect a 3-pin fan. You should use a
> voltmeter, and you might still damage your board. (If, for instance,
> the RPM sensor on the 3-pin fan outputs a +12V sense signal and the
> motherboard is designed for a +5V sense signal, you could damage it.)
> That's all I know on the subject, but you could google for a while and
> look for more information.


- pwm2 seems to work only in pwm mode.
- pin 1= GND, Pin2 = +12v, pin3 = sensor, pin4 = speed control (as you 
indicated)

When measuring pin4, it turns out that this delivers zero to almost 5 volts.
This means that I cannot drive a fan directly but will need a transistor or so 
to translate to 0..12 V.


>
> No, the driver can only report readings from the chip. If the _div is
> 128, the readings are as low as they can get. Erroneous readings are
> typical at low speeds. One way to get a more accurate reading would be
> to average multiple values (two options: a moving window average, or
> an alpha filter) -- this is not something that a kernel driver should
> do, in keeping with the lm-sensors design philosophy. The sensors
> package might be the right place to add this feature, but I am not
> certain.
>
can one extend the mesuremnt period in the driver?

Best regards
		Chris



	
		
___________________________________________________________ 
Der fr?he Vogel f?ngt den Wurm. Hier gelangen Sie zum neuen Yahoo! Mail: http://mail.yahoo.de



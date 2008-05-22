From: Jonathan Cameron <jic23@cam.ac.uk>
Date: Thu, 22 May 2008 09:35:01 +0000
Subject: Re: [lm-sensors] [spi-devel-general] Accelerometer,
Message-Id: <48353E45.2080903@cam.ac.uk>
List-Id: <lm-sensors.vger.kernel.org>
References: <4832A211.4040206@gmail.com>	<20080520132817.03fb74ea@hyperion.delvare> <200805211752.15670.david-b@pacbell.net>
In-Reply-To: <200805211752.15670.david-b@pacbell.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Brownell <david-b@pacbell.net>
Cc: Jean Delvare <khali@linux-fr.org>, spi-devel-general@lists.sourceforge.net, Jonathan Cameron <Jonathan.Cameron@gmail.com>, LM Sensors <lm-sensors@lm-sensors.org>, linux-kernel@vger.kernel.org, Dmitry Torokhov <dtor@mail.ru>

Hi David,
> On Tuesday 20 May 2008, Jean Delvare wrote:
>> This all sounds quite different from our hwmon drivers. Our hwmon
>> drivers read all the sensor values at once and cache the readings for a
>> couple seconds, so you can't get an instant reading at any time, and
>> they also don't support interrupts in general.
> 
> That's something of an issue when the hardware monitor
> triggers alarms though, right?  I couldn't figure out
> how to get a TMP75 alert out to any userspace code that
> would care, to pick one example, even after teaching
> the i2c core how to handle SMBus alerts.  ;)
> 
> I suppose this just emphasizes the point made by Hans
> that we kind of need (industrial) "control" components
> (or "data acquisition"?) not just "monitoring" ones.
I get the feeling even the name is going to evolve for some time to come, 
getting broader as and when we add more classes of device.
> Such alarms are of course different from the "data
> ready" signals of an accelerometer.
Whilst this is true, most accelerometers also have "alarm" triggers, for example
the ST LIS3L02DQ will raise a pin on configurable conditions such as thresholds
and even a double click detector (though I've never tried them!).  I suppose we
will ideally support this functionality as well.
--
Jonathan Cameron

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

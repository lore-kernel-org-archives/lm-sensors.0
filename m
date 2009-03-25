From: Alan A <aaa@bright.net>
Date: Wed, 25 Mar 2009 02:07:22 +0000
Subject: Re: [lm-sensors] help with lmsensors and intel atom
Message-Id: <loom.20090325T015904-411@post.gmane.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <loom.20090324T161504-153@post.gmane.org>
In-Reply-To: <loom.20090324T161504-153@post.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: lm-sensors@vger.kernel.org

Matt Roberds <mattroberds <at> cox.net> writes:

> 
> On Tue, 24 Mar 2009, Alan A wrote:
> > I recently put together Ubuntu on an Intel Atom (D945GCLF).  I'm
> > trying to program sensor data on an external LCD.  I have no
> > problems writing other data to the display but when I try to parse
> > sensor data, I can't get anything worth while.
> 
> First, try using the command-line client "sensors" in a terminal window.
> If lm-sensors is configured correctly, sensors should print out various
> temperatures, fan speeds, voltages, etc, depending on what exactly your
> hardware supports.
> 
> If you run sensors and get absolutely nothing (or way less than you
> expect, like only one or two temperature readings when you expect a
> bunch of temperatures and fan speeds and voltages) you probably need
> to run "sensors-detect" as root and do what it says as far as loading
> modules.
> 
> If you run sensors and get a reasonable amount of output, but the
> values are not what you expect (like it says your power supply voltages
> are 1.1 and 1.7 V instead of about 3.3 and 5.0 V), then you probably
> need to adjust the scaling values in /etc/sensors3.conf .
> 
> If you run sensors and you get a reasonable amount of reasonably
> correct output, then you might have trouble in whatever program
> is driving your LCD - either a configuration problem or some kind of
> incompatibility.  Maybe the LCD program expects lm-sensors version
> 2.x and you are running 3.x, or vice versa (say "sensors --version" to
> find out what version of lm-sensors you have.)
> 
Thanks for your reply Matt. I ran sensors and it reported the following:

smsc47m192-i2c-0-2d
Adapter: SMBus I801 adapter at 2000
+2.5V:       +2.55 V  (min =  +0.00 V, max =  +3.32 V)   
VCore:       +1.20 V  (min =  +0.00 V, max =  +2.99 V)   
+3.3V:       +3.28 V  (min =  +0.00 V, max =  +4.38 V)   
+5V:         +4.97 V  (min =  +0.00 V, max =  +6.64 V)   
+12V:       +12.25 V  (min =  +0.00 V, max = +15.94 V)   
VCC:         +3.32 V  (min =  +0.00 V, max =  +4.38 V)   
+1.5V:       +1.58 V  (min =  +0.00 V, max =  +1.99 V)   
+1.8V:       +1.78 V  (min =  +0.00 V, max =  +2.39 V)   
Chip Temp:   +31.0°C  (low  = -127.0°C, high = +127.0°C)  
CPU Temp:    +50.0°C  (low  = +40.0°C, high = +70.0°C)  
Sys Temp:    +40.0°C  (low  = -127.0°C, high = +127.0°C)  
cpu0_vid:   +2.050 V

smsc47m1-isa-0680
Adapter: ISA adapter
fan1:       4818 RPM  (min = 1280 RPM, div = 4)
fan2:       7021 RPM  (min = 1280 RPM, div = 4)

And then checked the version:

sensors version 3.0.2 with libsensors version 3.0.2

You do know your stuff! Thank you much. Any ideas as to the code in the snippet
in the other message? I'm running LCD4Linux to access the LCD.


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

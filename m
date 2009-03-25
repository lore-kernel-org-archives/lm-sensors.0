From: Matt Roberds <mattroberds@cox.net>
Date: Wed, 25 Mar 2009 01:15:52 +0000
Subject: Re: [lm-sensors] help with lmsensors and intel atom
Message-Id: <Pine.LNX.4.64.0903241951110.12446@birdbird.example.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <loom.20090324T161504-153@post.gmane.org>
In-Reply-To: <loom.20090324T161504-153@post.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, 24 Mar 2009, Alan A wrote:
> I recently put together Ubuntu on an Intel Atom (D945GCLF).  I'm
> trying to program sensor data on an external LCD.  I have no
> problems writing other data to the display but when I try to parse
> sensor data, I can't get anything worth while.

First, try using the command-line client "sensors" in a terminal window.
If lm-sensors is configured correctly, sensors should print out various
temperatures, fan speeds, voltages, etc, depending on what exactly your
hardware supports.

If you run sensors and get absolutely nothing (or way less than you
expect, like only one or two temperature readings when you expect a
bunch of temperatures and fan speeds and voltages) you probably need
to run "sensors-detect" as root and do what it says as far as loading
modules.

If you run sensors and get a reasonable amount of output, but the
values are not what you expect (like it says your power supply voltages
are 1.1 and 1.7 V instead of about 3.3 and 5.0 V), then you probably
need to adjust the scaling values in /etc/sensors3.conf .

If you run sensors and you get a reasonable amount of reasonably
correct output, then you might have trouble in whatever program
is driving your LCD - either a configuration problem or some kind of
incompatibility.  Maybe the LCD program expects lm-sensors version
2.x and you are running 3.x, or vice versa (say "sensors --version" to
find out what version of lm-sensors you have.)

Matt Roberds


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

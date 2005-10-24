From: S.Bieganski@tue.nl (Szymon Bieganski)
Date: Mon, 24 Oct 2005 12:08:31 +0000
Subject: [lm-sensors] feedback request: i2c bus and v4l driver for PCRadio
Message-Id: <op.sy5aflxhbj4yoq@mailhost.ics.ele.tue.nl>
List-Id: <lm-sensors.vger.kernel.org>
References: <opsik3vcn0bj4yoq@mailhost.ics.ele.tue.nl>
In-Reply-To: <opsik3vcn0bj4yoq@mailhost.ics.ele.tue.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, 20 Oct 2005 12:55:44 +0200, Jean Delvare <khali@linux-fr.org> wrote:

> A quick note first: why would you have two separate modules, and why
> would the I2C bus part be in drivers/i2c/busses? We usually put there
> drivers for motherboard I2C busses or SMBus masters, which can be found
> on a variety of boards and may have about any chip on them depending on
> the board. For I2C busses which are part of a daughter board, it makes
> more sense to let the driver live in the proper subsystem (I2C busses on
> graphics adapters are most often part of framebuffer drivers in
> drivers/video, I2C busses on video adapters are found in
> drivers/media/video).

I had a reason for that. As I stated in my first post this is entirely _experimental_ work. I have written low-level i2c driver as an experiment when I have finished writing (rather porting) radio-spase.c driver which was basicaly doing what you are trying to descibe here: closed driver for a radio card, an i2c bus driving only chips present on the (daughter)board. It was staying in media/radio then. But I wanted to (ab-)use the bus for other purposes, since there are no i2c sensors originally installed in the system. I have splitted support into layers: i2c and v4l. At the moment I have SAA1064, couple of PCF8574 connected to the bus. SAA is used to show frequency at the moment, could be used for anything else. PCFs are for general purposes (I/O), could be even HD44780 display. I have plans to connect fan controlling/monitoring chips and thermperature monitoring chips. What I2C_CLASS would such bus be then ? I2C_CLASS_ALL ?

> You really should port this to a recent kernel. 2.6.8 is old

It is recent enough for Debian/testing. I won't rush them. I must be patient.

> i2c-parport.c is not old, it was written specifically for Linux 2.6. And it wasn't written by Michiel Ronsse, but by me.

Michiel Ronsse had written the original v4l driver for that card. I have used i2c-parport.c as a template. My apologizes for omitting your name.

> You must be kidding. Don't put garbage in /proc. (...)

Don't need it anymore. Removed.

>> +	.getscl		= NULL, /* spase_getscl,*/
> (..)
> If OTOH readback is possible, you want to implement it right now. It helps bus stability.

Functionality is somehow limited: SCL line readback is not possible, therefore explicitely disabled. It is single-master bus. "ASCII art" in /proc shows very clearly how it is all connected together.

> Are there REALLY hardware monitoring chips on this bus? I2C_CLASS_SOUND
> seems more appropriate, or we could even define I2C_CLASS_RADIO if
> needed.

I2C_CLASS_ALL would be better here, I guess. There can be virtually ANY i2c (slave) chip attached.

>> +	.id		= -1, /* FIXME !!!!! I2C_HW_B_SPASE, */
> It says "fix me". Maybe you could actually fix it before submitting your patch?

Such ID does not exist yet, so I can't fix it. I had no plans to submit patch to the mainstream. Did you consider my feedback request as patch submission ?

> You are not seriously thinking we would accept this in the kernel? ASCII art in /proc files! What next?

i2c bus is pretty stable now. Debugging stage is finished. I will port it to newer kernel, as soon as it is available. As a next step would be splitting the support even further: low level i2c driver bus, separate chips modules for all chips used on the board, and v4l driver which would make use of separate chips.

Thank you for remarks.

With kind regards
Szymon

-- 
----                                 ----
Szymon Bieganski, PhD candidate
TU/e EE dept ICS group, (+31) 40 247 3394
----                                 ----

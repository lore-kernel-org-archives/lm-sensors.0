From: phil@edgedesign.us (Philip Edelbrock)
Date: Thu, 19 May 2005 06:24:29 +0000
Subject: Matrix Orbital driver
Message-Id: <3FD91FA1.6020205@edgedesign.us>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org



I haven't had any experience with a/the keypad.  Doing some quick 
searching, I noticed some info with using a keypad with a serial port 
arrangement, but I don't know if it works with I2C.  Communication from 
a chip to the bus master on a I2C/SMBus is a bit tricky and isn't the 
norm, and wouldn't be implmented in a client chip driver.

So to answer your question: e) all of the above   ;')


Phil


David Cecil wrote:

> Hi Philip,
>
> when some hardware arrives, I plan to try out your LCD driver.  In the 
> meantime, I've been looking at the code.
>
> Our hardware is going to have a keypad associated with the LCD.  I've 
> noticed that there is no provision in your driver for a keypad.  Is 
> that because:
> a) It doesn't belong there?
> b) There's no generic solution given the variable number of keys for 
> the pad?
> c) You didn't get around to writing it?
> d) Something I haven't thought of?
>
> Thanks,
> Dave
>

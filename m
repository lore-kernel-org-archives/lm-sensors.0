From: phil@edgedesign.us (Philip Edelbrock)
Date: Thu, 19 May 2005 06:24:29 +0000
Subject: Matrix Orbital driver
Message-Id: <3FDA127E.6060804@edgedesign.us>
List-Id: <lm-sensors.vger.kernel.org>
References: <3FD91FA1.6020205@edgedesign.us>
In-Reply-To: <3FD91FA1.6020205@edgedesign.us>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Ah, Kyosti's comments were on the money.  Polling reads are pretty simple.

Instead of using a chip driver style implementation, I would suggest you 
try a simple user-space app/daemon that does what you want that uses the 
/dev/i2c-* interface.  In the lm-sensors package, take a look at some of 
the programs there for some examples (like prog/detect/i2cdetect.c).

I'm guessing you'll use a few ioctl's to specify which device you are 
talking to, and then i2c_smbus_write_byte_data() to send chars/commands 
to the display and i2c_smbus_read_byte_data() to see if a key has been 
pressed.


Phil

David Cecil wrote:

> Phil,
>
> I've re-read what you've written, and the relevant part of the manual 
> for the display.  Is says
>
> "The keypad is read by I2C master read. In short, this means that a 
> read of the module will always return the first unread key press. A 
> read is initiated by writing to the module with its base address plus 
> 1, then clocking the module s return byte after the module releases 
> the SDA line. Much more detail on this basic I2C function can be found 
> in the I2C specification by Philips. A good reference is also 
> available at http://www.ping.be/~ping0751/i2cfaq/i2cindex.htm
>
> The module contains a ten key press buffer so that it can be polled 
> for key presses at an infrequent rate (every 500 to 1000 mS is 
> typical). All returned key presses indicate the presence or absence of 
> additional logged key presses by the most significant bit (MSB - bit 7)."
>
> Is the "I2C master read" a significant point?  Is that something more 
> than just a read from the keypad device?
>
> If you think I should direct this question elsewhere, please let me know.
>
> Thanks,
> Dave
>
> Philip Edelbrock wrote:
>
>>
>>
>> I haven't had any experience with a/the keypad.  Doing some quick 
>> searching, I noticed some info with using a keypad with a serial port 
>> arrangement, but I don't know if it works with I2C.  Communication 
>> from a chip to the bus master on a I2C/SMBus is a bit tricky and 
>> isn't the norm, and wouldn't be implmented in a client chip driver.
>>
>> So to answer your question: e) all of the above   ;')
>>
>>
>> Phil
>>
>>
>> David Cecil wrote:
>>
>>> Hi Philip,
>>>
>>> when some hardware arrives, I plan to try out your LCD driver.  In 
>>> the meantime, I've been looking at the code.
>>>
>>> Our hardware is going to have a keypad associated with the LCD.  
>>> I've noticed that there is no provision in your driver for a 
>>> keypad.  Is that because:
>>> a) It doesn't belong there?
>>> b) There's no generic solution given the variable number of keys for 
>>> the pad?
>>> c) You didn't get around to writing it?
>>> d) Something I haven't thought of?
>>>
>>> Thanks,
>>> Dave
>>>
>>
>

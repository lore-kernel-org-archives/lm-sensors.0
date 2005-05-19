From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:53 +0000
Subject: i2c address probing and AT24RF08 corruption
Message-Id: <1082123259.407fe3fb3d41c@imp.gcu.info>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi all,

Frodo, please do not forward this mail to the lm_sensors mailing list, I
really want you to read this!

I am starting this thread on the lm_sensors mailing-list with all of you
in copy in the hope to put an end to the Thinkpad issue that has been
plaguing our project since it started, more than five years ago.

In i2c-core as well as in our userspace tools (sensors-detect,
i2cdetect), we are using the SMBus "quick command"
(I2C_FUNC_SMBUS_QUICK) for i2c address probing purposes. This is what
is causing trouble with the AT24RF08 chip found in most Thinkpad
laptops, among other systems.

Our README.thinkpad document states:

"'Write Quick 0' is not an actual write and should never generate a
write operation to an eeprom location."

This is not exact. It should not generate a write operation to an eeprom
location, granted. But this *is* an actual write. Quoting the SMBus
spec:

"Here, part of the slave address denotes the command ? the R/W# bit. The
R/W# bit may be used to simply turn a device function on or off, or
enable/disable a low-power standby mode."

So it clearly states that any chip is entitled to change its state or
whatever it pleases when receiving a "quick command". After reading
this, I cannot blame Atmel for poor hardware design on the AT24RF08
anymore. What's really poor is our use of the "quick command" IMHO.

For this reason, I can hardly understand how it was decided that this
command would be used for address probing purposes. I agree that the
SMBus spec has no provision for address probing, so we have to use
another command to achieve this purpose, still I would expect a
"receive byte" (I2C_FUNC_SMBUS_READ_BYTE) to be way safer than a "quick
command". The only side effect I can think off is that it would
increase the address pointer for chips in autoincrement mode, but
that's about all and it doesn't seem to hurt, really. Another drawback
is that it requires 20 clock cycles instead of 11, but this is
definitely neglectable if it instantly solves the AT24RF08 corruption
issue and possibly other potential problems as well.

The problem is that I can hardly believe that nobody proposed the same
as I am doing right now in 5 years, although I couldn't find any
explanation as to why the "quick command" choice was made in the first
place. The only relevant post (unanswered) I could find is here:
http://archives.andrew.net.au/lm-sensors/msg00465.html

I am seriously planning to change this in all three places (i2c-core,
sensors-detect and i2cdetect) and would like to hear objections if they
exist.

Joe, Mark, you have been testing AT24RF08 chips in the past, could you
tell me if the corruption would also occur if we were sending a bit "1"
(instead of 0) in the "quick command"? I don't plan to do this (no real
reason it would be safer than sending a "0", except that it then looks
like the beginning of a read command instead of a write one) but if it
turns out that using a "receive byte" command for probing is not
possible, then this is another change to consider.

Everyone please speak up and give me your opinion on my proposal. I am
kind of tired of all the overhead work needed just because of the
Thinkpad problem and would like to definitely solve that issue as soon
as possible.

Thanks.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/

From: kyosti.malkki@welho.com (=?ISO-8859-1?Q?Ky=F6sti_M=E4lkki?=)
Date: Thu, 19 May 2005 06:24:29 +0000
Subject: Matrix Orbital driver
Message-Id: <Pine.LNX.4.53.0312120728070.9933@cosmos.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <3FD91FA1.6020205@edgedesign.us>
In-Reply-To: <3FD91FA1.6020205@edgedesign.us>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, 11 Dec 2003, Philip Edelbrock wrote:

> I haven't had any experience with a/the keypad.  Doing some quick
> searching, I noticed some info with using a keypad with a serial port
> arrangement, but I don't know if it works with I2C.  Communication from
> a chip to the bus master on a I2C/SMBus is a bit tricky and isn't the
> norm, and wouldn't be implmented in a client chip driver.

Phil was kind enough to donate me one LCD with a "broken" firmware. This
would stuck the SCL low for good on any read attempts. Otherwise working
unit.

For the keypad, you would just poll with a read byte (?) command,
and it returns nonzero if something was pressed. I don't know if there
is any queue, but how fast a typist are you, really?

There is a patch for (old) LCDProc to do /dev/i2c-x, somewhere.

-- 
  Ky?sti M?lkki  <kyosti.malkki@welho.com>

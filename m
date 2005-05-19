From: mhoffman@lightlink.com (Mark M. Hoffman)
Date: Thu, 19 May 2005 06:25:35 +0000
Subject: I2C/SMBus and Linux
Message-Id: <20050202051941.GA27665@jupiter.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Guido:

I saw your interesting article [1] about using I2C to talk to an Atmel
micro.  I haven't looked at your source code yet, but I'm hoping it is
GPL. ;)

You wrote:
> This I2C bus is unfortunately not available on the outside of the PC
> (there is no physical connector).

That is not always true.  Asus boards often have exposed I2C/SMBus pins
on the board.  At least, both of mine do - it is definitely useful.

Also, I'm surprised that you chose to (re)implement a bus master for
your project... have you never heard of the lm_sensors project?  [2]
Among many other things, it has links to hardware which brings I2C out
of the PC case - usually by parallel port, but a recent schematic for
serial port just popped up on the mailing list too.  Drivers for the
parallel port hardware are already included in the Linux kernel.

Anyway, please check it out. You may even want to join us, I hope... ;)

[1] http://linuxfocus.org/English/February2005/article365.shtml

[2] http://secure.netroedge.com/~lm78/

Regards,

-- 
Mark M. Hoffman
mhoffman@lightlink.com

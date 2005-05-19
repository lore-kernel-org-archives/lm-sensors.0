From: ebs@ebshome.net (Eugene Surovegin)
Date: Thu, 19 May 2005 06:24:53 +0000
Subject: Fw: i2c address probing and AT24RF08 corruption
Message-Id: <20040416200536.GA26252@gate.ebshome.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1082123259.407fe3fb3d41c@imp.gcu.info>
In-Reply-To: <1082123259.407fe3fb3d41c@imp.gcu.info>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Fri, Apr 16, 2004 at 03:54:19PM +0200, Jean Delvare wrote:
> For this reason, I can hardly understand how it was decided that this
> command would be used for address probing purposes. I agree that the
> SMBus spec has no provision for address probing, so we have to use
> another command to achieve this purpose, still I would expect a
> "receive byte" (I2C_FUNC_SMBUS_READ_BYTE) to be way safer than a "quick
> command". The only side effect I can think off is that it would
> increase the address pointer for chips in autoincrement mode, but
> that's about all and it doesn't seem to hurt, really. 

In recent discussion about IBM IIC I mentioned that I had a hw were 1-byte read 
scan locked the bus.

I just rechecked IBM PPC 440GP ref platform "Ebony" and indeed it has an i2c 
device which behaves this way.

According to Ebony manual it's a CDC850 clock buffer (i2c address 0x69). To 
recover the i2c bus I have to reset the whole board, not just I2C controller.

Just my $.02

Eugene.

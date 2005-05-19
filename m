From: ebs@ebshome.net (Eugene Surovegin)
Date: Thu, 19 May 2005 06:24:53 +0000
Subject: Fw: i2c address probing and AT24RF08 corruption
Message-Id: <20040416213701.GA27623@gate.ebshome.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1082123259.407fe3fb3d41c@imp.gcu.info>
In-Reply-To: <1082123259.407fe3fb3d41c@imp.gcu.info>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Fri, Apr 16, 2004 at 11:01:49PM +0200, Jean Delvare wrote:
> > In recent discussion about IBM IIC I mentioned that I had a hw were
> > 1-byte read scan locked the bus.
> > 
> > I just rechecked IBM PPC 440GP ref platform "Ebony" and indeed it has
> > an i2c device which behaves this way.
> > 
> > According to Ebony manual it's a CDC850 clock buffer (i2c address
> > 0x69). To recover the i2c bus I have to reset the whole board, not
> > just I2C controller.
> 
> With "1-byte read" do you refer to SMBus' "quick command" with bit 1:
>   S Addr 1 [A] P
> or "receive byte"?
>   S Addr Rd [A] [Data] NA P

Receive byte of course (your second example), if you remember "quick command" 
isn't implemented for IBM PPC 4xx IIC controller ... yet.

Eugene.

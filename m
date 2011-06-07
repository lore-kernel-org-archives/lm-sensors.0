From: Ben Dooks <ben@trinity.fluff.org>
Date: Tue, 07 Jun 2011 08:18:39 +0000
Subject: Re: [lm-sensors] i2c device w/o registers
Message-Id: <20110607081838.GF16731@trinity.fluff.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <609440.53865.qm@web30206.mail.mud.yahoo.com>
In-Reply-To: <609440.53865.qm@web30206.mail.mud.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


On Mon, Jun 06, 2011 at 05:25:10PM -0700, Randy wrote:
> I have an ADC (MCP3424) that doesn't use registers/commands. 
> 
> To configure the device, you simply write the configuration to the appropriate 
> I2C device address.
> 
> To read the sensor data, you simply issue a read to the device, which will 
> return the ADC sample and the current control register (3 or 4 bytes total, 
> depending on mode).
> 
> All the commands in i2c-tools and the i2c drivers, except for the read/write 
> byte commands, want to take an additional register parameter.  This extra param 
> going over the wire messes up the chip.
> 
> Is there any simple way to support devices that don't support registers?  I 
> searched the archive, and found some requests for a i2c_smbus_read_word() 
> command, but that's about it.

you can send direct i2c commands to the device without any register
access by using i2c_transfer with an "struct i2c_msg" to do anything
you like.

-- 
Ben Dooks, ben@fluff.org, http://www.fluff.org/ben/

Large Hadron Colada: A large Pina Colada that makes the universe disappear.


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

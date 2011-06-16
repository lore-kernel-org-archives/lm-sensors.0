From: Randy <singularity_2@yahoo.com>
Date: Thu, 16 Jun 2011 20:11:12 +0000
Subject: Re: [lm-sensors] i2c device w/o registers
Message-Id: <971811.53473.qm@web30208.mail.mud.yahoo.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <609440.53865.qm@web30206.mail.mud.yahoo.com>
In-Reply-To: <609440.53865.qm@web30206.mail.mud.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I got it working by creating a very basic slave device driver for my ADC 
converter.

For anyone in the same situation, there is a good link here: 
http://www.embedded-bits.co.uk/?s=i2c

But you're right, this was probably more appropriate for the linux i2c list.

Thanks.



----- Original Message ----
From: Jean Delvare <khali@linux-fr.org>
To: Randy <singularity_2@yahoo.com>
Cc: lm-sensors@lm-sensors.org
Sent: Mon, June 6, 2011 11:48:12 PM
Subject: Re: [lm-sensors] i2c device w/o registers

Hi Randy,

On Mon, 6 Jun 2011 17:25:10 -0700 (PDT), Randy wrote:
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
>
> going over the wire messes up the chip.
> 
> Is there any simple way to support devices that don't support registers?  I 
> searched the archive, and found some requests for a i2c_smbus_read_word() 
> command, but that's about it.

This question would have better been asked on the linux-i2c list,
methinks.

Anyway, the I2C commands you need aren't part of the SMBus command
subset, so you have to use raw I2C messaging. The functions you need
are i2c_master_send() and i2c_master_recv() in kernel space. In
user space, you'd simply call read() and write() on the device node. I
don't think there's any example of this in i2c-tools, but the i2c-dev
driver supports it.

-- 
Jean Delvare


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

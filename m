From: Randy <singularity_2@yahoo.com>
Date: Tue, 07 Jun 2011 00:25:10 +0000
Subject: [lm-sensors] i2c device w/o registers
Message-Id: <609440.53865.qm@web30206.mail.mud.yahoo.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I have an ADC (MCP3424) that doesn't use registers/commands. 

To configure the device, you simply write the configuration to the appropriate 
I2C device address.

To read the sensor data, you simply issue a read to the device, which will 
return the ADC sample and the current control register (3 or 4 bytes total, 
depending on mode).

All the commands in i2c-tools and the i2c drivers, except for the read/write 
byte commands, want to take an additional register parameter.  This extra param 
going over the wire messes up the chip.

Is there any simple way to support devices that don't support registers?  I 
searched the archive, and found some requests for a i2c_smbus_read_word() 
command, but that's about it.

thanks,

Randy


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

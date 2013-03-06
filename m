From: Joe Buehl <joe.buehl@buehltech.com>
Date: Wed, 06 Mar 2013 22:02:41 +0000
Subject: [lm-sensors] Support for non-register devices
Message-Id: <5137BD01.6080905@buehltech.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I am new to using I2C so apologies if this has already been addressed 
before.

In trying to communicate with a Honeywell HIH-6130 humidity sensor from 
a RaspberryPi I ran into an apparent limitation of i2c-tools. There 
doesn't seem to be support for reading multiple bytes of data from a 
device that doesn't need a register selected before the read.  This 
device is accessed by first doing a write of just the address, followed 
about 37ms later by a read of 4 bytes, as documented here 
http://www.phanderson.com/arduino/I2CCommunications.pdf.  The write 
operation can be done by using write_quick(), and a subsequent 
read_byte() will get the first byte of data, but multiple calls to 
read_byte() will just get the same first byte again.  Using 
read_i2c_block_data() works better, however, because it sends an 
unneeded command byte, I'm not sure the data returned is valid. There is 
a long discussion of the details in this thread 
http://www.raspberrypi.org/phpBB3/viewtopic.php?f2&t)454.

It seems to me that what is needed is a way to optionally specify that 
no command byte should be sent in read_i2c_block_data() and 
write_i2c_block_data().  While this is not compliant with the SMBus 
protocol, this device doesn't claim to be compliant, and the purpose of 
these two functions seems to be to allow such communications.  I don't 
believe this particular device is unique so there should be other cases 
where this is useful.

I looked at the python wrapper code in smbusmodule.c and it looks easy 
enough to implement something like specifying a value of None for the 
cmd argument to indicate that no command byte should be sent, but 
implementation of the behavior seems to be buried somewhere deep in 
i2c-dev.c or i2c-core.c and I haven't been able to find it.  I see that 
there is work being done in this project to clean up these drivers, so I 
wanted to propose this change, and also offer my help.

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

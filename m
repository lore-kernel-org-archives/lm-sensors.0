From: khali@linux-fr.org (Jean Delvare)
Date: Tue, 01 Nov 2005 16:59:59 +0000
Subject: [lm-sensors] Helps: how to use i801--SMBus functions via
Message-Id: <20051101165935.381720a1.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20051101104855.41881.qmail@web31214.mail.mud.yahoo.com>
In-Reply-To: <20051101104855.41881.qmail@web31214.mail.mud.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Michael,

> Dear Sir,

We are not a sir. We are a number of different people, this is a
mailing list.

> I am new to Linux and Device driver programming. I am trying
> to write a device driver software module to access the ICH6
> SMBus controller on the motherboard of our PC running Linux
> 2.6.10 kernel.

This driver already exists, it's named i2c-i801. From the below, it
seems that you found that already, but your sentence is somewhat
confusing nevertheless.

> I configured my 2.6.10 kernel to have I2C built-in support
> and your i801 module loaded. Then I loaded the i2c-dev
> interface module and wrote a short application software to
> test the functions for SMBus. After my application opened the
> /dev/i2c device, I received messages saying "i2c-adaptor: i2c-0
> -- I2C level transfer not support" when my application software
> called the read and write function of the i2c-dev module. Further
> tracking inside the i2c-dev module shew that the algorithm
> parameter adap->algo->master_xfer = NULL. That means the i801
> driver was not properly loaded by the i2c-dev module.

No, this means just what the error message said. The ICH6 is an SMBus
master, not an I2C master. SMBus is a subset of I2C. I2C masters can
emulate SMBus transactions, but not the other way around.

> Could you advise how I can make use of the i801 module and your
> i2c-dev module to access the ICH6 SMBus controller?

Instead of using read() and write() on the device file, you have to use
ioctl(). See in i2c-dev.h (from the lm_sensors project) for a list of
available commands. You will at least need I2C_SLAVE to set the target
chip address, and I2C_SMBUS to run SMBus transactions. There are helper
functions in i2c-dev.h to make your life easier with SMBus
transactions, so you shouldn't have to use I2C_SMBUS explicitely.

There is some documentation available in the i2c package, or online at:
  http://www2.lm-sensors.nu/~lm78/cvs/i2c/doc/dev-interface

You should take a look at prog/dump/i2cset.c in the lm_sensors package,
it is a nice example of how userspace programs can access SMBus. There
are a few other test programs in this package, but I think this is the
most simple one we have.

-- 
Jean Delvare

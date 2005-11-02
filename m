From: Mingkun.Gu@GTECH.COM (Gu, Mingkun)
Date: Wed, 02 Nov 2005 15:29:39 +0000
Subject: [lm-sensors] RE: Helps: how to use i801--SMBus functions via
Message-Id: <83B4F97F11FDDF4C98DFE32FF982A96A721A9C@cspmail2.gtk.gtech.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20051101104855.41881.qmail@web31214.mail.mud.yahoo.com>
In-Reply-To: <20051101104855.41881.qmail@web31214.mail.mud.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Could anyone advise how I can make use i2c-i801 and/or i2c-dev to access
ICH6 SMBus controller on a PC motherboard? I have Linux 2.6.10 and
loaded i2c-core, i2c-i801and i2c-dev modules. lsmod command gave me the
following info:

 

# lsmod

Module                  Size  Used by

i2c_dev                 8320  0

i2c_sensor              3968  0

i2c_i801                8716  0

i2c_core               16272  3 i2c_dev,i2c_sensor,i2c_i801

 

It seems that i2c-i801 is not used by other modules.

 

Thanks.

Michael Gu

 

-----Original Message-----
From: MK GU [mailto:mkgu_2005@yahoo.ca] 
Sent: Tuesday, November 01, 2005 6:49 AM
To: lm-sensors@lm-sensors.org
Cc: Gu, Mingkun
Subject: Helps: how to use i801--SMBus functions via i2c-dev module in
Linux?

 

Dear Sir,

 

I am new to Linux and Device driver programming. I am trying to write a
device driver software module to access the ICH6 SMBus controller on the
motherboard of our PC running Linux 2.6.10 kernel. I configured my
2.6.10 kernel to have I2C built-in support and your i801 module loaded.
Then I loaded the i2c-dev interface module and wrote a short application
software to test the functions for SMBus. After my application opened
the /dev/i2c device, I received messages saying "i2c-adaptor: i2c-0 --
I2C level transfer not support" when my application software called the
read and write function of the i2c-dev module. Further tracking inside
the i2c-dev module shew that the algorithm parameter
adap->algo->master_xfer = NULL. That means the i801 driver was not
properly loaded by the i2c-dev module.

 

Could you advise how I can make use of the i801 module and your i2c-dev
module to access the ICH6 SMBus controller?

 

Thanks a lot in advance.

Michael Gu

 

  _____  

Find your next car at Yahoo! Canada Autos <http://autos.yahoo.ca> 




-----------------------------------------
This email may contain confidential and privileged material for the
sole use of the intended recipient(s). Any review, use, retention,
distribution or disclosure by others is strictly prohibited. If you are
not the intended recipient (or authorized to receive for the
recipient), please contact the sender by reply email and delete all
copies of this message. Also, email is susceptible to data corruption,
interception, tampering, unauthorized amendment and viruses. We only
send and receive emails on the basis that we are not liable for any
such corruption, interception, tampering, amendment or viruses or any
consequence thereof.

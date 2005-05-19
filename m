From: skumar@ariodata.com (Sanjay Kumar)
Date: Thu, 19 May 2005 06:23:36 +0000
Subject: quick question regarding access of LM75 via /dev file system
Message-Id: <8A098FDFC6EED94B872CA2033711F86F0EC404@orion.ariodata.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

Sorry for posting this mail!!!!!

How can i access the different register of LM75 using /dev file system
interface. I do the following steps:

	1. open (/dev.......................)
	2. ioctl(fd, I2C_SLAVE, i2c-addr); i2c-addr : slave address for
LM75.
	3. read/write

Now using read command how do i access the different register of LM75
(Ex. conf register, temp register, hyst register etc)
Again , how do I write it in these register?
	if i do  read(fd, buf, 1) : which register's data it will return
to me. 

Will somebody help me here pls.???

Thankx in advance,
Sanjay


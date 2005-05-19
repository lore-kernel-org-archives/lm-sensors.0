From: mds@paradyne.com (Mark D. Studebaker)
Date: Thu, 19 May 2005 06:23:37 +0000
Subject: quick question regarding access of LM75 via /dev file system
Message-Id: <3D51D548.4F5E1E52@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <8A098FDFC6EED94B872CA2033711F86F0EC404@orion.ariodata.com>
In-Reply-To: <8A098FDFC6EED94B872CA2033711F86F0EC404@orion.ariodata.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

prog/dump/i2cdump.c in our package is a good example


Sanjay Kumar wrote:
> 
> Hi,
> 
> Sorry for posting this mail!!!!!
> 
> How can i access the different register of LM75 using /dev file system
> interface. I do the following steps:
> 
>         1. open (/dev.......................)
>         2. ioctl(fd, I2C_SLAVE, i2c-addr); i2c-addr : slave address for
> LM75.
>         3. read/write
> 
> Now using read command how do i access the different register of LM75
> (Ex. conf register, temp register, hyst register etc)
> Again , how do I write it in these register?
>         if i do  read(fd, buf, 1) : which register's data it will return
> to me.
> 
> Will somebody help me here pls.???
> 
> Thankx in advance,
> Sanjay

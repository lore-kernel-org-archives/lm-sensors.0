From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:31 +0000
Subject: 2.6 user space tools
Message-Id: <20031224173746.3fda9657.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <Pine.LNX.4.44.0312212204030.14510-100000@ahoj.fsik.cvut.cz>
In-Reply-To: <Pine.LNX.4.44.0312212204030.14510-100000@ahoj.fsik.cvut.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> Besides I was very disappointed that 2.6.0 has only few lmsensors and
> i2c modules inside

All i2c drivers are there AFAIK. Several lm_sensors modules are missing
simply because we lack time to port them. If you want to help porting
drivers, let me know and I'll point you to the relevant document.

> (btw. from 2.8.x my chips detect as w83627hf instead w83781d and
> w83781d is not working anymore)

Release 2.8.1 introduced a few detection problems for the Winbond chips
(my fault) which are hopefully fixed in 2.8.2. Let us know if it isn't.

> I was also not able to compile user space tools from 2.8.2.
> 
> "make user" end's up like this:
> 
> make: *** No rule to make target `asm-generic/errno.h', needed by 
> `prog/sensors/main.rd'.  Stop.

Never heard about "asm-generic". Which system are you trying to compile
lm_sensors on? Make sure you have changed I2C_HEADERS in the Makefile to
point to your Linux 2.6.0 sources. Also check that
/usr/include/{linux,asm} are not symbolic links to your Linux sources
but real directories containing the kernel headers used to compile your
glibc.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/

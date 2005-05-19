From: aurelien@aurel32.net (=?ISO-8859-1?Q?Aur=E9lien_Jarno?=)
Date: Thu, 19 May 2005 06:25:32 +0000
Subject: new bus driver
Message-Id: <41F68BB5.8000100@aurel32.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <Pine.LNX.4.61.0501251912150.26717@zebra.tky.hut.fi>
In-Reply-To: <Pine.LNX.4.61.0501251912150.26717@zebra.tky.hut.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jaakko Ala-Paavola wrote:
> Hi, 
> I'm planning to implement a bus driver for a simple homebrew 
> serial port I2C-adapter:
> 
> http://vodka.tky.hut.fi/~jap/Electronics/I2C/SerialAdapter/index.html
> 
> The original design is mine, but I just got confirmation from a hacker in 
> Italy that the device actually does work. Unfortunately the guy wrote 
> the driver for Windows only. Thus I decided to implement one for linux.
> 
> I checked the list of supported bus drivers and didn't found anything 
> related to serial port. Do you feel that kind of project usefull?
I think it could be useful, at least I think I will build my own one. I 
already have the same kind of hardware, but for parallel port. And it is 
supported by lm-sensors!

On the sofware point of view, have a look to the files
- drivers/i2c/busses/i2c-parport.c
- drivers/i2c/busses/i2c-parport-light.c
on a 2.6 kernel tree. These are two different implementations for the 
same adapter. The first one accesses the parallel port via parport and 
the second one directly with inb and outb. The first one has the 
advantage to be portable (ie it works on non-i386 arches), whereas the 
second one is speed efficient. Anyway, you will see that in both cases, 
most of the job is already done by i2c-algo-bit, you just have to drive 
the SCL and SDA lines.

For your case you also have the possibility to access the serial port 
directly or via serio. I don't know a lot about serio, but it seems 
there is some examples in the kernel (serial mouses, some joysticks).

Bye,
Aurelien

-- 
   .''`.  Aurelien Jarno               GPG: 1024D/F1BCDB73
  : :' :  Debian GNU/Linux developer | Electrical Engineer
  `. `'   aurel32@debian.org         | aurelien@aurel32.net
    `-    people.debian.org/~aurel32 | www.aurel32.net

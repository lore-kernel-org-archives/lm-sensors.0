From: jamesd@jml.net (James Davis)
Date: Fri, 31 Mar 2006 12:45:39 +0000
Subject: [lm-sensors] Problems with i2c_i801
Message-Id: <1143809139.7300.1.camel@cressida.cert>
List-Id: <lm-sensors.vger.kernel.org>
References: <1143796746.10346.10.camel@cressida.cert>
In-Reply-To: <1143796746.10346.10.camel@cressida.cert>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Fri, 2006-03-31 at 13:15 +0200, Jean Delvare wrote:

> OK. Can you make sure that libsensors was compiled with sysfs support?
> "ldd /usr/lib/libsensors.so" should have one line for libsysfs.

It's there...

james at cressida:~$ ldd /usr/lib/libsensors.so.3
        linux-gate.so.1 =>  (0xffffe000)
        libc.so.6 => /lib/tls/libc.so.6 (0xb7df3000)
        libm.so.6 => /lib/tls/libm.so.6 (0xb7dcc000)
        libsysfs.so.1 => /lib/libsysfs.so.1 (0xb7dc1000)
        /lib/ld-linux.so.2 (0x80000000)

> You have a Super-I/O chip (a.k.a. LPC chip) we don't know about. Given
> the output above, this could be a chip made by ITE, National
> Semiconductor or SMSC. Can you find some documentation about your board
> and/or open the case and locate that chip? Typically they are
> rectangular, with 128 pins, and measure about 20 mm by 12 mm. Sometimes
> these chips have hardware monitoring functionalities.

I found the following SMSC chip:

LPC47M584-NC
B0443-AL1314
8H1190280

Here's a link to a photograph.

http://www.freecharity.org.uk/~james/DSC00300.JPG

> Does the BIOS of your system display any hardware monitoring
> information? Is this system somehow advertise as having hardware
> monitoring capabilities?

Nothing there, I guess that doesn't bode well..

Many thnaks for your help,

James



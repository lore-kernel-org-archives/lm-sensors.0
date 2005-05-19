From: phil@netroedge.com (phil@netroedge.com)
Date: Thu, 19 May 2005 06:23:34 +0000
Subject: could not modprobe lm_sensors
Message-Id: <20020619093146.E1893@Stimpy.netroedge.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <02061912255602.01687@shoarma.mdsoft.net>
In-Reply-To: <02061912255602.01687@shoarma.mdsoft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


It doesn't look like you have I2C support built into your kernel?
lm_sensors depends on I2C to work.  The latest I2C package is
available on our web site.  It's the same code as what's in the kernel
(under character device drivers), although perhaps a little more
current.


Phil

On Wed, Jun 19, 2002 at 12:25:56PM +0200, KheOps wrote:
> Hello,
> 
> I aplogize for mailing to this address, but I don't know where I shoud mail 
> elsewhere.
> I have a problem with lm_sensors: it successfully compiles, but fails to 
> modprobe. Reporting to your FAQ, it seems that I have a versionning problem:
> # depmod -a -e gives:
> [...]
> depmod: *** Unresolved symbols in /lib/modules/2.4.17/misc/i2c-viapro.o
> depmod:         i2c_del_adapter_R97e1c952
> depmod:         i2c_add_adapter_Rd50a523b
> [...]
> 
> # nm --extern /lib/modules/2.4.17/misc/i2c-viapro.o gives:
> [...]
>          U printk_R1b7d4074
> [...]
> # grep printk /proc/ksyms gives:
> c0116630 printk_R1b7d4074
> 
> # dmesg gives no output (!?)
> 
> I compiled the module with the 2.4.17 kernel sources, and i'm running this 
> kernel, that is why I don't understand where the probleme come from. My 
> original distribution is a Mandrake, which is quite similar to a RedHat, my 
> modutils version is 2.4.4.
> What should I do ?
> 
> Thank you for helping me,
> A. Merel

-- 
Philip Edelbrock -- IS Manager -- Edge Design, Corvallis, OR
   phil@netroedge.com -- http://www.netroedge.com/~phil
 PGP F16: 01 D2 FD 01 B5 46 F4 F0  3A 8B 9D 7E 14 7F FB 7A

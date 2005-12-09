From: petit.frederic@free.fr (fred)
Date: Fri, 09 Dec 2005 19:41:12 +0000
Subject: [lm-sensors] i2cdetect fails on a Asus P5ND2-Sli
Message-Id: <4399DDD8.2060608@free.fr>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

fred a ?crit :
> Hi,
> 
> My kernel is 2.6.14, i2c-nforce2 & it87, which are known to work
> with lm-sensors, are built-in kernel, on a Debian sarge.
> 
> it87 works fine (I'll come back later on this, I have a few questions),
> but i2c-nforce2 fails :
> marsu{pts/0}:~/[1]/> i2cdetect
> Error: No i2c-bus specified!
> Syntax: i2cdetect [-y] [-a] [-q|-r] I2CBUS [FIRST LAST]
>         i2cdetect -l
>         i2cdetect -V
>   I2CBUS is an integer
>   With -a, probe all addresses (NOT RECOMMENDED)
>   With -q, uses only quick write commands for probing (NOT RECOMMENDED)
>   With -r, uses only read byte commands for probing (NOT RECOMMENDED)
>   If provided, FIRST and LAST limit the probing range.
>   With -l, lists installed busses only
> Error: No I2C busses found!
> Be sure you have done 'modprobe i2c-dev'
> and also modprobed your i2c bus drivers
> 
> My kernel is set as :
> 
> CONFIG_I2C=y
> CONFIG_I2C_CHARDEV=y
> CONFIG_I2C_ALGOBIT=y
> CONFIG_I2C_ISA=y
> CONFIG_I2C_NFORCE2=y
> CONFIG_FB_NVIDIA_I2C=y (for framebuffer, but now, it's not the problem)
> 
> 
> What's wrong ??
And lspci sounds good :

0000:00:0a.0 ISA bridge: nVidia Corporation: Unknown device 0030 (rev a3)
        Subsystem: Asustek Computer, Inc.: Unknown device 818a
        Flags: bus master, 66MHz, fast devsel, latency 0

0000:00:0a.1 SMBus: nVidia Corporation: Unknown device 0034 (rev a2)
        Subsystem: Asustek Computer, Inc.: Unknown device 818a
        Flags: 66MHz, fast devsel, IRQ 3
        I/O ports at e400 [size2]
        I/O ports at 5000 [sized]
        I/O ports at 5100 [sized]
        Capabilities: <available only to root>



-- 
Fred.


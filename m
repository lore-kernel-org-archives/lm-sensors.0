From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:45 +0000
Subject: lm_sensors problem booting after install
Message-Id: <20040304230913.027fea3c.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <4044E51F.9050908@pacbell.net>
In-Reply-To: <4044E51F.9050908@pacbell.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> Sorry for the less then informative email.  Here is the particulars
> 
> i2c-2.8.4  lm_sensors-2.8.4

How did you install i2c-2.8.4?

> modprobe it87 did some strange things to the kernal which prevented
> the mouse, iptables, and the Nvidia video drivers from working
> correctly. I was going to include the boot.log sections but they are
> mysteriously blank.

Very strange. In your original mail you say that the problems occured
after the next reboot. Do you confirm this, or there where already
problems right after loading it87? Did the problem finally wear off?

> [root@AMD64Home doc]# /sbin/modprobe i2c-piix4
> /lib/modules/2.4.20-30.9/kernel/drivers/i2c/busses/i2c-piix4.o:
> unresolved symbol dmi_scan_mach
> /lib/modules/2.4.20-30.9/kernel/drivers/i2c/busses/i2c-piix4.o: insmod
> /lib/modules/2.4.20-30.9/kernel/drivers/i2c/busses/i2c-piix4.o failed
> /lib/modules/2.4.20-30.9/kernel/drivers/i2c/busses/i2c-piix4.o: insmod
> i2c-piix4 failed

Any reason you thought it would do something useful? If any chip driver
would work for you, I'd bet on i2c-nforce2.

> If you need any other info please just ask. 

I admit I'm rather puzzled since the init sequence of the it87 has been
drastically cut down in this version. according to you dump it shouldn't
even do anything at all. So the simple fact that something happens as
you load it87 is strange.

Could you please provide the full output of sensors-detect (preferably this one:
http://www2.lm-sensors.nu/~lm78/cvs/lm_sensors2/prog/detect/sensors-detect
)?

> I was hoping to get partial info from the ite chip.
> 
> after placing the following in the /etc/modules.conf
> 
> alias eth1 tulip
> alias char-major-195 nvidia
> # I2C module options
> alias char-major-89 i2c-dev
> options it87 ignore=-1,0x290
                      ^^^^^^^^

What the hell is that? Did sensors-detect told you to do that? The "-1"
is just silly. You better remove that line from the file, it's a
non-sense.

Thanks.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/

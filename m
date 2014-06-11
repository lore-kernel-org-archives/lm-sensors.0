From: Mike Dixon <qualitydixon@gmail.com>
Date: Wed, 11 Jun 2014 21:32:33 +0000
Subject: Re: [lm-sensors] [lm85] Sensors yields triplicate output
Message-Id: <CAGTLiboZSy8oj1RWr5Hz0zE8=9tQ9xJ3+k_LiOzZtmVDjCaQUA@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <CAGTLibq22gJ-GzaVagS7JDL=fNnHs6nhxTeD_OVKoMrHYPwhmw@mail.gmail.com>
In-Reply-To: <CAGTLibq22gJ-GzaVagS7JDL=fNnHs6nhxTeD_OVKoMrHYPwhmw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean,

I have NOT installed a separate lm85 driver. I will gladly test your patch.



*System Info:*System: Sunware 0073351-01 05/16/2007 [SE7230NH1LX]
Board: Intel Corporation SE7230NH1LX

*Kernel Version*:

2.6.32-431.17.1.el6.i686


*sensors-detect output (not sure if you wanted the whole thing or just the
summary):*

Driver `lm85':
  * Bus `Radeon i2c bit bus DVI_DDC'
    Busdriver `drm', I2C address 0x2e
    Chip `lm85' (confidence: 6)
  * Bus `SMBus I801 adapter at 3000'
    Busdriver `i2c_i801', I2C address 0x2c
    Chip `lm85' (confidence: 6)
  * Bus `SMBus I801 adapter at 3000'
    Busdriver `i2c_i801', I2C address 0x2e
    Chip `lm85' (confidence: 6)



*i2c dumps:*
Only the '0 0x2e' i2c dump worked (pasted below). The other two yielded
errors:

[user@localhost]# i2cdump -y 4 0x2c > /tmp/lm85-i2c-4-2c.dump
No size specified (using byte-data access)
Error: Could not open file `/dev/i2c-4' or `/dev/i2c/4': No such file or
directory
[user@localhost]# i2cdump -y 4 0x2e > /tmp/lm85-i2c-4-2e.dump
No size specified (using byte-data access)
Error: Could not open file `/dev/i2c-4' or `/dev/i2c/4': No such file or
directory

     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
00: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
10: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
20: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
30: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
40: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
50: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
60: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
70: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
80: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
90: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
a0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
b0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
c0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
d0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
e0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
f0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX




On Wed, Jun 11, 2014 at 8:55 AM, Jean Delvare <jdelvare@suse.de> wrote:

> Hi Mike,
>
> On Wed, 11 Jun 2014 08:19:22 -0600, Mike Dixon wrote:
> > I have a board in which sensors is giving me essentially three outputs
> for
> > the same chip (see below). I haven't been able to find anyone else with
> > this problem. Has anyone seen this before?
>
> Not that I can remember, no.
>
> Please note: you are not seeing 3 different outputs from the same chip.
> The driver sees 3 devices. Some could be misdetections, but they are
> definitely separate chips.
>
> > As you can see, two of the
> > outputs give erroneous data. Do you know how I could disable two of the
> > adapters so I only get one output?
>
> Difficult. You can't prevent the driver from binding to the devices.
> What you can do is unbind the driver afterward. As root:
> # echo 0-002e > /sys/bus/i2c/drivers/lm85/unbind
> # echo 4-002c > /sys/bus/i2c/drivers/lm85/unbind
>
> I think you'll need a kernel with hot-plug support, but that should
> pretty much be the default these days.
>
> You can put the above in some init script, however this assumes that
> the I2C bus numbers are stable, which is not guaranteed. Also this must
> be done _after_ the lm85 driver is loaded.
>
> > I have already tried altering the
> > sensors3.conf file. But any use of wildcards other than "lm85-*" yields
> an
> > error. For example I tried "lm85-i2c-4-2e", "*-4-*" and they did not
> work.
>
> Any reference to an I2C bus number requires that you first map this bus
> number to an actual I2C bus, by name, using a "bus" statement. This is
> explained in the sensors.conf man page.
>
> > I am running CentOS 6.4 with lm_sensors 3.1.1. Thanks.
>
> We would also need to know your kernel version and also which piece of
> hardware you're seeing this on. Also please let us know if you
> installed a separate lm85 driver.
>
> Please also unload the lm85 driver and run a recent version of
> sensors-detect [1], and show us the output.
>
> [1] http://dl.lm-sensors.org/lm-sensors/files/sensors-detect
>
> I would also appreciate dumps from all 3 devices. Install i2c-tools,
> then:
> # modprobe i2c-dev
> # i2cdump -y 0 0x2e > /tmp/lm85-i2c-0-2e.dump
> # i2cdump -y 4 0x2c > /tmp/lm85-i2c-4-2c.dump
> # i2cdump -y 4 0x2e > /tmp/lm85-i2c-4-2e.dump
>
> Most likely the lm85 driver is misdetecting devices. The 1st one at
> least looks plain wrong. The 2nd one might be real, especially if this
> is a 2-CPU system. The 3rd one looks totally correct.
>
> There is generic detection code in the driver which could lead to that,
> I think it should be removed. I have a patch ready which I will post
> soon, and I would also appreciate if you could test an updated version
> of the lm85 driver. But first I need the information above.
>
> --
> Jean Delvare
> http://jdelvare.nerim.net/wishlist.html
>



-- 
Mike Dixon
_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

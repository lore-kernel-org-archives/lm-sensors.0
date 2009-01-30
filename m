From: Jean Delvare <khali@linux-fr.org>
Date: Fri, 30 Jan 2009 17:29:36 +0000
Subject: Re: [lm-sensors] HP VL400 sensors (2)
Message-Id: <20090130182936.28263fab@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <5a54eff70901271130p1a948a5clb67baf0c93b8fa@mail.gmail.com>
In-Reply-To: <5a54eff70901271130p1a948a5clb67baf0c93b8fa@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Bonjour Guillaume,

On Tue, 27 Jan 2009 20:30:16 +0100, Guillaume Delacour wrote:
> Hello,
> 
> I have an HP VL 400 (Version: R3B, P/N: D9820-60011) motherboard. None
> of hardware status are displayed.

You mean in the BIOS?

> I want to know if is it possible to have temperature and more if
> possible (voltage ?) via sensors:
> 
> # sensors
> pc87360-isa-0820
> Adapter: ISA adapter
> fan1:        0 RPM  (min =  952 RPM, div = 8)          OVERFLOW
> fan2:     1290 RPM  (min =  944 RPM, div = 4)
> 
> I just have fan2 speed value; fan1 is not plugged yet :)

The National Semiconductor PC87360 Super-I/O chip only has 2 fan speed
monitoring inputs, not a full hardware monitoring block as the PC87365
and PC87366 have.

> (...)
> # i2cdetect -l
> i2c-3   i2c             MAVEN:fb0
> Algorithm unavailable
> i2c-2   i2c             DDC:fb0 #1
> Algorithm unavailable
> i2c-1   i2c             DDC:fb0 #0
> Algorithm unavailable
> i2c-0   smbus           SMBus I801 adapter at 1810
> Non-I2C SMBus adapter
> # i2cdetect 0
> WARNING! This program can confuse your I2C bus, cause data loss and worse!
> I will probe file /dev/i2c-0.
> I will probe address range 0x03-0x77.
> Continue? [Y/n]
>      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
> 00:          XX XX XX XX XX XX XX XX XX XX XX XX XX
> 10: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
> 20: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
> 30: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
> 40: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
> 50: UU UU XX XX UU UU XX XX XX XX XX XX XX XX XX XX
> 60: XX XX XX XX XX XX XX XX XX 69 XX XX XX XX XX XX
> 70: XX XX XX XX XX XX XX XX

And nothing beyond EEPROMs on your SMBus.

> (...)
> Modules are loaded successfully except *i2c-i801*.

The i2c-i801 driver seems to be well loaded, as seen in the i2cdetect
output above.

> Please note that i have tried last lm-sensors version 3.0.3 (by
> sources) and there is same behaviour with sensors-detect/sensors.
> 
> Thanks and sorry if this is a my-side-configuration problem.

No, it is not. Apparently your hardware doesn't include hardware
monitoring features except for the 2 fan inputs on the PC87360. If the
chip is properly wired on the motherboard you may be able to also
control the speed of these fans, but that's about it.

-- 
Jean Delvare
http://khali.linux-fr.org/wishlist.html

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

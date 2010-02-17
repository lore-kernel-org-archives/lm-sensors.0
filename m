From: "Artem S. Tashkinov" <birdie@permonline.ru>
Date: Wed, 17 Feb 2010 20:08:04 +0000
Subject: Re: [lm-sensors] A question regarding ASRock H55DE3 motherboard
Message-Id: <4B7C4CA4.5000306@permonline.ru>
List-Id: <lm-sensors.vger.kernel.org>
References: <4B7A403E.7000103@permonline.ru>
In-Reply-To: <4B7A403E.7000103@permonline.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 02/18/2010 12:19 AM, Jean Delvare wrote:

Hello, Jean,

 > Hi Artem,
 >
 > On Tue, 16 Feb 2010 11:50:38 +0500, Artem S. Tashkinov wrote:
 >> I've recently become an owner of the aforementioned motherboard and I
 >> have no idea how to monitor it in Linux.
 >>
 >> sensors-detect says that:
 >> --------------------------------------------------------------------
 >> Now follows a summary of the probes I have just done.
 >> Just press ENTER to continue:
 >>
 >> Driver `adt7473':
 >>     * Bus `NVIDIA i2c adapter '
 >>       Busdriver `nvidia', I2C address 0x2e
 >>       Chip `Analog Devices ADT7473' (confidence: 5)
 >>
 >> Driver `to-be-written':
 >>     * ISA bus, address 0x290
 >>       Chip `Nuvoton W83667HG-B Super IO Sensors' (confidence: 9)
 >>
 >> Warning: the required module adt7473 is not currently installed
 >> on your system. If it is built into the kernel then it's OK.
 >> Otherwise, check http://www.lm-sensors.org/wiki/Devices for
 >> driver availability.
 >
 > This driver should be available. If it's not there, this suggests that
 > you did not set CONFIG_SENSORS_ADT7473=m when building your kernel. You
 > should have...

I will try to build this driver and report if it shows anything.

 >
 > (Note: starting with kernel 2.6.33 you will have to use the adt7475
 > driver instead.)
 >
 >> Note: there is no driver for Nuvoton W83667HG-B Super IO Sensors yet.
 >> Check http://www.lm-sensors.org/wiki/Devices for updates.
 >
 > We indeed do not support this chip yet. I've added your request to the
 > list on wiki/Devices.
 >
 >> No modules to load, skipping modules configuration.
 >> --------------------------------------------------------------------
 >> however what really confuses me is that Windows hwmon115 says that I
 >> have Winbond W832627DHG monitoring chip which is theoretically supported
 >> by lm-sensors/i2c. However both w83627ehf.ko and w83627hf.ko modules
 >> don't load with "No such device" error.
 >
 > I would trust sensors-detect. Maybe that Windows tool has decided that
 > the chips are compatible enough that the W83667HG-B can be handled as a
 > W83627DHG, at least for the feature subset it handles. Only a careful
 > inspection of the datasheets would tell. You may want to try loading
 > the w83627ehf driver with parameters force_id=0xa020 (to have the
 > driver treat your chip as a W83627DHG), force_id=0xb070 (to have the
 > driver treat your chip as a W83627DHG-P) or force_id=0xa510 (to have
 > the driver treat your chip as a W83667HG). Beware though that this is
 > untested by definition and we do not make any guarantee. It may
 > somewhat work for monitoring, but for example I wouldn't dare trying
 > fan speed control.

It looks like it's my own blunder: I have confused w83_2_627 to w83627 
:) and taking into consideration ASRock's documentation my chip is 
indeed made by Nuvoton and it's currently unsupported - I'm eagerly 
awaiting patches to be merged.

 >
 >> Another question is that hwmon115 detects temperatures and even power
 >> draw of my Intel Core i5 CPU however sensors-detect doesn't even mention
 >> this possibility.
 >
 > CPU core temperature support could certainly be added to the coretemp
 > driver. We are waiting for Intel to help. Huaxu, any progress?
 >
 > The power draw value is news to me, maybe this is a new feature of the
 > Core i5 which could be added to the driver as well.
 >
 >> I'm now running 2.6.32.8 vanilla kernel.
 >

-- 

Best wishes,

Artem

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

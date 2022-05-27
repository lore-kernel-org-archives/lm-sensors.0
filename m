From: Dag B <dag@bakke.com>
Date: Fri, 27 May 2022 10:31:04 +0000
Subject: Re: dht11 vs iio-hwmon
Message-Id: <3a1e7298-3dfb-4622-2d59-be68792d427b@bakke.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <e437eea6-9027-fa9e-22ba-5710672530b6@bakke.com>
In-Reply-To: <e437eea6-9027-fa9e-22ba-5710672530b6@bakke.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: lm-sensors@vger.kernel.org


On 25.05.2022 18:18, Dag B wrote:
>
> Hi.
>
> I have managed to make use of the dht11 driver and can get data from 
> my sensor quite reliably.
>
> I wanted to be able to read this sensor via lm-sensors, and was hoping 
> to employ the iio-hwmon bridge for this purpose. Sadly, I do not get 
> any nodes in the /sys/class/hwmon/ directory for the dht11 sensor.
>
> Do iio-drivers (like dht11) have to be written with this bridge in 
> mind, in order to get the hwmon entries? Or am I just missing a touch 
> of magic somewhere?
>
> root@rpi2:/boot# lsmod | egrep 'iio|hw|dht'
> dht11                  16384  0
> iio_hwmon              16384  0
> raspberrypi_hwmon      16384  0
> industrialio           81920  2 iio_hwmon,dht11
> root@rpi2:/boot# cat /sys/bus/iio/devices/iio\:device0/in_temp_input
> 19400
> root@rpi2:/boot# ls -l /sys/class/hwmon/
> total 0
> lrwxrwxrwx 1 root root 0 May 25 08:59 hwmon0 -> ../../devices/virtual/thermal/thermal_zone0/hwmon0
> lrwxrwxrwx 1 root root 0 May 25 08:59 hwmon1 -> ../../devices/platform/soc/soc:firmware/raspberrypi-hwmon/hwmon/hwmon1


So, I have employed my "monkey see, monkey do"-mode. I realize that 
other iio-drivers got something like this in the device tree specification:

         iio-hwmon {

                 compatible = "iio-hwmon";
                 io-channels = <&something N>, <&something N+1>;

                 };

Where 'something' most often is 'adc' and N is an integer. 'something' 
may also be 'tlaNNNN' or 'gpadc'.

'something' is either defined in the .dts file or an included .dtsi 
file. I have not yet managed to deduce to what extent these definitions 
are tied to the device-driver. If someone would be so kind to offer 
distilled insights, I would really appreciated it. My C-foo is weak, but 
the itch is real.


The dht11 driver provides for temperature and humidity through a single 
GPIO pin.

drivers/iio/humidity/dht11.c

The .dts file is at:

./arch/arm/boot/dts/overlays/dht11-overlay.dts


And one more thing. This file:

https://www.kernel.org/doc/Documentation/devicetree/bindings/iio/iio-bindings.txt

.... does not exist in the git kernel tree. Is that expected?


Thanks,


Dag B




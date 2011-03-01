From: =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali.rohar@gmail.com>
Date: Tue, 01 Mar 2011 18:46:29 +0000
Subject: Re: [lm-sensors] f75375s detected but no temp output
Message-Id: <AANLkTinmYC-420atOLn0meRtC7p4Cb9pgbT07Kdv-gmT@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <AANLkTimosNm7_k9scygyWZuWZPunJ=wteQ+UgFB2-Gn8@mail.gmail.com>
In-Reply-To: <AANLkTimosNm7_k9scygyWZuWZPunJ=wteQ+UgFB2-Gn8@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: lm-sensors@vger.kernel.org

2011/3/1 Jean Delvare <khali@linux-fr.org>:
> On Tue, 1 Mar 2011 19:19:02 +0100, Pali Rohár wrote:
>> I commented code ..if ( port = 2 ).. there is only
>>
>> pI2cAdapter->class = I2C_CLASS_HWMON
>>
>> so it is called for every port. But sensors still not working :( Any
>> other hints?
>
> Please provide the output of the following command:
>
> $ grep . /sys/class/hwmon/hwmon*/{,device/}name

grep: /sys/class/hwmon/hwmon*/name: No such file or directory
/sys/class/hwmon/hwmon0/device/name:k8temp
/sys/class/hwmon/hwmon1/device/name:it8712

>
> Please also try the following (as root) and see it it helps (assuming
> i2c-4 always corresponds to the I2C bus where sensors-detect finds the
> F75375S/SP chip):
>
> # echo f75375 0x2e > /sys/bus/i2c/devices/i2c-4/new_device

Wow. After running this command sensors start reporting values :)

$ sensors
...
f75375-i2c-4-2e
Adapter: NVIDIA i2c adapter
in0:         +1.67 V  (min =  +0.00 V, max =  +2.04 V)
in1:         +1.01 V  (min =  +0.00 V, max =  +2.04 V)
in2:         +1.00 V  (min =  +0.00 V, max =  +2.04 V)
in3:         +1.03 V  (min =  +0.00 V, max =  +2.04 V)
fan1:       4702 RPM  (min =    0 RPM)
fan2:          0 RPM  (min =    0 RPM)
temp1:       +51.0°C  (high = +60.0°C, hyst = +55.0°C)
temp2:       +41.0°C  (high = +60.0°C, hyst = +55.0°C)
...

Thanks a lot! This solved my problem.

One question. Is problem in proprietary nvidia driver or in f75375s
driver (or else)? I think that your "hack" is not normal solution...

>
> This should instantiate the device regardless of the detection code of
> the f75375s driver.
>
> --
> Jean Delvare
> http://khali.linux-fr.org/wishlist.html
>



-- 
Pali Rohár
pali.rohar@gmail.com

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

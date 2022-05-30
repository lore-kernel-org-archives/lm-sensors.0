From: Dag B <dag@bakke.com>
Date: Mon, 30 May 2022 12:07:41 +0000
Subject: Re: dht11 vs iio-hwmon
Message-Id: <e84fe076-fc1e-3f9f-2c21-9a667536f4dd@bakke.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------h6inEjmw57GvtM59OkVAv1sZ"
List-Id: <lm-sensors.vger.kernel.org>
References: <e437eea6-9027-fa9e-22ba-5710672530b6@bakke.com>
In-Reply-To: <e437eea6-9027-fa9e-22ba-5710672530b6@bakke.com>
To: lm-sensors@vger.kernel.org

This is a multi-part message in MIME format.
--------------h6inEjmw57GvtM59OkVAv1sZ
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit


On 27.05.2022 12:31, Dag B wrote:
>
> On 25.05.2022 18:18, Dag B wrote:
>>
>> Hi.
>>
>> I have managed to make use of the dht11 driver and can get data from 
>> my sensor quite reliably.
>>
>> I wanted to be able to read this sensor via lm-sensors, and was 
>> hoping to employ the iio-hwmon bridge for this purpose. Sadly, I do 
>> not get any nodes in the /sys/class/hwmon/ directory for the dht11 
>> sensor.
>>
>> Do iio-drivers (like dht11) have to be written with this bridge in 
>> mind, in order to get the hwmon entries? Or am I just missing a touch 
>> of magic somewhere?
>>
>> root@rpi2:/boot# lsmod | egrep 'iio|hw|dht'
>> dht11                  16384  0
>> iio_hwmon              16384  0
>> raspberrypi_hwmon      16384  0
>> industrialio           81920  2 iio_hwmon,dht11
>> root@rpi2:/boot# cat /sys/bus/iio/devices/iio\:device0/in_temp_input
>> 19400
>> root@rpi2:/boot# ls -l /sys/class/hwmon/
>> total 0
>> lrwxrwxrwx 1 root root 0 May 25 08:59 hwmon0 -> 
>> ../../devices/virtual/thermal/thermal_zone0/hwmon0
>> lrwxrwxrwx 1 root root 0 May 25 08:59 hwmon1 -> 
>> ../../devices/platform/soc/soc:firmware/raspberrypi-hwmon/hwmon/hwmon1
>
>
> So, I have employed my "monkey see, monkey do"-mode. I realize that 
> other iio-drivers got something like this in the device tree 
> specification:
>
>         iio-hwmon {
>
>                 compatible = "iio-hwmon";
>                 io-channels = <&something N>, <&something N+1>;
>
>                 };
>
> Where 'something' most often is 'adc' and N is an integer. 'something' 
> may also be 'tlaNNNN' or 'gpadc'.
>
> 'something' is either defined in the .dts file or an included .dtsi 
> file. I have not yet managed to deduce to what extent these 
> definitions are tied to the device-driver. If someone would be so kind 
> to offer distilled insights, I would really appreciated it. My C-foo 
> is weak, but the itch is real.
>
>
> The dht11 driver provides for temperature and humidity through a 
> single GPIO pin.
>
> drivers/iio/humidity/dht11.c
>
> The .dts file is at:
>
> ./arch/arm/boot/dts/overlays/dht11-overlay.dts
>

The overlay referenced above is obviously not present in the upstream 
kernel. I was working on the Raspberry Pi kernel repo. Managed to 
butcher it to do what I want.

Patch attached for whoever finds themselves in the same position. Also 
posted to relevant RPi forum here:

https://forums.raspberrypi.com/viewtopic.php?t=335329


Dag N


--------------h6inEjmw57GvtM59OkVAv1sZ
Content-Type: text/x-patch; charset=UTF-8; name="dht11.iio-hwmon.patch"
Content-Disposition: attachment; filename="dht11.iio-hwmon.patch"
Content-Transfer-Encoding: base64

RnJvbSAxOGJhZjM0NGY2MWFiZTMyMTU0ZmU3NmE5NTQ4YzM4MTgwNGZmZjNkIE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBEYWcgQmFra2UgPGRhZ0BiYWtrZS5jb20+CkRhdGU6
IE1vbiwgMzAgTWF5IDIwMjIgMTE6NTc6MDYgKzAyMDAKU3ViamVjdDogW1BBVENIXSBBZGQg
Y29kZSB0byBtYWtlIHNlbnNvciByZWFkYWJsZSB2aWEgdGhlIElJTyBod21vbiBicmlkZ2Uu
CgpTaWduZWQtb2ZmLWJ5OiBEYWcgQmFra2UgPGRhZ0BiYWtrZS5jb20+Ci0tLQogYXJjaC9h
cm0vYm9vdC9kdHMvb3ZlcmxheXMvZGh0MTEtb3ZlcmxheS5kdHMgfCA3ICsrKysrKysKIDEg
ZmlsZSBjaGFuZ2VkLCA3IGluc2VydGlvbnMoKykKCmRpZmYgLS1naXQgYS9hcmNoL2FybS9i
b290L2R0cy9vdmVybGF5cy9kaHQxMS1vdmVybGF5LmR0cyBiL2FyY2gvYXJtL2Jvb3QvZHRz
L292ZXJsYXlzL2RodDExLW92ZXJsYXkuZHRzCmluZGV4IDZmZWVlYjQwMjQ5My4uMzM2M2Uz
MDc1Zjc1IDEwMDY0NAotLS0gYS9hcmNoL2FybS9ib290L2R0cy9vdmVybGF5cy9kaHQxMS1v
dmVybGF5LmR0cworKysgYi9hcmNoL2FybS9ib290L2R0cy9vdmVybGF5cy9kaHQxMS1vdmVy
bGF5LmR0cwpAQCAtMTcsNyArMTcsMTQgQEAgZGh0MTE6IGRodDExQDAgewogCQkJCXBpbmN0
cmwtMCA9IDwmZGh0MTFfcGlucz47CiAJCQkJZ3Bpb3MgPSA8JmdwaW8gNCAwPjsKIAkJCQlz
dGF0dXMgPSAib2theSI7CisJCQkJI2lvLWNoYW5uZWwtY2VsbHMgPSA8MT47CiAJCQl9Owor
CQkJaWlvLWh3bW9uIHsKKwkJCQljb21wYXRpYmxlID0gImlpby1od21vbiI7CisJCQkJc3Rh
dHVzID0gIm9rYXkiOworCQkJCWlvLWNoYW5uZWxzID0gPCZkaHQxMSAwPiwgPCZkaHQxMSAx
PjsKKwkJCX07CisKIAkJfTsKIAl9OwogCi0tIAoyLjM1LjEKCg==

--------------h6inEjmw57GvtM59OkVAv1sZ--

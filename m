From: Gergely Imreh <imrehg@gmail.com>
Date: Sat, 06 Jun 2015 15:28:21 +0000
Subject: Re: [lm-sensors] Parallella board temperature sensing
Message-Id: <CAJ3iQcr2Jke_WSR_GzJ5Xr6gRRykDXmrsfzmZMbuBpoc=wCibA@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <CAJ3iQcr8cSEB_vYYR2_0H-Am0wYstQvtfzHJcVgMsdcWzFn=VA@mail.gmail.com>
In-Reply-To: <CAJ3iQcr8cSEB_vYYR2_0H-Am0wYstQvtfzHJcVgMsdcWzFn=VA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 6 June 2015 at 23:05, Guenter Roeck <linux@roeck-us.net> wrote:
> On 06/06/2015 08:01 AM, Guenter Roeck wrote:
>>
>> On 06/06/2015 07:51 AM, Gergely Imreh wrote:
>>>
>>> Hi,
>>>
>>> I was checking out what would it take to support lm-sensors on the
>>> Parallella board[1]. It's an interesting little board with a dual core
>>> Xilinx ARM Cortex-A9, an FPGA, and a 16-core Epiphany co-processor.
>>> It's Xilinx XADC sensor used for temperature/voltage sensing does not
>>> seem to be anywhere on the lm-sensors supported device list. Currently
>>> users seem to monitor it through reading the device data directly from
>>> the /sys entries and doing the necessary scaling and conversion (as it
>>> was discussed on the Parallella forums, bash script included[2])
>>>
>>> In a nutshell, the data is accessible through
>>> /sys/bus/iio/devices/iio:device0/in_temp0_{raw,offset,scale} files.
>>> There are also 8 voltage readings there that could be extracted.
>>>
>>
>> If it is supported through iio, it should be possible use the iio->hwmon
>> bridge.
>>
>
> Here is an example devicetree entry, used to configure a max1139 as
> hwmon device.
>
>                 max1139: voltage-sensor@35 {
>                         compatible = "maxim,max1139";
>                         reg = <0x35>;
>                         vcc-supply = <&reg_3p3v>;
>                         vref-supply = <&reg_3p3v>;
>                         #io-channel-cells = <1>;
>                 };
>
> ...
>
>         max1139@35 {
>                 compatible = "iio-hwmon";
>
>                 io-channels = <&max1139 0>, <&max1139 1>, <&max1139 2>,
>                         <&max1139 3>, <&max1139 4>, <&max1139 5>,
>                         <&max1139 6>, <&max1139 7>, <&max1139 8>,
>                         <&max1139 9>, <&max1139 10>, <&max1139 11>;
>         };
>
> Guenter
>

So if I get it right, all the support can be enabled through iio-hwmon
by modifying the Parallella device tree?

If so, the relevant entry is I think this (from the repo[1])

xadc@f8007100 {
    compatible = "xlnx,zynq-xadc-1.00.a", "xlnx,ps7-xadc-1.00.a";
    reg = <0xf8007100 0x20>;
    interrupts = <0 7 4>;
    interrupt-parent = <&gic>;
    clocks = <&clkc 12>;
};

I guess in the above example "voltage-sensor" is just a descriptive
label, can be anything else too, right?

Looking at the iio-hwmon binding docs[2], would a version like this be usable?

adc: xadc@f8007100 {
    compatible = "xlnx,zynq-xadc-1.00.a", "xlnx,ps7-xadc-1.00.a";
    reg = <0xf8007100 0x20>;
    interrupts = <0 7 4>;
    interrupt-parent = <&gic>;
    clocks = <&clkc 12>;
    #io-channel-cells = <1>;
};

iio_hwmon {
    compatible = "iio-hwmon";
    io-channels = <&adc 0>, <&adc 1>, <&adc 2>,
                         <&adc 3>, <&adc 4>, <&adc 5>,
                         <&adc 6>, <&adc 7>, <&adc 8>,
                         <&adc 9>; <&adc 10>; <&adc 11>;
                         <&adc 12>; <&adc 13>; <&adc 14>;
                         <&adc 15>; <&adc 16>; <&adc 17>;
                         <&adc 18>;
};

How would this be able to tell which adc channels belong to what? (eg.
0-1-2 are needed for the temperature sensing, the rest are voltage
sensors in pairs, raw and scale values)

Cheers,
Greg

[1]: https://github.com/parallella/parallella-linux/blob/7a0dc647b9b1c0010ff83fc117e29b408d5693bb/arch/arm/boot/dts/zynq-parallella1.dtsi#L236-L242
[2]: http://lxr.free-electrons.com/source/Documentation/devicetree/bindings/iio/iio-bindings.txt

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

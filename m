From: Dag Wieers <dag@wieers.com>
Date: Wed, 06 Feb 2013 12:12:54 +0000
Subject: Re: [lm-sensors] i2c-i801 on AppleTV (1st gen)
Message-Id: <alpine.LRH.2.02.1302061308320.2736@pikachu.3ti.be>
List-Id: <lm-sensors.vger.kernel.org>
References: <alpine.LRH.2.02.1302050844220.2736@pikachu.3ti.be>
In-Reply-To: <alpine.LRH.2.02.1302050844220.2736@pikachu.3ti.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, 6 Feb 2013, Jean Delvare wrote:

> The risk is relatively low, but it exists. If you want to make it as
> low as possible, you can start with:
>
> # i2cget 0 0x48
>
> This will read the presumed internal pointer value from the chip. Write
> down the value for future use. I'll call in $v below. Then try a single
> register read:
>
> # i2cget 0 0x48 $v
>
> If it returns $v again, and $v is neither 0x00 nor 0xff, you better
> leave the chip alone, and cold boot the machine (just in case.) In
> other cases, the chip seem to behave normally and you can go with:
>
> # i2cdump 0 0x48 b

So here we go:

root ~ # i2cget 0 0x48
WARNING! This program can confuse your I2C bus, cause data loss and worse!
I will read from device file /dev/i2c-0, chip address 0x48, current data
address, using read byte.
Continue? [Y/n]
0x3f

root ~ # i2cget 0 0x48 0x3f
WARNING! This program can confuse your I2C bus, cause data loss and worse!
I will read from device file /dev/i2c-0, chip address 0x48, data address
0x3f, using read byte data.
Continue? [Y/n]
Error: Read failed

root ~ # i2cget 0 0x48 b
Error: Data address invalid!
Usage: i2cget [-f] [-y] I2CBUS CHIP-ADDRESS [DATA-ADDRESS [MODE]]
   I2CBUS is an integer or an I2C bus name
   ADDRESS is an integer (0x03 - 0x77)
   MODE is one of:
     b (read byte data, default)
     w (read word data)
     c (write byte/read byte)
     Append p for SMBus PEC


>> PS I now added dmidecode to the OpenELEC build system in order to find
>> other differences between both devices.
>
> Good idea.

No important differences. The systems also runs the same kernel/ramdisk, 
so I guess some nvram or bios setting is different, or it's the hardware. 
Weird.

----
[dag@lisse ~]$ diff -u <(ssh root@xbmc01 dmidecode) <(ssh root@xbmc02 dmidecode)
--- /dev/fd/63  2013-02-06 13:10:19.476163195 +0100
+++ /dev/fd/62  2013-02-06 13:10:19.477163195 +0100
@@ -180,7 +180,7 @@
         Manufacturer: Apple Inc.
         Product Name: AppleTV1,1
         Version: 1.0
-       Serial Number: YM91505WXVG
+       Serial Number: YM809009YST
         UUID: 9CFE245E-D0C8-BD45-A79F-54EA5FBD3D97
         Wake-up Type: Power Switch
         SKU Number: System SKU #
@@ -207,7 +207,7 @@
         Type: Space-saving
         Lock: Not Present
         Version: Mac-F4228DC8
-       Serial Number: YM91505WXVG
+       Serial Number: YM809009YST
         Asset Tag: Asset Tag#
         Boot-up State: Safe
         Power Supply State: Safe
----


-- 
-- dag wieers, dag@wieers.com, http://dag.wieers.com/
-- dagit linux solutions, info@dagit.net, http://dagit.net/

[Any errors in spelling, tact or fact are transmission errors]

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

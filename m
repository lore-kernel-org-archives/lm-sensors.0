From: mds4@verizon.net (Mark Studebaker)
Date: Thu, 19 May 2005 06:25:35 +0000
Subject: new bus driver
Message-Id: <41FF79B7.3050205@verizon.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <Pine.LNX.4.61.0501251912150.26717@zebra.tky.hut.fi>
In-Reply-To: <Pine.LNX.4.61.0501251912150.26717@zebra.tky.hut.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

The schematic linked below looks sane to me but I would recommend using
a 3.3V equivalent to the MAX232. For example MAX3222E.

Most parts these days use 3.3V supplies so you can power both
the 232 driver and the i2c chip with the same supply.

If you do use the 5V version of the circuit, be sure the i2c chips you plan to talk to are 5V tolerant.
Should be, since the i2c pins are open drain, but check the
datasheet to be sure.

Also, the SDA and SCL pullups are a little weak at 10K.
I would reduce to 3-5K, esp. with a 3.3V VCC.

mds



Mark M. Hoffman wrote:
> Hi Jaakko:
> 
> 
>>Jaakko Ala-Paavola wrote:
>>
>>>Hi, 
>>>I'm planning to implement a bus driver for a simple homebrew 
>>>serial port I2C-adapter:
>>>
>>>http://vodka.tky.hut.fi/~jap/Electronics/I2C/SerialAdapter/index.html
>>>
>>>The original design is mine, but I just got confirmation from a hacker in 
>>>Italy that the device actually does work. Unfortunately the guy wrote 
>>>the driver for Windows only. Thus I decided to implement one for linux.
>>>
>>>I checked the list of supported bus drivers and didn't found anything 
>>>related to serial port. Do you feel that kind of project usefull?
> 
> 
> * Aur?lien Jarno <aurelien@aurel32.net> [2005-01-25 19:11:01 +0100]:
> 
>>I think it could be useful, at least I think I will build my own one. I 
>>already have the same kind of hardware, but for parallel port. And it is 
>>supported by lm-sensors!
>>(...)
> 
> 
> Seconded.  I will probably build one also.
> 
> Regards,
> 

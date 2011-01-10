From: Stan Hoeppner <stan@hardwarefreak.com>
Date: Mon, 10 Jan 2011 16:48:02 +0000
Subject: Re: [lm-sensors] aftermarket PCI or ISA monitoring board?
Message-Id: <4D2B3842.3080801@hardwarefreak.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <4D28AA8D.7080902@hardwarefreak.com>
In-Reply-To: <4D28AA8D.7080902@hardwarefreak.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean Delvare put forth on 1/10/2011 2:28 AM:
> On Sun, 9 Jan 2011 17:35:13 -0800, Guenter Roeck wrote:
>> On Sun, Jan 09, 2011 at 07:10:53PM -0500, Stan Hoeppner wrote:
>>> Jean Delvare put forth on 1/9/2011 4:11 PM:
>>>
>>>> If soldering things is an option, then many recent boards have an SMBus
>>>> header, so it would be possible to choose any supported SMBus-based
>>>> hardware monitoring device and wire up everything manually.
>>>
>> Good point ...
>>
>>> The board in question is 10+ years old, but it does have a 5 pin SMBus header.
>>> The board is the legendary Abit BP6.  Unfortunately the manual doesn't provide
>>> the pin assignments for this SMBus connector, though it does for all the other
>>> connectors.  Strange.
>>>
>> Of the five pins, one will be Ground, one will be VCC. There may be another ground
>> or possibly alert, plus I2C data and clock.
>>
>> Should be easy to figure out Ground and VCC. That leaves three additional pins
>> to play with, so it should be possible to find out what is what by trying.
>>
>>> Could you suggest a few inexpensive models of such lm-sensors compatible SMBus
>>> based hardware monitoring devices containing, say, 1-3 thermal sensing circuits
>>> (with probes/lead wires), and maybe a few non-PWM fan RPM sensing/driving circuits?
>>>
>> max6696 supports three sensors (one internal, two external). Besides the sensors,
>> all I needed to wire the chip was one capacitor and one resistor, plus another
>> capacitor for each of the external sensors. The datasheet has a nice sample picture.
>> You might need additional resistors to set the chip's i2c address if you want to support
>> more than one chip, plus a zener diode and another resistor to generate 3.3V if the board 
>> only provides 5V.
>>
>> Tricky part is that the chip is in uMAX or QSOP package with .5mm or .635mm pitch,
>> so you'll need a good soldering iron and a calm hand to do the soldering, or find
>> some HW guy to do it for you.
>>
>> Of course, you could simply buy MAX6695EVKIT. I don't know the price, but usually 
>> Maxim's evaluation board pricing is quite reasonable.
> 
> Other solutions include the Texas Instruments TMP421 (3 external
> thermal sensors), National Semiconductor LM63 (1 external thermal
> sensor + 1 fan monitoring input), all LM85-compatible chips (2 external
> thermal sensors + 4 fan monitoring inputs, SMSC EMC2103 (3 external
> thermal sensors + 1 fan monitoring input) and Analog Devices ADM1031 (2
> external thermal sensors + 2 fan monitoring inputs.)
> 
> You can put more than one of each on the same SMBus segment.
> 
>>> Also, will lm-sensors and the sensors user space program work with two
>>> monitoring chips simultaneously?
> 
> Yes, definitely. I'm doing that all the time.
> 
>>> Does anyone know if phpsysinfo will, or can
>>> with additional tweaking, display data from both devices?
> 
> As far as I know, phpsysinfo merely parses the output of "sensors", so
> there is no reason why it wouldn't work.

Thank you all for the suggestions.  I'm out of my element here, as I don't
participate in this sector of the computer/electronics marketplace.  Is there an
online retailer or wholesaler where I can actually add one of these devices to a
cart, and check out?  Or at least see descriptions and pricing info without
having to speak to a sales rep, lying to him or her, just to minimize my price
on what is really a one time purchase?  Do any of them in the U.S. regularly
sell in single quantities, with little or no salesperson hassles?

Back when I was building custom white box servers and storage systems, I had to
spend way too much time "servicing my vendor relationships".  A bit oxymoronic
that phrase, given that I was the customer...

Thanks.

-- 
Stan

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

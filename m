From: mds@paradyne.com (Mark D. Studebaker )
Date: Thu, 19 May 2005 06:23:50 +0000
Subject: ADM1026 support in LM_SENSORS
Message-Id: <3E792B34.302@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org



Philip Pokorny wrote:
> Hmmm...
> 
> I might be able to get by with only block read/write functionality.
> 
> I'll take another look at the code and the generic xfer function.
> 
> It looked like current implementation had the idea of a transaction that 
> would send an address and then transfer a variable number of bytes.  You 
> could then create a list of transfers to effect a write, read, byte or 
> word transfers.
> 

Well, at the i2c and the smbus "emulation layer" (i2c_smbus_[read/write/block]_xxx() functions),
address is assumed to be one byte.
This chart
http://www2.lm-sensors.nu/~lm78/protocol.html
will probably help you with understanding these layers.

On an i2c adapter you can of course use the low-level i2c_transfer() function.
For an smbus adapter you are probably out of luck anyway,
the hardware for most won't support it, even if you
added the emulation layer and support in the driver.

Hopefully this makes sense. If not let me know.

mds


> Not sure what happens when the theory hits the road of actual bus chip 
> implementations.
> 
> I guess I'll read the TODO again and dig into the xfer stuff some more.
> 
> :v)
> 
> Mark Studebaker wrote:
> 
>> no support now (although writes will work with a hack). There are 
>> large i2c eeproms out there now, they aren't supported.
>> See TODO in the i2c package (heading "16 bit register addresses") for 
>> details.
>>
>> Philip Pokorny wrote:
>>
>>> I do have one question...
>>>
>>> This ADM1026 has 8k of EEPROM memory on it.  But to access it, you need
>>> to send a 16-bit address (two bytes).  The EEPROM is mapped at 0x8000 to
>>> 0x9fff.  There aren't any device registers above 0x60 so they implement
>>> these 16-bit addresses as a write of the low 8-bits of address to the
>>> "register" at the high 8-bits.  Then you can read or write a byte or
>>> block (32 bytes).
>>>
>>> An example might be clearer...
>>>
>>> If you want to write 0x36 to address 0x8122, then you would execute the
>>> following i2c transfers:
>>>
>>>    Chip address (write), 0x81, 0x22, 0x36
>>>
>>> If you want to read from address 0x8234, then you would execute:
>>>
>>>    Chip address (write), 0x82, 0x34, Chip address (read), <read value>
>>>
>>> I looked at the i2c core code and it isn't clear to me if or how I could
>>> implement these 16-bit address reads and writes.  Writes could be done
>>> with a word write, but I don't see how I could implement a read.
>>>
>>> Any ideas?
>>>
>>> :v)
>>>
>>> Mark D. Studebaker wrote:
>>>
>>>> Philip,
>>>> glad to hear you are going to tackle it.
>>>> let me know if you need help.
>>>> mds
>>>>
>>>>
>>>> Philip Pokorny wrote:
>>>>
>>>>
>>>>> OK then, I'll get started.
>>>>>
>>>>> This board has a simple automatic fan speed control feature as well,
>>>>> so it will give me an opportunity to see how the LM85/ADM1027 design
>>>>> works with this chip.
>>>>>
>>>>> :v)
>>>>>
>>>>> Vojtech Pavlik wrote:
>>>>>
>>>>>
>>>>>> On Wed, Mar 12, 2003 at 07:41:48PM -0800, Philip Pokorny wrote:
>>>>>>
>>>>>>
>>>>>>> Hello again...
>>>>>>>
>>>>>>> It seems I will soon be needing ADM1026 support in LM_SENSORS.  I
>>>>>>> see in the archives that Vojtech Pavlik has mentioned he would write
>>>>>>> a driver.
>>>>>>>
>>>>>>> Any progress there?
>>>>>>>
>>>>>>> This chip is a beast!  It's got more sensors and *stuff* than
>>>>>>> anything else out there...  (Looks like fun...)
>>>>>>>
>>>>>>> I'll write a driver if Vojtech hasn't got one yet...
>>>>>>
>>>>>>
>>>>>>
>>>>>>
>>>>>>
>>>>>> I don't, and I'm not going to write it very soon, because the board I
>>>>>> needed the support for actually was produced without the chip. Later
>>>>>> revisions might have it, though. So I'm waiting now.
>>>>>>
>>>>>
>>>>>
>>>>>
>>> -- 
>>> Philip Pokorny, Senior Engineer
>>> Tel: 415-358-2635   Fax: 415-358-2646   Toll Free: 888-PENGUIN
>>> PENGUIN COMPUTING, INC.
>>> www.penguincomputing.com
>>
>>
> 
> 
> 

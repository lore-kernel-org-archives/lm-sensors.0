From: Tobias Preclik <tobias@preclik.de>
Date: Tue, 20 Jul 2010 21:26:04 +0000
Subject: Re: [lm-sensors] W83667HG-B testing
Message-Id: <4C46146C.6010004@preclik.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <4C42ED6C.9030903@preclik.de>
In-Reply-To: <4C42ED6C.9030903@preclik.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: lm-sensors@vger.kernel.org

On 07/20/2010 10:58 PM, Guenter Roeck wrote:
> On Tue, 2010-07-20 at 16:51 -0400, Jean Delvare wrote:
>> On Tue, 20 Jul 2010 13:41:42 -0700, Guenter Roeck wrote:
>>> On Tue, 2010-07-20 at 02:54 -0400, Jean Delvare wrote:
>>>> On Mon, 19 Jul 2010 18:24:16 -0700, Guenter Roeck wrote:
>>>>> On Sun, Jul 18, 2010 at 08:02:52AM -0400, Tobias Preclik wrote:
>>>>>> Hi,
>>>>>>
>>>>>> my Zotac board H55-ITX features the W83667HG-B chip. I downloaded and
>>>>>> compiled the standalone kernel module today. Here's the sensors output:
>>>>>>
>>>>>> The module loads fine:
>>>>>>
>>>>>> # modprobe w83627ehf
>>>>>> # tail -n 1 /var/log/messages
>>>>>> Jul 18 13:42:58 leela kernel: [50378.028634] w83627ehf: Found W83667HG-B
>>>>>> chip at 0xa10
>>>>>> # sensors
>>>>>> w83667hg-isa-0a10
>>>>>> Adapter: ISA adapter
>>>>>> in0:         +0.98 V  (min =  +0.00 V, max =  +1.74 V)  
>>>>>> in1:         +1.11 V  (min =  +0.10 V, max =  +0.20 V)   ALARM
>>>>>> in2:         +3.36 V  (min =  +3.95 V, max =  +3.28 V)   ALARM
>>>>>> in3:         +3.36 V  (min =  +1.57 V, max =  +2.10 V)   ALARM
>>>>>> in4:         +1.10 V  (min =  +1.74 V, max =  +1.87 V)   ALARM
>>>>>> in5:         +1.18 V  (min =  +1.02 V, max =  +1.30 V)  
>>>>>> in7:         +3.28 V  (min =  +3.23 V, max =  +2.62 V)   ALARM
>>>>>> in8:         +3.34 V  (min =  +3.18 V, max =  +0.05 V)   ALARM
>>>>>> fan1:          0 RPM  (min = 3515 RPM, div = 128)  ALARM
>>>>>> fan2:       1022 RPM  (min = 1638 RPM, div = 8)  ALARM
>>>>>> fan3:          0 RPM  (min =  958 RPM, div = 128)  ALARM
>>>>>> fan4:          0 RPM  (min = 10546 RPM, div = 128)  ALARM
>>>>>> fan5:          0 RPM  (min = 3515 RPM, div = 128)  ALARM
>>>>>> temp1:       +30.0°C  (high = -56.0°C, hyst = -17.0°C)  ALARM  sensor >>>>>> thermistor
>>>>>> temp2:       +41.5°C  (high = +80.0°C, hyst = +75.0°C)  sensor = thermistor
>>>>>> temp3:        -3.0°C  (high = +80.0°C, hyst = +75.0°C)  sensor = thermistor
>>>>>> cpu0_vid:   +0.000 V
>>>>>>
>>>>> Actual values look mostly good, but the limits are really off.
>>>>> Difficult to say, though, if those are wrong readings or just badly configured.
>>>>>
>>>>> Jean, any idea/thoughts ?
>>>>
>>>> Only a register dump would say from sure. But given that the alarm
>>>> flags all match out-of-limit readings, I would be inclined to say these
>>>> are only misonconfigured limits. Tobias could set proper limits and
>>>> check that all the alarms go away.
>>>>
>>>> The only inconsistency is with temp3... the reading is out of limit but
>>>> there is no alarm flag. You may want to double check the datasheet to
>>>> ensure that the driver reads both the temp3 value and its alarm flag
>>>> from the right register/bit.
>>>>
>>> I checked the specification. Registers are the same for both chips,
>>> unless I am missing something. No idea what is going on.
>>
>> I seem to remember that on some of these chips, in6 and temp3 are
>> mutually exclusive? So you may have to check all the configuration
>> registers which determine which of in6 or temp3 is enabled. Maybe in6
>> is enabled and the driver wrongfully think temp3 is instead?
>>
> Yes, I thought about that too.
> 
>> Just a random idea, I may be completely off the track.
>>
> The detection code seems to be fine - at least I didn't find a problem
> with it. Unless, of course, the bit value to enable aux temp monitoring
> was reversed in rev B, but the manual doesn't reflect that.
> 
> Guess I _must_ be missing something, but right now I have no idea what
> it might be.
> 
> One thought - Tobias, can you provide sensor output from your BIOS for
> comparison ?

These are all PC Health informations I could find in the BIOS:

CPU Temp = 49°C
CPUFAN = 1692 RPM
Vcore = 1.232V
3VCC = 3.360V
VTT 1.1V = 1.120V
PCH Voltage = 1.096V
IGD Voltage = toggles between 1.176V and 1.184V
VSB = 3.280V
VBAT = 3.344V

The voltages are rather hard to match aren't they?

Hope this helps.

Regards,
Tobias
PS: I cannot answer my mails until Sunday.

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

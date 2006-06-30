From: grimm@nickellson.com (Nick Ellson)
Date: Fri, 30 Jun 2006 12:29:05 +0000
Subject: [lm-sensors] Support for Intel 82801GR (ICH7 Family)
Message-Id: <Pine.LNX.4.64.0606300525300.11334@gubbie.home>
List-Id: <lm-sensors.vger.kernel.org>
References: <44A125CA.3000603@correiolivre.serpro.gov.br>
In-Reply-To: <44A125CA.3000603@correiolivre.serpro.gov.br>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org



Andre,

The SE7525GP2 Intel Server Board is also an ICH7, I wonder if they used 
the same mBMG chip for monitoring the system board as mine. The dump of 
sensor detect looks pretty much the same.

I have some leads I am following on how I can get lm-sensors to use ipmi 
to read at least the CPU voltages/temp. The guy who had success did not 
get fan speed for some reason.

If I have any success it will be posted here...

Nick


-- 
Nick Ellson
CCDA, CCNP, CCSP, CCAI,
MCSE 2000, Security+, Network+
Network Hobbyist, VFR Private Pilot.


On Fri, 30 Jun 2006, andre.dantas-vieira at serpro.gov.br wrote:

> My motherboard is a Intel? Desktop Board D945GCZ
> <http://www.intel.com/products/motherboard/d945gcz/index.htm> . And i
> also re-tryed with the latest sensor-detect and didn't work.
>
> Thanks for all,
> Andre.
>
> Rudolf Marek escreveu:
>
>> Mathew Tebbens wrote:
>>
>>
>>> I'm also running the same chipset
>>> lm_sensors is not working for me also.
>>>
>>>
>>
>> Hmm strange.
>>
>>
>>
>>> Next adapter: SMBus I801 adapter at ece0
>>> Do you want to scan it? (YES/no/selectively): YES
>>> Client found at address 0x08
>>> Client found at address 0x30
>>> Client found at address 0x31
>>> Client found at address 0x32
>>> Client found at address 0x33
>>> Client found at address 0x44
>>> Probing for `Maxim MAX6633/MAX6634/MAX6635'... Failed!
>>> Client found at address 0x50
>>> Probing for `SPD EEPROM'... Success!
>>>    (confidence 8, driver `eeprom')
>>> Probing for `DDC monitor'... Failed!
>>> Probing for `Maxim MAX6900'... Failed!
>>> Client found at address 0x51
>>> Probing for `SPD EEPROM'... Success!
>>>    (confidence 8, driver `eeprom')
>>> Client found at address 0x52
>>> Probing for `SPD EEPROM'... Success!
>>>    (confidence 8, driver `eeprom')
>>> Client found at address 0x53
>>> Probing for `SPD EEPROM'... Success!
>>>    (confidence 8, driver `eeprom')
>>> Client found at address 0x69
>>>
>>>
>>
>> This means that the bus is working. But there are no interresting devices on the
>> bus.
>>
>>
>> Andre and Mathew, what model/brand is your motherboard?
>>
>> Can you re-try with the latest sensors-detect?
>>
>> http://www.lm-sensors.org/browser/lm-sensors/trunk/prog/detect/sensors-detect?format=txt
>>
>> Save this file, and change the file permissions to exect or run as:
>>
>> perl ./sensors-detect
>>
>> Regards
>> Rudolf
>>
>>
>>
>>
>>
>
> _______________________________________________
> lm-sensors mailing list
> lm-sensors at lm-sensors.org
> http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
>

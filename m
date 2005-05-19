From: phil@edgedesign.us (Philip Edelbrock)
Date: Thu, 19 May 2005 06:24:17 +0000
Subject: Are sensors for redundant PSU's?
Message-Id: <3F6646E5.7000904@edgedesign.us>
List-Id: <lm-sensors.vger.kernel.org>
References: <3F6628EC.7060203@pocock.com.au>
In-Reply-To: <3F6628EC.7060203@pocock.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


 From my knowledge, some PSU's have a seperate dangling sensor cable 
which plugs into the mobo.  I think I've got a psu here with such a 
connector, although it isn't plugged into the board.  I don't think the 
standard block connector has such connection options in it for sensors 
in the PSU.

So either a PSU needs the extra connector which connects to a SMBus 
connector on the mobo (as you mention) or an extra connection which 
connects directly to the sensors (which then would need to be interfaced 
with a sensor chip on the mobo).

I did a quick search and found some psu's with fan control and temp sensor:

http://www.enermax.com.tw/

The manual seems to make it look like you plug a connector onto an extra 
fan port on the mobo to sense the fan speed.  It is less obvious if the 
temp sensor can be read remotely (it seems to control the psu fan when 
the sensor is installed).


Phil

Daniel Pocock wrote:

> Hi Phil,
>
> Thanks for the quick email reply!
>
> Do the PSU's send any sort of signalling (eg fan speed) through the 
> fat, colored power cables?  I understand that lm-sensors relies on IO 
> chips on the motherboard, so does that mean the motherboard has to 
> have some ability to read information from the PSU as well?
>
> I've looked at pin-outs for several PSU's and can not see any signal 
> that would suggest fan speed reporting, so would a PSU need to provide 
> a separate cable to attach to the SMBus header on the motherboard in 
> order to read fan speed or other fault conditions?
>
> My initial reading of your FAQ suggests that lm-sensors can only 
> monitor fans that are connected to the fan-power headers on the 
> motherboard (and having a 3 wire cable too).  Almost all PSU fans seem 
> to get their power from within the PSU though - so it doesn't make 
> sense to me why my BIOS and lm-sensors suggest they can offer PSU fan 
> speed information if there is no way for such information to be 
> relayed from the PSU to the motherboard.
>
> Regards,
>
> Daniel
>
> Philip Edelbrock wrote:
>
>>
>> Short answer: no
>>
>> Long answer: It depends on the hardware.  In general, there aren't 
>> sensors in PSU's which we can access, but there are some power 
>> supplies which have fan-speed monitors and/or temp sensors which we 
>> can potentially read.  I'm not aware of any PSU fault sensor which is 
>> supported by an open-source project, but that doesn't mean that it 
>> doesn't exist.  It may be the kind of thing which only can be 
>> accessed through a bios interface.
>>
>> If I were you, I'd get some technical details on how the fault 
>> detection on some rack-mount servers works.  If you are lucky, they 
>> may actually disclose enough details to write a driver, or have some 
>> sort of driver already available.
>>
>>
>> Phil
>>
>> Daniel Pocock wrote:
>>
>>>
>>> I am about to buy a rack server with redundant PSU's.
>>>
>>> Will lm-sensors tell me if one of the PSU's fails?  Or should I be 
>>> looking at other software to monitor PSU failure?
>>>
>>> Alternatively, if such support isn't featured in lm-sensors, is this 
>>> something I could code myself?
>>>
>>> Regards,
>>>
>>> Daniel
>>>
>

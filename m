From: Ilia.Stolov@nsc.com (Ilia Stolov)
Date: Thu, 19 May 2005 06:25:29 +0000
Subject: PC87431 is not - need full datasheet.
Message-Id: <OF748C5F22.E0648796-ONC2256F81.00260AAE-C2256F81.00271277@nsc.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <41D5D72B.2040706@ocesb.com.my>
In-Reply-To: <41D5D72B.2040706@ocesb.com.my>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

The Host interface of PC87431 is IPMI 1.5/2.0 SSIF - the new host
interface introduced in IPMI 2.0 spec. And as specified in the spec
the SSIF interface can be used for IPMI 1.5 and 2.0 BMCs.

Any SMBus driver should work. The SSIF is implemented on top of SMBus.

The SSIF message format:

Request:  <Slave address+W> <SMBus command = 02> <Length> <NetFn+LUN>
          <IPMI command> <IPMI command data ...>
Response: <Slave address+W> <SMBus command = 03> <Slave address+R>
          <Length> <NetFn+LUN> <IPMI command> <Complt Code> <Data ....>

Regards,
Ilia Stolov
National Semiconductor Corporation



                                                                                                                                   
                      "Corey Minyard"                                                                                              
                      <cminyard@mvista.        To:       "Mark Studebaker" <mds4@verizon.net>                                      
                      com>                     cc:       "Ilia Stolov" <Ilia.Stolov@nsc.com>, "Corey Minyard"                      
                                                <minyard@mvista.com>, "Chan Min Wai (System Administrator)" <dcmwai@ocesb.com.my>, 
                      06-01-05 05:40 AM         sensors@Stimpy.netroedge.com                                                       
                                               Subject:  Re: PC87431 is not - need full datasheet.                                 
                                                                                                                                   




Mark Studebaker wrote:

> thanks for the info about the datasheet requiring an NDA.
> Unfortunately this means things will be difficult.
> But it may be sufficient just to get KCS over I2C working to it.
>
> The chip uses KCS over I2C.
> Corey, can we do that with the IPMI KCS driver? Do we need to
> write code to register with the KCS module to route KCS messages
> to a particlar address on a particular i2c bus?
> How would we do that - or does IPMI already have that capability?
>
> Once that is done, then the standard modules
> bmcsensors -> i2c-ipmi -> ipmi-msghdlr -> ipmi_kcs_sm
> should work.
>
> right Corey?

Well, I don't think so.  There is no such thing as KCS over I2C.  There
is something called the SMB interface, which is part of the newer IPMI
driver version from openipmi.sf.net.  I really don't know that much
about it, someone else did that work and I don't have any hardware that
supports it.  But if you are running IPMI over I2C, that's probably what
it is.

Oh wait, the line:
  The Host interface of PC87431 is IPMI 1.5/2.0 SSIF (SMBus)
means that it should support the standard interface that the IPMI SMB
driver uses.  IIRC, configuring it is kind of a pain, but it is supposed
to work.

-Corey

>
> mds
>
>
>
>
> Ilia Stolov wrote:
>
>> Mark Studebaker <mds4 <at> verizon.net> writes:
>>
>>
>>> ask National Semiconductor.
>>>
>>> Chan Min Wai (System Administrator) wrote:
>>>
>>>> Hello all,
>>>>
>>>> I'm on Ticket #1853
>>>>
>>>> Is there anyway I can help to obtain a full data sheet?
>>>> What kind of full data sheet do you need?
>>>>
>>>> What should be included?
>>>>
>>>> I would like to help in this, I've contact Intel Support and I think
>>>> they will help in somewhere. So please tell me what do you really want
>>>> and I'll try my best to get that. However I'll have no promise about
>>>> what I can get, but I'll try my very best on this issue.
>>>>
>>>>
>>>>
>>>>> ADM1026 is supported.
>>>>> PC87431 is not - need full datasheet.
>>>>> These are both listed on our new drivers and supported chips pages
>>>>> for your
>>>>> information.
>>>>> If ADM1026 is not found, perhaps the SMBus master is not supported.
>>>>> See FAQ.
>>>>>
>>>>> MDS 12/31/04
>>>>
>>>>
>>>>
>>>> Regards
>>>>
>>>> Chan Min Wai
>>>>
>>>>
>>>
>>
>> Following by recently requests about National's PC87431 mBMC device,
>> please find the following information:
>> 1. The PC87431 is fully IPMI 1.5 compliant device with remote    LAN
>> manageability support
>> 2. The Host interface of PC87431 is IPMI 1.5/2.0 SSIF (SMBus)
>> 3. The PC87431 supports all mandatory commands of IPMI 1.5
>> 4. System configuration and sensor list can be read using regular
>> IPMI    SDR commands
>> 5. Specific sensor data can be obtained using IPMI "Get Sensor
>> Reading"    command
>>
>> More information about PC87431 can be found on:
>> http://www.national.com/pf/PC/PC87431M.html
>>
>> The full PC87431 datasheet can be obtained under NDA.
>>
>> For more information about IPMI specification, please see IPMI
>> developers web-site:
>> http://developer.intel.com/design/servers/ipmi/index.htm
>>
>> Attached are sample sources of SSIF interface implementation for
>> PC87431.
>> Sources provided under BSD license agreement.
>>
>>
>>
>>
>>
>>
>>
>






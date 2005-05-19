From: mds4@verizon.net (Mark Studebaker)
Date: Thu, 19 May 2005 06:25:26 +0000
Subject: RFC: complete rewrite of i2c-i801 for 2.6.x
Message-Id: <41B76B72.9030208@verizon.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <20041128193640.GB5855@jupiter.solarsys.private>
In-Reply-To: <20041128193640.GB5855@jupiter.solarsys.private>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

since I'm in the middle of 801 driver updates already, I'll go ahead and add support to
the driver and sensors-detect in CVS. I'll leave the 2.6 patch to you.
let us know when you have test results.
thanks
mds

Gaston, Jason D wrote:
> Mark,
> 
> I don't think that there are any changes to the ICH7 SMBus Controller,
> other then DID, which is 27DAh.  The Datasheet will not be available
> until the product launches.  I will however, patch the driver with the
> new DID, test it out and then submit the patch here and to the LKML.  My
> plan is to do this within the next six weeks or so.  Unless you can or
> want to add the DID now?
> 
> Let me know if you would still like me to try something out on ICH5,
> ICH6 or ESB6300.
> 
> Thanks,
> 
> Jason Gaston
> 
> 
> 
> -----Original Message-----
> From: Mark Studebaker [mailto:mds4@verizon.net] 
> Sent: Wednesday, December 08, 2004 9:37 AM
> To: Gaston, Jason D
> Cc: LM Sensors
> Subject: Re: RFC: complete rewrite of i2c-i801 for 2.6.x
> 
> thanks for offer. i2c block read support for ich5 and later is now in
> CVS.
> Best way to test bus drivers is with 'i2cdump'.
> In particular to test i2c block reads, best way is with the "i" mode of
> i2cdump.
> If it works, regular byte ("b") mode and "i" mode should have identical
> results
> when reading from an eeprom.
> 
> For the ICH7, first we've heard of it, but not surprised it would be the
> chip
> after ICH6 :)
> I see there's nothing on developer.intel.com about it. Will there be any
> changes in the SMBus controller? What is the device ID? Datasheet
> availability?
> Whether you submit 2.4 or 2.6 patches doesn't really matter.
> But with the device ID, and assurances that the SMBus part of the chip
> didn't change,
> it's real easy.
> 
> mds
> 
> 
> Gaston, Jason D wrote:
> 
>>Mark,
>>
>>I would be willing to do some testing of the i2c-i801 driver on ICH5,
>>ICH6, ESB6300 and ICH7.  I have access to boards/systems, but I am not
>>proficient in i2c testing, other then running "sensors" and seeing the
>>data.  If you know of some instructions for the testing you are
> 
> looking
> 
>>for, I am willing to give it a go.
>>
>>In addition, I will soon want to get support for ICH7 added to the
>>i2c-i801 driver.  Last time, when I wanted to get support for ICH6
>>added, I posted a patch, adding the DID's, to the LKML and Greg KH.
>>This made it into the 2.6 kernel.  Perhaps I should get support added
>>here first and then the base kernel?
>>
>>Let me know how I can help,
>>
>>Jason Gaston
>>Jason.d.gaston@intel.com
>>
>>
>>    
>>
>>-----Original Message-----
>>From: Mark Studebaker [mailto:mds4@verizon.net] 
>>Sent: Tuesday, December 07, 2004 7:02 PM
>>To: Sensors
>>Subject: Re: RFC: complete rewrite of i2c-i801 for 2.6.x
>>
>>
>>
>>Mark M. Hoffman wrote:
>>
>>
>>>Hi Mark:
>>>
>>>(CCs trimmed)
>>>
>>>* Mark D. Studebaker <mds4@verizon.net> [2004-12-07 11:20:54 -0500]:
>>>
>>>
>>>
>>>>My reading of the DB datasheet (in 2002 and now) is that it doesn't
>>
>>support a
>>
>>
>>>>standard i2c block read. The driver functionality bitmask reflects
>>
>>that.
>>
>>
>>>>I fixed the error message (which would only print out if a driver
>>
>>ignored 
>>
>>
>>>>the functionality mask).
>>>
>>>
>>>Interesting.  It looks like that datasheet only shows this:
>>>
>>>	S Addr Wr [A] Comm [A] D0 [A] D1 [A] S (read bytes...)
>>>
>>>I agree that's not like any transaction we support.
>>
>>
>>correct. don't know what they were thinking.
>>
>>
>>
>>>OTOH, the ICH5 [1] datasheet shows this:
>>>
>>>	S Addr Wr [A] D1 [A] S (read bytes...)
>>>
>>>That's exactly the transfer protocol that eeproms need, right?
>>
>>(That's why I
>>
>>
>>>mentioned to Khali by IRC last weekend that I thought it should be
>>
>>possible.)
>>
>>
>>I think it is what eeproms need (you omitted 'Addr' after the second
>>'S').
>>It matches what I wrote in doc/smbus-protocol in i2c
>>(that is, the i2c block functions are defined to take a 'command'
> 
> byte,
> 
>>matching
>> what eeproms need for 'random' reads and writes).
>>
>>Does anybody have a ICH5/6? If so I can add support to the driver for
>>testing.
>>
>>mds
>>
>>
>>
>>
>>>It would be really bizarre if these two chipsets behaved differently
>>
>>in this
>>
>>
>>>respect - I wonder if the datasheets are correct?
>>>
>>>[1] Well I just scanned all the other datasheets... only ICH5, ICH6,
>>
>>and
>>
>>
>>>6300ESB appear to support the standard I2C block read.  Sorry Khali.
>>
>>:)
>>
>>
>>>Regards,
>>>
>>
>>
>>
> 
> 

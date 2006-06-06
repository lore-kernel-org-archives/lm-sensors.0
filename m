From: abraham.manu@gmail.com (Manu Abraham)
Date: Tue, 06 Jun 2006 12:38:14 +0000
Subject: [lm-sensors] [v4l-dvb-maintainer] Re: [PATCH 1/3] i2c: allow
Message-Id: <44857736.8080200@gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <44802319.4050609@gmail.com>
In-Reply-To: <44802319.4050609@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Mark M. Hoffman wrote:
>> When this discussion comes along it reminds me of the PCI - ISA 
>> discussions, why not probe for ISA devices like PCI devices ..
>>     
>
> Yes, I understand that some devices are difficult or impossible to
> detect.  And of course it is better, if you already know what device
> is present, to simply attach to it rather than try to detect it on
> the bus.  Nathan's patch would allow for this.  What is the problem?
>   

For a device that which does not have any identification, when a third 
party does attach the device, even more chances are there that it could 
possibly be wrong. (I mean for devices that do not have any identification)

In such a case, to handle such a case the subsystem can handle this 
difficult case more efficiently, since it can determine what device it 
is through some way or the other (since it is there within the same 
subsystem). This would be harder when such information has to be passed 
on to another subsystem in a generic way.


>>> If so, that's interesting, I guess... do you then disagree with the
>>> *premise* of Nathan's patches?  I mean, "DVB which no longer probes"
>>> is one of its goals after all.
>>>
>>> Actually, Manu: may I ask a favor?  Could you please point out what are
>>> some of the most difficult and/or sticky "problem drivers" regarding
>>> DVB vs. I2C, and perhaps even describe what makes each particular
>>> instance such a pain for you?  I would appreciate it.
>>>
>>>   
>>>       
>> Well Johannes has really clarified the issues in  the other post.
>>     
>
> Let me first say:  if DVB people are content to use i2c_transfer() directly,
> then I'm not interested in forcing anyone otherwise.  Nonetheless, there
> are other people who are interested in moving the I2C subsystem forward.
>
> I repeat: I'm not interested in forcing anyone to change their code!
>   


Cool, no issues. Some discussions made many people think that these 
changes were being forced down.


> No.  DVB would be passing I2C subsystem specifics to the I2C subsystem.
> That makes perfect sense to me.  PCI is able to self-discover and doesn't
> need any help.  I2C core needs help to do that.  So what?  We do what we
> have to do.  Especially with bus muxes, I don't see why you would want
> every I2C-using subsystem to have to solve that problem separately.
>
>   

Because that wouldn't be part of I2C at all, but a part of the device 
itself, which requires a separate command to the device.


Manu



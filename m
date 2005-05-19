From: mds4@verizon.net (Mark Studebaker)
Date: Thu, 19 May 2005 06:24:48 +0000
Subject: One chip, two uses, two drivers [was: [RFC][2.6] Additional i2c
Message-Id: <405AF914.3000608@verizon.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <EFEF4C473088B847B64CD953D2A6A10401B8F0AC@sdso14a.par.siemens.fr>
In-Reply-To: <EFEF4C473088B847B64CD953D2A6A10401B8F0AC@sdso14a.par.siemens.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I've modified i2c-viapro and via686a so that the via686a driver will register the
i2c bus driver as well, so that i2c-viapro is not required if via686a is loaded.
The problem is making it pretty and making it work for all combinations
of built-in or module.
This works around the PCI conflict of via686a and viapro.

This doesn't apply to vt1211 because it isn't a PCI module.
So I agree there isn't any conflict.
Agreed there's no reason to combine vt1211 and viapro.

BARRE Francois wrote:
> Well, it was off-topic, let's make it another topic ;-p
> 
> In fact no, i2c-viapro and vt1211 are not in conflict. As far as I
> understand it, vt1211 (I mean the lm_sensors module which deals with the i2c
> bus dedicated to temps, fans, etc. on the via nehemiah) is connected to the
> (fake ?) isa bus, whereas the i2c-viapro and via-ircc are both connected to
> a pci bus. 
> 
> I don't think it would be aethetic (and even possible) to integrate both
> fonctionnalities in the same driver, and I don't know yet how to make two
> drivers share the same device, but I guess that's the way to do it. Or maybe
> to push "shared" code in a kind of (fake) bus driver and specific code in a
> chip. If Mark has some idea/any kind of experience dealing with it, I shall
> be interrested. I didn't manage to find any example implemented in the
> kernel yet.
> 
> Anyway I didn't dig into the i2c-viapro code yet, but I shall do it in order
> to plug an PCF8591 in it (the smbus shall be handled by i2c-viapro, am I
> right ?), together with an irda transceiver (with the help of via-ircc)...
> 
> 
>>-----Message d'origine-----
>>De : Jean Delvare [mailto:khali@linux-fr.org] 
>>Envoy? : mercredi 17 mars 2004 22:21
>>? : BARRE Francois
>>Cc : sensors@Stimpy.netroedge.com
>>Objet : Re: [RFC][2.6] Additional i2c adapter flags for i2c 
>>client isolation
>>
>>
>>>This topic makes me think of something _interresting_...
>>>	
>>>According to the tests I made on my VIA Nehemiah M10k, the vt1211
>>>can be handled by i2c-viapro as an smbus device (via the vt596 it
>>>says) and via-ircc as an irda device, BUT this device can not be
>>>binded to both drivers at the same time : when one is loaded (and
>>>activated), the other finds no device (ENODEV I presume). (I wonder
>>>how I should use both smbus*and* irda device)...
>>>
>>>Is this totally out of topic ?
>>
>>"Off-topic" even, yes ;)
>>
>>
>>>Could a hack prevent these two drivers to be mutually exclusive?
>>
>>We knew of a similar problem between i2c-viapro and via686a. I didn't
>>know that i2c-viapro and via-ircc had the same problem. And I 
>>guess that
>>i2c-viapro and vt1211 would conflict too?
>>
>>Mark D. Studebaker is working on a solution for i2c-viapro 
>>and via686a.
>>I don't know if the same solution will apply in the other cases. Since
>>i2c-viapro is involved in all three conflicts, it promises to be damn
>>complex...
>>
>>-- 
>>Jean Delvare
>>http://www.ensicaen.ismra.fr/~delvare/
>>
> 
> 
> 

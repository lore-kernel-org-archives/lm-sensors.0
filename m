From: hunold@convergence.de (Michael Hunold)
Date: Thu, 19 May 2005 06:24:50 +0000
Subject: [RFC|PATCH][2.6] Additional i2c adapter flags for i2c client
Message-Id: <40713CE7.1070308@convergence.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <40686476.7020603@convergence.de>	<20040330213418.195dc972.khali@linux-fr.org>	<406EBA38.1030203@gmx.de>	<20040403163031.122b5df8.khali@linux-fr.org>	<40700823.7030802@convergence.de> <20040404164845.4a4b7d8d.khali@linux-fr.org>
In-Reply-To: <20040404164845.4a4b7d8d.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sensors@stimpy.netroedge.com, linux-kernel@vger.kernel.org
Cc: greg@kroah.com

Hello Jean,

>>Here are some statistics:
>>
>>Ok, adapters which specify I2C_ADAP_CLASS_TV_ANALOG
>>./drivers/media/video/saa7134/saa7134-i2c.c
>>./drivers/media/video/bttv-i2c.c
>>
>>Ok, adapters which specify I2C_ADAP_CLASS_TV_ANALOG (these are my 
>>drivers and I plan to patch them accordingly)
>>./drivers/media/video/hexium_orion.c
>>./drivers/media/video/mxb.c
>>./drivers/media/video/hexium_gemini.c
>>./drivers/media/video/dpc7146.c

> I'm a bit confused, it's I2C_ADAP_CLASS_TV_ANALOG both times. What's the
> difference, except that the second are yours?

I meant to say that the first ones already define 
I2C_ADAP_CLASS_TV_ANALOG correctly, but the latter ones not. But because 
of the fact that these are my drivers, there won't be any problems 
adding the class type and verifying the correctness afterwards.

>>Ok, adapters which specify I2C_ADAP_CLASS_SMBUS,
>>./drivers/i2c/busses/i2c-nforce2.c
>>./drivers/i2c/busses/i2c-sis630.c
>>./drivers/i2c/busses/i2c-piix4.c
>>./drivers/i2c/busses/i2c-sis96x.c
>>./drivers/i2c/busses/i2c-i801.c
>>./drivers/i2c/busses/i2c-ali15x3.c
>>./drivers/i2c/busses/i2c-isa.c
>>./drivers/i2c/busses/i2c-viapro.c
>>./drivers/i2c/busses/i2c-amd8111.c
>>./drivers/i2c/busses/i2c-amd756.c
>>./drivers/i2c/busses/i2c-parport-light.c
>>./drivers/i2c/busses/i2c-parport.c
> 
> 
> You missed i2c-ali1535.c, i2c-sis5595.c and i2c-via.c. I think that you
> used an old 2.6 trer for your statistics :(

Hm, if you consider 2.6.4 old, then yes. Please remember that I'm only a 
i2c core system user, so I simply took the most recent 2.6 version which 
was available.

> i2c-prosavage.c, i2c-savage4.c and radeon_i2c.c are video adapter
> drivers, like i2c-i810.c, i2c-voodoo3.c and i2c-matroxfb.c. Most (if not
> all) of them have several busses, typically one for DDC and one for
> video chips, sometimes more. I don't expect us to have to OR classes in
> most cases, just give the correct class to each bus. This is already
> done for i2c-voodoo3.c, BTW.

Ah, ok, there were double entries when I grepped through the code, so 
the drivers defined different i2c busses then.

>>./drivers/macintosh/therm_adt7467.c
>>./drivers/macintosh/therm_pm72.c
>>./drivers/macintosh/therm_windtunnel.c
>>./drivers/acorn/char/pcf8583.c
>>./sound/oss/dmasound/dac3550a.c
>>./sound/oss/dmasound/tas_common.c
>>./sound/ppc/keywest.c
>>./drivers/media/video/ir-kbd-i2c.c
> 
> 
> No idea either. All I can say is that some busses and chips concern
> sound, so we will have to create a new class (I2C_CLASS_SOUND or
> something similar).

Hm, ok. Because we don't know for sure, we should probably do what I 
propose below.

> Sounds feasable. Now the question is: what will we do with busses and
> chips we don't know? Two possibilities:
> 
> 1* Don't set the class. This prevents the driver from being used, so we
> can expect people to complain quite quickly, letting us fix the drivers
> with the correct class.
> 
> 2* Use I2C_CLASS_ALL. That way they keep working and people will not
> complain. But most drivers will be too permissive, which is against the
> plan.

I like 1 best, but this would be 2.7 stuff. We cannot break working 
configurations for 2.6.

So I tend to use I2C_CLASS_ALL for all drivers we definately not know 
and add a big fat #warning preprocessor message, with an url explaining 
the background (i.e. "this driver doesn't have the correct i2c class 
set. if you are interested in having this driver fixed, have a look at 
http://foo for further informations."

> Frankly I don't know.

If we have agreed on one model, we need to create a big patch and get it 
into the kernel.

I think it would be best if Greg could get it in with his patchsets. 
Greg, is this ok for you or do you have any other proposals?

CU
Michael.

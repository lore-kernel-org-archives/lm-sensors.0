From: henk.vergonet@t-mobile.nl (Vergonet, Henk)
Date: Thu, 19 May 2005 06:23:57 +0000
Subject: New i2c bus driver for S3/VIA chipsets
Message-Id: <5488F12E9B54CC4C9FF74BBE0F08959A07E03519@ben-hqmail01.ben.nl>
List-Id: <lm-sensors.vger.kernel.org>
References: <5488F12E9B54CC4C9FF74BBE0F08959A07E034D7@ben-hqmail01.ben.nl>
In-Reply-To: <5488F12E9B54CC4C9FF74BBE0F08959A07E034D7@ben-hqmail01.ben.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi sensors people,

I will send in a "proper" and tested patch for 2.5, will need some rainy
weather;).
For now here's the bus driver which was developed on top of the 2.7.0
release.

Mark, I am not really sure I want a HW_B number, I just wanted to fill in
something 
in the id field of the adapter struct. If this needs to be something else
please let me know.

Cheers,

Henk Vergonet



-----Original Message-----
From: Mark D. Studebaker [mailto:mds@paradyne.com]
Sent: Friday, May 30, 2003 4:06 AM
To: Greg KH
Cc: Vergonet, Henk; 'sensors@stimpy.netroedge.com'
Subject: Re: New i2c bus driver for S3/VIA chipsets


The next I2C_HW_B_xxx number in CVS would be 0x18.

Henk, please verify that this is a "bit banger" adapter,
you are sure you want an HW_B number?

Greg, I've added several ID's lately, feel free
to include a patch for i2c-id.h in your next batch.

mds



Greg KH wrote:
> On Mon, May 19, 2003 at 07:25:11PM +0200, Vergonet, Henk wrote:
> 
>>Gentlemen (women?), 
>>
>>I would like to submit a new i2c backend driver (GPL), can you give me a
>>hint on how to get this in the standard lm_sensors development tree?
> 
> 
> Send us a patch?  I'd prefer one against a latest 2.5 kernel so I can
> add it to the main kernel source tree.
> 
> 
>>Is there a public mailing list I could send the code as an atachment?
> 
> 
> This one is good.
> 
> 
>>Can you reserve a adaptor ID for this hardware driver? For example:
>>
>>#define I2C_HW_B_S3VIA	0x13	/* S3VIA ProSavage adapter
*/
> 
> 
> Hm, why 0x13?  Is the in-kernel version of i2c-id.h getting out of sync
> with the cvs tree?
> 
> thanks,
> 
> greg k-h
> 


N.B.: op (de inhoud van) deze e-mail is een DISCLAIMER met belangrijke
VOORBEHOUDEN van toepassing: zie http://www.t-mobile.nl/disclaimer 

This e-mail and its contents are subject to a DISCLAIMER with important
RESERVATIONS: see http://www.t-mobile.nl/disclaimer 


  

-------------- next part --------------
A non-text attachment was scrubbed...
Name: i2c-prosavage.c
Type: application/octet-stream
Size: 8276 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20030530/3c9b529a/i2c-prosavage.obj

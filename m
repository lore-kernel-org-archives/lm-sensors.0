From: mds@paradyne.com (Mark D. Studebaker )
Date: Thu, 19 May 2005 06:23:57 +0000
Subject: New i2c bus driver for S3/VIA chipsets
Message-Id: <3ED6BCA3.3060006@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <5488F12E9B54CC4C9FF74BBE0F08959A07E034D7@ben-hqmail01.ben.nl>
In-Reply-To: <5488F12E9B54CC4C9FF74BBE0F08959A07E034D7@ben-hqmail01.ben.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

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
>>#define I2C_HW_B_S3VIA	0x13	/* S3VIA ProSavage adapter		*/
> 
> 
> Hm, why 0x13?  Is the in-kernel version of i2c-id.h getting out of sync
> with the cvs tree?
> 
> thanks,
> 
> greg k-h
> 

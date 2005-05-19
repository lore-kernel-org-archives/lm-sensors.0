From: mds@paradyne.com (Mark D. Studebaker )
Date: Thu, 19 May 2005 06:23:57 +0000
Subject: New i2c bus driver for S3/VIA chipsets
Message-Id: <3ED7F26B.1080701@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <5488F12E9B54CC4C9FF74BBE0F08959A07E034D7@ben-hqmail01.ben.nl>
In-Reply-To: <5488F12E9B54CC4C9FF74BBE0F08959A07E034D7@ben-hqmail01.ben.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

You have HW_B ID 0x18.

Vergonet, Henk wrote:
> OK I will change this.
> Waiting for rain...
> 
> Cheers,
> 
> Henk
> 
> 
> 
> -----Original Message-----
> From: Mark Studebaker [mailto:mds@paradyne.com]
> Sent: Friday, May 30, 2003 3:43 PM
> To: Vergonet Henk
> Cc: 'sensors@stimpy.netroedge.com'
> Subject: Re: New i2c bus driver for S3/VIA chipsets
> 
> 
> you want a HW_B number if it is a "bit banger" adapter which uses
> the i2c_algo_bit algorithm. 
> 
> If the S3VIA is similar to the i2c-i810 driver then that's what you want.
> 
> "Vergonet, Henk" wrote:
> 
>>Hi sensors people,
>>
>>I will send in a "proper" and tested patch for 2.5, will need some rainy
>>weather;).
>>For now here's the bus driver which was developed on top of the 2.7.0
>>release.
>>
>>Mark, I am not really sure I want a HW_B number, I just wanted to fill in
>>something
>>in the id field of the adapter struct. If this needs to be something else
>>please let me know.
>>
>>Cheers,
>>
>>Henk Vergonet
>>
> 
> 
> 
> N.B.: op (de inhoud van) deze e-mail is een DISCLAIMER met belangrijke
> VOORBEHOUDEN van toepassing: zie http://www.t-mobile.nl/disclaimer 
> 
> This e-mail and its contents are subject to a DISCLAIMER with important
> RESERVATIONS: see http://www.t-mobile.nl/disclaimer 
> 
> 

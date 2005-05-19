From: se.witt@gmx.net (Sebastian Witt)
Date: Thu, 19 May 2005 06:25:28 +0000
Subject: ATXP1 kernel patch
Message-Id: <41D84030.2020704@hasw.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <41D821D9.5030003@hasw.net>
In-Reply-To: <41D821D9.5030003@hasw.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

Rudolf Marek wrote:
> +static unsigned short normal_i2c[]= { 0x37, 0x4e, I2C_CLIENT_END };
> 
> I read on some forum also about 0x44. Any clue?

I've only seen the ATXP1 on 0x37 or 0x4e (it only supports two 
addresses), the
0x44 is maybe for another ATXP.

> +static 	DEVICE_ATTR(vcore, 0644, atxp1_showvcore, atxp1_storevcore);
> 
> cpu[0-1]_vid    CPU core reference voltage.
>                 Unit: millivolt
> 
> What about to use this? (This is also question for other developers :)

Yes, good idea.

> +	if(i2c_smbus_read_byte_data(new_client, ATXP1_CVID) <= 0) {
> +		kfree(data);
> +		return 0;
> 
> Hmm really not very scientific nor realible. Any other method is possible?

No, it has no register with a device id.

> Next question is about update lock.
> Why is gone? It is always good idea...

Yes, will be added again.

> Also what about ATXP3 and ATX5 my asus board (A7S333) has ATXP3.

AFAIK the ATXP3 is the same as the ATXP1 but without VID control. Not 
sure about the ATXP5, I've only a board with a ATXP1. Needing someone 
who wants to test this.

> Any effort about getting datasheet?
Attansic doesn't answer me. The mainboard manufacturers say they can't 
give information because of nVidia.

Bye,
Sebastian

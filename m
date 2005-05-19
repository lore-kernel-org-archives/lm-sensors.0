From: mds@paradyne.com (Mark Studebaker)
Date: Thu, 19 May 2005 06:23:32 +0000
Subject: Wrong voltage values LM78
Message-Id: <3CE2BC1D.24981F4F@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1401941434d6.1434d6140194@zonnet.nl>
In-Reply-To: <1401941434d6.1434d6140194@zonnet.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

where are you getting these values?
directly from the chip?

or using our Linux package?

If directly from the chip, look at the datasheet.

PC104 PC104 wrote:
> 
> Hi,
> 
> I m working on a school project about system health monitoring. I m
> trying to read the voltages, temperature and fanspeeds from the LM78
> chip. But I get strange values for voltages. I read about some
> conversions. But I still can't figure out the way to convert these
> values. I get these digital readings:
> 
> core 1 = 187
> core 2 = 205
> +3.3V  = 191
> +5V    =  93
> +12V   =  93
> -12V   =  182
> -5V    =  255
> 
> can you help me with these please...
> 
> Thanks
> Easen.

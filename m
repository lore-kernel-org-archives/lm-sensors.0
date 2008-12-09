From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 09 Dec 2008 07:41:09 +0000
Subject: Re: [lm-sensors] MSI Wind Pc 100
Message-Id: <20081209084109.7915f702@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20081202170230.70d8150377b688c74c15e7947e7d8d3a.340dbf3a9c.wbe@email.secureserver.net>
In-Reply-To: <20081202170230.70d8150377b688c74c15e7947e7d8d3a.340dbf3a9c.wbe@email.secureserver.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Dan,

On Mon, 08 Dec 2008 11:44:34 -0700, DanO wrote:
> Jean,
> 
> Here is the output of the sensors-detect program:
> 
> 
> # sensors-detect revision $Revision$
> # System: MICRO-STAR INTERNATIONAL CO., LTD MS-7418
> (...)
> Now follows a summary of the probes I have just done.
> Just press ENTER to continue:
> 
> Driver `to-be-written':
>   * Bus `SMBus I801 adapter at 0400'
>     Busdriver `i2c-i801', I2C address 0x2e
>     Chip `Analog Devices ADT7467 or ADT7468' (confidence: 7)

This would be your hardware monitoring chip. Unfortunately we do not
have any driver for it at the moment. I can add your name to the list
of interested users on the wiki if you want.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

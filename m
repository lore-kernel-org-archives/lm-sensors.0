From: Heiko Schocher <hs@denx.de>
Date: Mon, 30 Jun 2014 04:10:22 +0000
Subject: Re: [lm-sensors] [PATCH RFT] hwmon: (tmp103) Add missing i2c_set_clientdata call in tmp103_probe
Message-Id: <53B0E32E.1080405@denx.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <1403880569.12833.1.camel@phoenix>
In-Reply-To: <1403880569.12833.1.camel@phoenix>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello Axel,

Am 27.06.2014 16:49, schrieb Axel Lin:
> Add missing i2c_set_clientdata() call in tmp103_probe, this makes the
> dev_get_drvdata() call in tmp103_suspend/tmp103_resume return correct
> address.
>
> Signed-off-by: Axel Lin<axel.lin@ingics.com>
> ---
>   drivers/hwmon/tmp103.c | 1 +
>   1 file changed, 1 insertion(+)

Thanks for detecting this!

bye,
Heiko
-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

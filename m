From: khali@linux-fr.org (Jean Delvare)
Date: Mon, 20 Jun 2005 15:26:46 +0000
Subject: [lm-sensors] Req for sensors help w/ Asus PC-DL
Message-Id: <Gzi6ikmi.1119273728.9166630.khali@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <42B4EC0B.1020603@ripptech.com>
In-Reply-To: <42B4EC0B.1020603@ripptech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi all,

Rudolf Marek wrote:
> We just sent a query about THF chip to winbond we think it might have
> some additional features. (more fans)

You're mixing two different things here. The datasheet I queried Winbond
for is for the W826_8_7THF chip, not for the W836_2_7THF chip. I do not
think there is any (important) feature in the W83627THF that we don't
support.

> In meanwhile you can try:
>
> modprobe adm1021 force_adm1021=0,0x48
> Or better (i'm not sure about delimiter)
> modprobe adm1021 force_adm1021=0,0x48,0,0x49
> sensors

I wouldn't do that. Seeing the dumps, these chips are clearly not
ADM1021-like, and forcing the adm1021 driver may cause trouble. At the
very least, use the read_only parameter of the adm1021 driver. But I'm
pretty sure it won't help anyway. The chips are more likely LM75 or
LM77 compatible. Maybe the Xeon docs from Intel mention it?

--
Jean Delvare

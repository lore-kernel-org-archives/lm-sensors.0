From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:57 +0000
Subject: RFC PATCH libsensors: change vid for adm1025, adm1026 and adm9240
Message-Id: <jfrGbyIf.1115798885.2967650.khali@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <7bd381pbap6v9k0l51b80728rplvfvhvqk@4ax.com>
In-Reply-To: <7bd381pbap6v9k0l51b80728rplvfvhvqk@4ax.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi Grant,

> Does this do the expected changes?, last attempt was back in
> http://archives.andrew.net.au/lm-sensors/msg30079.html
>
> I'm lost in libsensors :)

Not very surprising, as it's not exactly elegant code ;)

All OK except for:

>@@ -2683,7 +2683,7 @@ static sensors_chip_feature adm1026_feat
> 		ADM1026_SYSCTL_GPIO_MASK, VALUE(1), 0 },
>     { SENSORS_ADM1026_VID, "vid",
> 		NOMAP, NOMAP, RW,
>-		ADM1026_SYSCTL_VID, VALUE(1), 3 },
>+		ADM1026_SYSCTL_VID, VALUE(1), 3, "cpu0_vid" },
>     { SENSORS_ADM1026_VRM, "vrm",
> 		NOMAP, NOMAP, RW,
> 		ADM1026_SYSCTL_VRM, VALUE(1), 1 },

This one is not needed, as it will be properly handled by a "constant
mapping" in proc.c.

Thanks,
--
Jean Delvare

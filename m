From: khali@linux-fr.org (Jean Delvare)
Date: Mon, 21 Nov 2005 22:21:57 +0000
Subject: [lm-sensors] Re: [PATCH] VRM table update - take2
Message-Id: <2p4xSCLC.1132607293.2327230.khali@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <20051121203251.19023.qmail@desitka.sh.cvut.cz>
In-Reply-To: <20051121203251.19023.qmail@desitka.sh.cvut.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi Rudolf,

On 2005-11-21, Rudolf Marek wrote:

> -int vid_from_reg(int val, int vrm)
> +int vid_from_reg(int val, u8 vrm)

You need to reflect that change in include/linux/hwmon-vid.h. Same for
vid_which_vrm().

> -static int find_vrm(u8 eff_family, u8 eff_model, u8 vendor)
> +static int find_vrm(u8 eff_family, u8 eff_model, u8 eff_stepping, u8
>      vendor)

Should return u8?

Thanks,
--
Jean Delvare

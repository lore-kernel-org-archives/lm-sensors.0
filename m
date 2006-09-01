From: khali@linux-fr.org (Jean Delvare)
Date: Fri, 01 Sep 2006 11:13:39 +0000
Subject: [lm-sensors] [PATCH] Add VT8237A and VT8251 southbridges to
Message-Id: <20060901131339.f8472e99.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <44F7512F.3080402@sh.cvut.cz>
In-Reply-To: <44F7512F.3080402@sh.cvut.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Rudolf,

(Wrong mailing list...)

> This patch adds VT8237A and VT8251 southbridges to our i2c-viapro driver. 
> Documentation update included.
> 
> Compile tested.

Applied, thanks. Can you please update
http://www.lm-sensors.org/wiki/NewDrivers ?

> diff -uprN linux-2.6.18-rc2/Documentation/i2c/busses/i2c-viapro linux-2.6.18-rc2-patched/Documentation/i2c/busses/i2c-viapro
> --- linux-2.6.18-rc2/Documentation/i2c/busses/i2c-viapro	2006-07-15 23:53:08.000000000 +0200
> +++ linux-2.6.18-rc2-patched/Documentation/i2c/busses/i2c-viapro	2006-08-31 23:03:57.990895500 +0200
> @@ -7,7 +7,7 @@ Supported adapters:
>    * VIA Technologies, Inc. VT82C686A/B
>      Datasheet: Sometimes available at the VIA website
>  
> -  * VIA Technologies, Inc. VT8231, VT8233, VT8233A, VT8235, VT8237R
> +  * VIA Technologies, Inc. VT8231, VT8233, VT8233A, VT8235, VT8237R, VT8237A, VT8251
>      Datasheet: available on request from VIA

Line too long, I've fixed it.

You also forgot to update the device list in
drivers/i2c/busses/Kconfig, I've fixed that as well.

-- 
Jean Delvare


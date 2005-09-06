From: khali@linux-fr.org (Jean Delvare)
Date: Tue, 06 Sep 2005 14:24:57 +0000
Subject: [lm-sensors] Re: [PATCH] i2c: bug fix for busses/i2c-mv64xxx.c
Message-Id: <YylucL9b.1126009025.3161800.khali@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <11259567713187@kroah.com>
In-Reply-To: <11259567713187@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> [PATCH] i2c: bug fix for busses/i2c-mv64xxx.c
>
> When an i2c transfer is successful, an incorrect value is returned.
> This patch fixes that.
>
> Signed-off-by: Jean Delvare <khali@linux-fr.org>
> Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

Let it be noted that David Jenkins and Mark A. Greer definitely deserve
credit for this one.

--
Jean Delvare

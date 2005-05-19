From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:07 +0000
Subject: i2c/sensors patch for 2.4.21 uploaded to my server....
Message-Id: <20030726103155.18072ecd.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <3EFCF67D.9040503@realitydiluted.com>
In-Reply-To: <3EFCF67D.9040503@realitydiluted.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> Okay, so I uploaded a new patch against 2.4.21 to remove the
> macros and the inc_use/dec_use from the scx200 modules. I
> also downloaded 2.4.22-pre8 and noticed that these function
> pointers still have not been fixed been removed from the main
> i2c headers.

And they won't until we submit a patch for integration of i2c-2.8.0 into
Linux 2.4. We plan to submit a patch right after 2.4.22 is released.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/

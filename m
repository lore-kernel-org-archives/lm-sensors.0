From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:06 +0000
Subject: i2c/sensors patch for 2.4.21 uploaded to my server....
Message-Id: <20030720111150.17d73749.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <3EFCF67D.9040503@realitydiluted.com>
In-Reply-To: <3EFCF67D.9040503@realitydiluted.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> The rule is, "modules aren't supposed to change their own usage count"
> so you shouldn't use MOD_xxx_USE_COUNT.
> All the usage counts are changed in i2c-core now.
> That's what caused all the struct changes.

Why are these macros still defined if nobody should use them anymore?

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/

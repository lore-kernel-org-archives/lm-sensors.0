From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:51 +0000
Subject: Setting vrm with 'sensors -s' is broken (w/ Linux 2.6.x)
Message-Id: <20040407215633.4f7e90fb.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040407035157.GD6289@earth.solarsys.private>
In-Reply-To: <20040407035157.GD6289@earth.solarsys.private>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> Replacing
>   *sysmag = (feature->scaling=0?0:3);
> with
>   *sysmag = feature->scaling;
> as it used to be before I broke it should fix the problem.

Just did that.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/

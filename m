From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:32 +0000
Subject: adding support for new 2.6 chips in (lib)sensors
Message-Id: <20031231184732.1abc1f39.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20031230214411.6eb029e7.khali@linux-fr.org>
In-Reply-To: <20031230214411.6eb029e7.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Quoting myself...

> * What's the reason for doing:
>   if(sscanf(name, "temp%d_ove%c%c", &num, &last, &check) = 2
>      && last ='r')
> instead of
>   if(sscanf(name, "temp%d_over%c", &num, &check) = 2)
> ?

I of course meant "= 1" in the second case.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/

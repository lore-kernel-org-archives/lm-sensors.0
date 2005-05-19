From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:31 +0000
Subject: adm1032EB in i2c?
Message-Id: <20031230230157.4181c30e.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <3FF1F02E.9040206@verizon.net>
In-Reply-To: <3FF1F02E.9040206@verizon.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> what's with the adm1032eb entry in i2c/kernel/Module.mk?
> did it come in accidentally with this patch?

Yes :( I should have checked the diff before committing, stupid me. You
can drop it, or I'll do.

Sorry for the trouble :(

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/

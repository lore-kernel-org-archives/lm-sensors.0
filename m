From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:58 +0000
Subject: ADM1030/ADM1031 user-space support
Message-Id: <20040520163440.7f77e83f.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040517100022.54fae886.khali@linux-fr.org>
In-Reply-To: <20040517100022.54fae886.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> I also have a problem with the 2.4 driver. I can't seem to get the
> limits values. sensors -u displays the readings OK, but there's an
> error on each limit. No idea what the problem is. Reading the procfs
> files directly is OK.

Aha, just found why. You define one different SYSCTL number for each
symbol. You are supposed to have one SYSCTL value per procfs file only.
See how other drivers do.

Thanks.

-- 
Jean Delvare
http://khali.linux-fr.org/

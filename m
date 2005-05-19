From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:36 +0000
Subject: fan control question
Message-Id: <20050205190604.1b88ddaf.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050205151509.7b26200c.rkimber@ntlworld.com>
In-Reply-To: <20050205151509.7b26200c.rkimber@ntlworld.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

> In case the module loads automatically try to put
> this line into /etc/modules.conf. Or disable somehow automatic
> loading.
> 
> options w83627hf init=0

That would rather be in /etc/modprobe.conf for a 2.6 kernel.

Also check that you are actually using the w83627hf driver on all
systems. The w83781d driver supports your hardware monitoring chip too,
but I'd expect less trouble with w83627hf.

-- 
Jean Delvare

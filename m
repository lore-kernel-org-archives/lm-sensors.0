From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:51 +0000
Subject: changing pwm does not change fan speed
Message-Id: <20040409225221.2827cbf6.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <40756AB1.60005@laposte.net>
In-Reply-To: <40756AB1.60005@laposte.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> So basically we should just discard PWM support from as99127f since we
> mostly don't know how it works.

OK, I've done that. I've also added some documentation on what we know
about PWM on the AS99127F.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/

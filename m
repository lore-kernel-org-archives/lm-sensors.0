From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:29 +0000
Subject: [PATCH 2.6] more i2c bus drivers (2/2)
Message-Id: <20031211202400.0ac1dd3a.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20031205222400.1b7ff3a6.khali@linux-fr.org>
In-Reply-To: <20031205222400.1b7ff3a6.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> Rather than saying 7xx in the names what about changing:
> 
>     SMBus AMD7xx adapter
> to
>     SMBus AMD756 compatible adapter

39 bytes, while we are limited to 31. Another suggestion? Maybe we can
say AMD756 and just forget about the "compatible".

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/

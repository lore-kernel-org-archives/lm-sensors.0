From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:08 +0000
Subject: sensors -s & adm1027
Message-Id: <20040804204643.0698ef67.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <web-77741@free.net>
In-Reply-To: <web-77741@free.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> sensors-detect works normally. But sensors -s says
> "adm1027-i2c-1-2d can't read or write". It looks something like
> Ticket#1682 (partially).

Please provide the output of "strace sensors -s".

Thanks.

-- 
Jean "Khali" Delvare
http://khali.linux-fr.org/

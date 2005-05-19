From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:23 +0000
Subject: Intel motherboard support question
Message-Id: <20041121223146.4f8d270e.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20041116003713.M51520@konsultex.com.br>
In-Reply-To: <20041116003713.M51520@konsultex.com.br>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Miguel,

> Thank you for the insight. I plan on using kernel 2.6 mostly because
> of SATA support. My other possibility is an ASUS PC DL Deluxe board
> where I feel lm_sensors would have no problems. But since the Intel
> board "seems" to have better SATA chips, meaning less problems with a
> standard installation, I had set my heart on that one. So, it looks
> like a difficult choice. As I told another person that had some
> suggestions similar to yours, I'll let you know how it works out. If
> you have some pointers about the ASUS board, I would like to hear them
> also.

All I can say about the Asus PC-DL is that it uses a Winbond W83627THF
for hardware monitoring, which is well supported under both Linux 2.4
and 2.6 (except for the automatic fan speed control).

Other than than I don't know the board so I cannot help.

Good luck :)

-- 
Jean Delvare
http://khali.linux-fr.org/

From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:29 +0000
Subject: eeprog ASCII readback fix
Message-Id: <20050105213209.7f5dc827.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <008201c4f2ac$a5b66fb0$b601a8c0@Jerry>
In-Reply-To: <008201c4f2ac$a5b66fb0$b601a8c0@Jerry>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> This patch fixes a minor bug in the eeprog program that causes it to
> skip the first byte when printing out data read from the EEPROM in
> ASCII mode (that is, without the hex switch, -x, enabled).

Applied, thanks.

-- 
Jean Delvare
http://khali.linux-fr.org/

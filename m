From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:31 +0000
Subject: i2c bus classes in 2.6
Message-Id: <20031230212940.2d21c683.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Greg,

Shouldn't all bus drivers under linux-2.6.0/drivers/i2c/busses have at
least one class defined? Most of them (19 out of 31) do not, which makes
them useless if my undertanding is correct. Or at least sensor chips
are not detected on them (I experienced this a few minutes ago and it
took me a while to figure out why). If you tell me what the general
policy about classes is, I volunteer to write and submit the (trivial)
patch to fixe all the bus drivers.

Thanks.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/

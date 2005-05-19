From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:11 +0000
Subject: W83L785TS-S
Message-Id: <20030809131023.4213ca57.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030809120646.541e35a3.khali@linux-fr.org>
In-Reply-To: <20030809120646.541e35a3.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi Alex,

Do you have support for the Winbond W83L785TS-S? Looks like it is needed
on the Asus A7N8X. I took a look at the datasheet, it seems to be a
rather simple one-temperature only chip, except that there are two
registers (at 53h and 85h) for temperature correction and limit
configuration. Damn Winbond, the datasheet is awfully poor and written
in a very approximative english. I just can't figure out what I'm
supposed to do with these registers. And of course I don't have that
chip handy, so I can't experiment myself. If you have any clue, it'll be
appreciated :)

Thanks.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/

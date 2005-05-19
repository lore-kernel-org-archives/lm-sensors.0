From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:33 +0000
Subject: Ticket 1506: ASB100
Message-Id: <1073579564.3ffd862c8d67b@imp.gcu.info>
List-Id: <lm-sensors.vger.kernel.org>
References: <1338151684.20040108171517@spin.it>
In-Reply-To: <1338151684.20040108171517@spin.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> I've read ticket 1506 on the sensors support page, "asb100 isn?t
> detected on a7v333", and that's why I'm following up via email, as
> suggested in the ticket answer. This address is mentioned as a
> mailing list but uhm, I didn't find a way to actually subcribe...

This is a real list, but no subsciption is needed.

> I have the same problem on an Asus P4PE; according to the lm_sensors
> 2.8.2 release notes I thought ASB100 was fully supported (is that
> right?), but sensors-detect fails to recognize it on my system
> (Mandrake 9.0, kernel 2.4.19-35mdk).
> 
> "i2cdetect -v" returns versions 2.8.2, so I suppose I do not have
> old stuff around.

Can you please provide the full sensors-detect log? The reason it fails
for you may differ from ticket #1506.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/

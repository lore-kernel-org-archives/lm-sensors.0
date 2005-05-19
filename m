From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:23:58 +0000
Subject: i801 driver broken?
Message-Id: <20030605161822.608217e0.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030605104127.2b87307a.khali@linux-fr.org>
In-Reply-To: <20030605104127.2b87307a.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> most of the PCI drivers in kernel/busses are broken because they
> don't have the pci_device_id tables populated.
> I'm fixing them one at a time by backporting from kernel 2.5.
> I should get to i2c-i801 this weekend - I'm trying to
> actualy test each driver before I check it in but
> I have to shuffle motherboards, monitors, etc. around to do that.

OK. Let me know if I can help. I have 5 computers here I could use for
testing, and have some time left these days. If I remember correctly,
there are one i801, one VIA Pro and three PIIX4. I don't particularily
need i801 done, I was just wondering what was happening. 

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/

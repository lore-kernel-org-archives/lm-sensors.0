From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:22 +0000
Subject: get no informations on laptop acer extensa: Especially smart
Message-Id: <tmhc4Ojf.1100765017.3550290.khali@gcu.info>
List-Id: <lm-sensors.vger.kernel.org>
References: <200411152320.53143.olli.zimmermann@gmx.net>
In-Reply-To: <200411152320.53143.olli.zimmermann@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


>i attached my sensors-detect output and my i2cdetect 0 output. 

They clearly show that the battery isn't exposed on the SMBus. This
confirms what Rurold Marek suggested, i.e. Acer didn't expose the
battery to any standard interface, neither ACPI nor SMBus. So don't
bother porting the smartbatt.c driver to Linux 2.6, it won't help.

We obviously cannot help more, your last hope is to get in touch with
Acer or someone who is familiar with their proprietary interface.

Good luck,
--
Jean Delvare

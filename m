From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:38 +0000
Subject: adt7463 on asus w1n laptop
Message-Id: <20050219193835.7929e5bf.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <200502141545.03330.christophe.dr@free.fr>
In-Reply-To: <200502141545.03330.christophe.dr@free.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Christophe,

> 30: 4d ff ff 64 64 64 00 00 00 00 00 00 00 27 41 6a

Device revision 0x6A. ADM1027 is documented as 0x60+, ADT7463 is
documented as 0x62+, so I would indeed agree that it must be an ADT7463.
Our driver needs to be updated.

In the meantime you can use force_adt7463.

> I think the adresses 0x50 and 0x51 are for eeprom.

You're correct.

-- 
Jean Delvare

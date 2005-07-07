From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 07 Jul 2005 21:19:57 +0000
Subject: [lm-sensors] W83792D & Overtemperature LED on Supermicro
Message-Id: <20050707211936.165859a4.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <1120167411.32695.31.camel@wiz.dev.aspsys.com>
In-Reply-To: <1120167411.32695.31.camel@wiz.dev.aspsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Eric,

> Second dump:

This suggests that some voltages and fan readings are out of range
(namely fan3, 5vcc and fan4). So maybe your overtemperature LED is
reacting to more than just overtemperatures but also to other out of
range conditions. Please try fixing all voltages and fans, and see if it
helps.

Remember that adding "ignore" lines in sensors.conf does NOT disable the
associated channel and alarm, it merely hides it to you. So please
remove all ignore statements and make sure they were not hiding alarms.

-- 
Jean Delvare

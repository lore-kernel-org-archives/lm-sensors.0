From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:02 +0000
Subject: lm_sensors - ASM58 Mozart
Message-Id: <20040622213047.199c307b.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <000c01c45209$2aa07a80$0d00a8c0@frankb>
In-Reply-To: <000c01c45209$2aa07a80$0d00a8c0@frankb>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Frank,

> From lm_sensors New Drivers page: "If you would like to assist us
> with driver writing, testing or project donations, please contact
> us."
> 
> I'm willing to test the ASM58 Mozart driver when it is available.
> 
> System: Red Hat 9 with custom 2.4.20-31.9 kernel, i2c 2.8.4 and
> lm_sensors 2.8.7 on a Asus Terminator K7, AMD Duron 1300, 512 mem.

There is little chance we write a driver, since there is no datasheet
available from Asus. We already had trouble writing drivers for the
AS99127F and the ASB100 ("Bach"), and still have for some features. I
doubt anyone will want to live this again with one more Asus chip. We
received interesting hints from Alex van Kaam (author of Motherboard
Monitor) but it's hardly enough to convince me to go on and write a
driver.

-- 
Jean Delvare
http://khali.linux-fr.org/

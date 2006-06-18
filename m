From: khali@linux-fr.org (Jean Delvare)
Date: Sun, 18 Jun 2006 09:31:17 +0000
Subject: [lm-sensors] better temp2 computation for asus CUSL2C
Message-Id: <20060618113117.9cfa80a1.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20060618021736.f08a39bb.gimeshell@web.de>
In-Reply-To: <20060618021736.f08a39bb.gimeshell@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> i'm using this line in sensors.conf for temp2 computation:
> compute temp2 (@*30/43)+25, (@-25)*43/30
> 
> But resulting temperature is about 8 degrees too low.

Compared to what?

http://www.lm-sensors.org/wiki/FAQ/Chapter3#MyBIOSreportsamuchhigherCPUtemperaturethanyourmodules
(In particular the last paragraph.)

> Does anyone have a better temp2 computation for cusl2c?
> 
> I think it's not wise just to add 33 instead of 25 in computation. ;)

-- 
Jean Delvare


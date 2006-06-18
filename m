From: gimeshell@web.de (gimeshell at web.de)
Date: Sun, 18 Jun 2006 00:17:36 +0000
Subject: [lm-sensors] better temp2 computation for asus CUSL2C
Message-Id: <20060618021736.f08a39bb.gimeshell@web.de>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

i'm using this line in sensors.conf for temp2 computation:
compute temp2 (@*30/43)+25, (@-25)*43/30

But resulting temperature is about 8 degrees too low.
Does anyone have a better temp2 computation for cusl2c?

I think it's not wise just to add 33 instead of 25 in computation. ;)

regards,
gimshell


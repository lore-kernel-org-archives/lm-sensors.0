From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:42 +0000
Subject: Help for ThinkPad Problem
Message-Id: <20040219211926.5f5357db.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <1AtklJ-09doK80@cmpmail00.bbul.t-online.de>
In-Reply-To: <1AtklJ-09doK80@cmpmail00.bbul.t-online.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> i'd read your Post about ThinkPad problems and that you work an method
> to detect the running system - i'd looked today actually on an method
> to detect which mainboard are used on an system and found dmidecode (
> http://www.nongnu.org/dmidecode/ ).
> Specially this package contains an program called vpddecode (prints
> the"vital product data" information that can be found it almost all
> IBM computers)
> which could maybe help you for the detecting process in this special
> or the whole case.

Thanks for your report.

However, you should have noticed that I am both the person in charge of
the Thinkpad issue in lm_sensors and the author of dmidecode. I would
bet this is no coincidence, don't you think? ;)

And yes, the VPD method is now implemented in sensors-detect, although I
agree that it could be refined a bit.

Maybe our documentations would need to be refreshed a bit, but this is a
low priority task at the moment.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/

From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:23:55 +0000
Subject: formula for calculating cpu temp with ASUS cusl2-c
Message-Id: <20030426101917.27bbbb58.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <200304252010.06867.vgmarimon@terra.es>
In-Reply-To: <200304252010.06867.vgmarimon@terra.es>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> Hi, i have an asus cusl2-c mainboard and lm_sensors report bad temp in
> cpu.
> 
> I have a ASUS iPanel and i test some temperatures and i found this
> formula correct:
> 
> 
> 	realvalue = (1,39 * programvalue) + 24,5
> 
> in sensors.conf:
> 
> 
>     compute temp2 (@*1.39)+24.55,(@-24.55)/1.39

Thanks for the formula. Asus has been using many different ones on their
different motherboards, which is causing some trouble.

I think we will use the following line instead:

compute temp2 (@*60/43)+25,(@-25)*43/60

Because it looks really like the other known formula, and I doubt it's a
coincidence.

Is your board for an Intel or AMD cpu?
How recent is it?

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/

From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:19 +0000
Subject: A7V8X-X and lm sensors
Message-Id: <20030926231542.5fae0d70.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030918153623.GA3679@pvv.org>
In-Reply-To: <20030918153623.GA3679@pvv.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> I got some temperatures from a couple of others. One had a bad case so
> he actually managed to run the CPU up to 84C (cpuburn). Told him to
> not do that and see to his computer.
> Another had a fan running at 4000RPM so his temperature was 48. So my
> function is now:
> 
>        compute temp1 (-15.096+1.4893*@), (@+15.096)/1.4893

OK, I added the formula to our default configuration file.

> I can send you a plot showing how it fits with the data if you want.

No need for that, I trust you.

> I haven't managed to find a new address of Gary. All traces stop in
> June. But I think that the 8C in BIOS must have been a typo of 28C.

That was in sensors, not BIOS. Possible that it was a typo however, and
we can't confirm that now. Anyway, if your formula doesn't work for
others, I guess we'll have feedback.

> HTH

Sure it did, thanks a lot.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/

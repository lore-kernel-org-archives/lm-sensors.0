From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:24 +0000
Subject: Question in sensors.conf: # does anyone know a board for which
Message-Id: <20031110190548.2a261556.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <Pine.LNX.4.33.0311061924170.5998-100000@jane.telecom.mipt.ru>
In-Reply-To: <Pine.LNX.4.33.0311061924170.5998-100000@jane.telecom.mipt.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> # for at least Asus A7V133/133-C
> #    compute temp2 @*2.0, @/2.0
> #    compute temp3 @*2.0, @/2.0
> # does anyone know a board for which the following is correct?
>    compute temp2 (@*30/43)+25, (@-25)*43/30
> 
> May be Asus P3B-F
> 
> On Celeron 400
> 
> compute temp2 @*2.0, @/2.0
> CPU Temp:  +33.4?C  (limit = +120?C, hysteresis = +100?C)
> 
> compute temp2 (@*30/43)+25, (@-25)*43/30
> CPU Temp:  +36.7?C  (limit =  +67?C, hysteresis =  +60?C)

We've removed that question from the config file some months ago already
;) Thanks for answering anyway. What make you think the formula is OK
for you? The other formula gives a reasonable result too. BTW I believe
you forgot to run "sensors -s" after switching to the second formula ;)

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/

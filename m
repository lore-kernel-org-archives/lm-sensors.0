From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:23:37 +0000
Subject: lm-sensors (fwd)
Message-Id: <20020815230714.3bb92b37.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <3C61EE92.392A5D31@paradyne.com>
In-Reply-To: <3C61EE92.392A5D31@paradyne.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> Hi
> 
> Is possible that for as99127f (A7V133)
> computing of temp2 is (@*2)
> rather than (@*30/43)+25 ?
> 
> the first options seems to be inline with 
> bios result.

I got the same card (A7V133-C to be precise) and I use @*2.0 for a long
time (and for temp3 also). Maybe there are other boards where
(@*30/43)+25 is correct? I will change to @*2.0, and we'll see if
someone complains. I leave the original as a comment anyway, just in
case.

Thanks for reporting!

-- 
Jean "Khali" Delvare
http://www.ensicaen.ismra.fr/~delvare/

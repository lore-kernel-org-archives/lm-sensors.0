From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:23:50 +0000
Subject: Looking to port...
Message-Id: <20030322093643.28d7c547.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <!~!UENERkVCMDkAAQACAAAAAAAAAAAAAAAAABgAAAAAAAAAmTwsim8zG0S1457O/e1B4cKAAAAQAAAArT9ntgsGyEuGp7hFA/FNhQEAAAAA@norrbring.biz>
In-Reply-To: <!~!UENERkVCMDkAAQACAAAAAAAAAAAAAAAAABgAAAAAAAAAmTwsim8zG0S1457O/e1B4cKAAAAQAAAArT9ntgsGyEuGp7hFA/FNhQEAAAAA@norrbring.biz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> I'm looking for a sensor reading and perhaps also alarm function app
> that I can port to run on Novell NetWare.
> 
> After scouting through your site, I find texts all over that points to
> various releases of the Linux kernel, so now my question is; How
> tightly bound to the kernel is LM-Sensors?  Do you think it's portable
> to run under NetWare?

I don't know NetWare but I'll risk an opinion (since your mail has been
unanswered so far). LM Sensors is huge. I don't think it is hardly bound
to the kernel though (hardware is hardware after all), but LM Sensors
requires a quite complete I2C layer to work, which I suppose you don't
have available on NetWare and would then need to be rewritten. This is
obviously a quite important effort and I would reconsider twice before
going on.

Also, please remember that if you use our code as a base, you are
required to release your code as GPL as well.

Just wondering, Novell NetWare is a network layer to me, not an OS...?
What sense does it make to port hardware device drivers to a network
layer? This just confuses me.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/

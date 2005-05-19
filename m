From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:17 +0000
Subject: lm_sensors messages
Message-Id: <1063784521.3f681049a4d64@imp.gcu.info>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030916214501.3cef3d5c.khali@linux-fr.org>
In-Reply-To: <20030916214501.3cef3d5c.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> I do work for IBM, but not for the PC company (division that makes the 
> Thinkpad).  This means that I could have as much trouble as you have and I 
> can only promise to try. 
> 
>  Anyway,  I don't fully understand the problem.   You can identify which 
> machines have the problem chips, isn't that enough?  Do you just want a 
> complete list for posting?

We can't identify which machines have the problem chips. There's no (known) way
to do that. What we can do is detect which thinkpad we're running on (e.g. TP
600, TP 770, etc.), which means that with a complete listing of which models
have the problem chips, we could let our software run of models that are not on
the list. That's that list we are after and couldn't get our hands on so far.

> BTW.  The message that I sent you was *not* from a thinkpad.  It was from 
> an IBM Intellistation M Pro.

We chose to play it safe and blacklisted all IBM systems (we had one report of
faulty non-Thinkpad IBM, don't remember how reliable it was). As long as we
don't have a complete list of bad models, we have to use the whitelist approach.
If you want sensors-detect to run on your system, let us know and we'll send you
a modified version. If you confirm that your system survived it, we'll add your
model to our (empty so far) white list. Understand that it is a risky process
and that we don't endorse any possible nasty consequence. The risk on a
non-Thinkpad IBM is low, but exist.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/

-------------------------------------------------
This mail sent through IMP: http://horde.org/imp/

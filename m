From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:12 +0000
Subject: New LM83 driver
Message-Id: <20030812200545.086b93df.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030809231304.74f73999.khali@linux-fr.org>
In-Reply-To: <20030809231304.74f73999.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> I had a quick look at the documentation before and it seemed like two 
> of the D? input pins were wired together.

This is something possible (documented in the LM83 datasheet, makes it
possible to set multiple HIGH setpoints for a single measurement).
However...

> But that doesn't make sense 
> since no two temperatures are always the same.

Exactly, this is obviously not the case here.

> I think one went to the south bridge. And maybe I have a north bridge 
> as well!
> I'll have a closer look at the docs tomorrow.

No doubt you have a South bridge, all recent computers do have one
AFAIK.

Now that we have a driver working, an interesting test could be to
monitor these unknown temperatures and see if a given action (listening
to music, watching a video, heavy network traffic...) has a significant
impact on each of them. This would help us discover which chips the
temperatures belong to. BTW, do that only if you have some spare time,
this is more my curiousity speaking here. We don't really need to know
that.

> The brand is SBS and the model is called P014. 

Never heard about that brand. The website seems to be:
http://www.sbs.com/
But I can't see any product called "P014" there, and Goggl'ing it didn't
help either.

Would you have a possibility to compile and run dmidecode on the
machine?
http://www.nongnu.org/dmidecode/

Thanks.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/

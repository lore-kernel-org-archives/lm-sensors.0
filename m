From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:23 +0000
Subject: Question about VID
Message-Id: <20031101120746.69881e15.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20031031055903.GB20640@earth.solarsys.private>
In-Reply-To: <20031031055903.GB20640@earth.solarsys.private>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> Looks like w83627thf doesn't have dedicated VID pins.  But, it has a
> few GPIO pins... some of which just happen to be the same pin #s as
> the dedicated VID pins on the w83627hf.  Haven't tried it yet, but I'd
> bet money that's how it's wired too.  Any clever ideas about how to
> support something like that in the driver?  I'm thinking of just using
> some #ifdef's, but that's not very clever.

You could use a module parameter, for example vid=0 not to use the GPIO
pins and vid=1 to use them in the way you think they are used. This
leaves some place for vid=2, etc... in case new GPIO wirings are
discovered later.

Then you are free to chose whichever default value you think is the
best. I don't have a W83627THF so I can't say.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/

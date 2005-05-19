From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:19 +0000
Subject: fan speed for it87?? chips added
Message-Id: <20030924231030.5c45007e.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <200309232035.29480.michael.hufer@freenet.de>
In-Reply-To: <200309232035.29480.michael.hufer@freenet.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> > 2* Should we provide a init=0 parameter? I think yes. Should it be
> > the default? Not too sure. (But actually, some things *need* to be
> > initialized, while some others do not need to. Especially,
> > temperature and voltage limits belong to userspace, as it has
> > already been discussed). Greg, what's your policy in 2.6 (if you
> > have one)?
> 
> I don't have one, yet.  Haven't thought that much about it.  Any good
> proposals for one?

So far, most of our drivers are reinitializing chipsets and setting
limits. Some drivers have the init=0 module parameter to prevent that.
But it has been discussed recently that init=0 should be the default, or
even that most of the initialization (limits) could go away from the
driver code since it belongs to userspace.

My position is that the driver should change as few things as possible.
Hardware monitoring chips are a sensible realm. Enabling or disabling an
interrupt line or the like can cause the hardware to react (fan to full
speed or even shutdown) and we have had many reports that this happened.
So I think that the chip drivers should, by default, consider that the
chip is well configured for the hardware/bios settings, and initialize
very few things. My drivers work that way (not for the limits yet, but
for the rest).

The problem, as far as Linux 2.6 is concerned, is that libsensors isn't
ready yet, so removing all limit settings may be kind of suicidal
action. Still the point needs to be discussed for later.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/

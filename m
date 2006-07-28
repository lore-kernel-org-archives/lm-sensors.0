From: khali@linux-fr.org (Jean Delvare)
Date: Fri, 28 Jul 2006 18:04:55 +0000
Subject: [lm-sensors] Patch to fully support W81791D
Message-Id: <20060728200455.60e2a474.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <5bfe43f80607101040q5fe64dfdi4e7e2ce349407d62@mail.gmail.com>
In-Reply-To: <5bfe43f80607101040q5fe64dfdi4e7e2ce349407d62@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> Jean Delvare schrieb:
> > Charles, Sven,
> > 
> >>> I've attached a patch to fully support the W81791D chip, which is part of the
> >>> coming kernel 2.1.18.
> >>>
> >>> Partial support was alredy implemented, but it was missing IN9/FAN4/FAN5 output.
> >>>
> >>> Please add it to the SVN.
> > 
> > Where is this patch, please?
> 
> It was attatched - I checked it...

I guess you had only sent it to Charles, who has no write access to the
repository. At least I did not receive your original post and I can't
see it in the mailing list archive either.

> But in case, something went wrong - here it comes again...

Great, thanks. Charles, can you please review and test the patch? Then
I'll apply it if it has no problem.

I'm very surprised that this support was missing since the W83791D
support was added. This means that parts of the drivers (w83781d in 2.4
and w83791d in 2.6) were never actually exercised.

Thanks,
-- 
Jean Delvare


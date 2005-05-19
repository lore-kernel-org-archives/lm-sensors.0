From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:23:42 +0000
Subject: Are you rewriting dmidecode?
Message-Id: <20021124111436.41c81d92.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <y68n0o23i6z.fsf@multics.mit.edu>
In-Reply-To: <y68n0o23i6z.fsf@multics.mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> Hi.  I'm the Debian maintainer for lm-sensors.  Somebody noticed that
> both lm-sensors and another Debian package use Alan Cox's dmidecode
> program.  I was going to package it separately, and contacted Alan
> Cox, who told me that he thought "the lm-sensors folk have been
> rewriting it entirely".
> 
> Are you, in fact, redoing dmidecode?

Yes, I am. I'm glad Alan remembers it, since he never replied when I
sent a preview to him.

> Will sensors-detect die horribly if I swap out the dmidecode in
> prog/detect with a newer version from Alan Cox's FTP site?

It shouldn't die. The worse that can happen is that it issues some error
messages that have been fixed since. In fact, the version we ship with
lm_sensors for now is *not* the rewritten one. It only has some bugfixes
to Alan's one.

May I know which other project uses this code?

I plan to open a project on savannah for dmidecode. Alan seems to be too
busy ton take care of it but it seems there's a need for a common and
frequently updated repository. Any opinion?

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/

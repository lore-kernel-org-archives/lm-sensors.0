From: dmaze@debian.org (David Z Maze)
Date: Thu, 19 May 2005 06:23:42 +0000
Subject: Are you rewriting dmidecode?
Message-Id: <y68n0o23i6z.fsf@multics.mit.edu>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi.  I'm the Debian maintainer for lm-sensors.  Somebody noticed that
both lm-sensors and another Debian package use Alan Cox's dmidecode
program.  I was going to package it separately, and contacted Alan
Cox, who told me that he thought "the lm-sensors folk have been
rewriting it entirely".

Are you, in fact, redoing dmidecode?  Will sensors-detect die horribly
if I swap out the dmidecode in prog/detect with a newer version from
Alan Cox's FTP site?

Thanks,

-- 
David Maze         dmaze@debian.org      http://people.debian.org/~dmaze/
"Theoretical politics is interesting.  Politicking should be illegal."
	-- Abra Mitchell

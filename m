From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:23:51 +0000
Subject: Problem with "sensors -s"
Message-Id: <20030324191326.0400a504.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <3E7EA3D2.60309@astro.physics.upenn.edu>
In-Reply-To: <3E7EA3D2.60309@astro.physics.upenn.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> > Just another question: Do you have any other patch added to your
> > kernel,
> > such as the ptrace bugfix?
> 
> I am running gentoo-sources-2.4.20-r2, which is a heavily patched
> kernel  based on one of the -ac kernels. Yes, it contains the ptrace
> patch.

OK, we had another report, same problem, also using the ptrace patch. On
the other hand, I'm using also the ptrace patch with no problem at all.
However, I'd tend to think that it is the cause of the problem.

Fixing that is far above my own stills, but now that the cause is known
(well, I hope), maybe Phil or Mark will look into the problem. Please be
patient, they seem to be rather busy these days.

Thanks for the report.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/

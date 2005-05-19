From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:30 +0000
Subject: [PATCH 2.4] i2c cleanups
Message-Id: <20031217202854.3914cb8d.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20031213191258.2d78a9f7.khali@linux-fr.org>
In-Reply-To: <20031213191258.2d78a9f7.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

The 4 patches were accepted, you can see them in 2.4.23-bk13. A first
battle we won :) but the war is far from being over.

From 246kB for the patch that was required to update Linux 2.4.23 to
i2c 2.8.2, the patch size is reduced to 215kB with 2.4.23-bk13. If we
leave apart the new drivers, which I don't plan to submit, the remaining
size is 129k. This basically means that I've only done one fifth of the
job so far. I will sumbit another wave of patches as soon as possible.

There's something I would need help with. The main reason why we are
submitting patches is the change in the way module references are
counted. Sooner or later I'll have to submit a patch for that point. I
read on this list that the new method might not be correct though. I
don't want to submit a buggy patch this late in Linux 2.4's life, but on
the other hand I don't have the knowledge nor time to solve the problem,
if there is one. So I would like someone to review that part of our
code, to tell me if this is correct or not and why, and to commit the
required changes to our i2c CVS repository, if needed.

Ky?sti, you seem to understand the problem rather well, so I was
hoping you could help me here. MDS and Greg also would probably be able
to help. Guys, please work it out if you can. And remember that time is
against us, since a structure change won't be accepted after 2.4.24 is
released (it's not even sure it will be accepted *before*...)

If anyone else wants to help, this is very welcome too, of course ;)

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/

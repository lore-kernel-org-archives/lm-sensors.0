From: quintela@mandrakesoft.com (Juan Quintela)
Date: Thu, 19 May 2005 06:23:37 +0000
Subject: lm_sensors and thinkpad
Message-Id: <m2y9b7eyq6.fsf@demo.mitica>
List-Id: <lm-sensors.vger.kernel.org>
References: <3D38A745.6A1F696C@bellsouth.net>
In-Reply-To: <3D38A745.6A1F696C@bellsouth.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

>>>>> "mark" = Mark Studebaker <mds@paradyne.com> writes:

mark> Here's the latest.
mark> The issue is not resolved. We stopped getting help from IBM
mark> several months ago.
mark> The kernel patches (and kernels like Red Hat that have had sensors
mark> included for quite a while now) only contain individual modules.
mark> They don't 'sense' any particular model of board - they look for
mark> a device they support, and either do nothing or exit if they
mark> don't find it.

mark> The tool that's been the problem for IBM users is sensors-detect,
mark> our hardware detection script. It is a userspace tool and is not
mark> part of the kernel patches.

mark> Unless a kernel user (whether 2.5, redhat, whatever) starts
mark> modprobing sensors modules he can't get hurt.
mark> We haven't heard any complaints from IBM users in quite a while -
mark> and as I said Red Hat has been shipping our package for over a year, IIRC.

mark> Sorry you toasted your thinkpad. Believe me if we had the info
mark> from IBM we needed we would try to fix it.

Mandrake has shipped lm_sensors since before February 2001 (I joined
at that point and sensors was already shipped).  I have not had
reports of thinkpad users either.

Later, Juan.


-- 
In theory, practice and theory are the same, but in practice they 
are different -- Larry McVoy

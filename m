From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:21 +0000
Subject: Problems using w83781d (v 2.8.0) on Asus CUV4X
Message-Id: <20031018095213.58b42219.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <1066427722.8562.5.camel@localhost>
In-Reply-To: <1066427722.8562.5.camel@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> that's what i get, when i try to modprobe the w83781d-module into the
> kernel. With lm-sensors 2.7.0 it worked.
> 
> dmesg:
> w83627hf.o version 2.8.0 (20030714)
> w83627hf.o: W83627/697 not detected, module not inserted.
> w83781d.o version 2.8.0 (20030714)
> i2c-core.o: driver  registered.
> Unable to handle kernel NULL pointer dereference at virtual address
> 00000001

Have you been patching your the i2c-2.8.0 path as described in our
installation guide? (http://www.ensicaen.ismra.fr/~delvare/devel/i2c/)
More generally, how have you been installing lm_sensors?
If you have that possibility, trying 2.8.1 would probably be a good idea
(although the structure problem will remain the same, but at least you
might escape bugs we have been fixing since).

> Have you split these modules or where's the problem?

Structure changes between 2.7.0 and 2.8.0 could be at charge there, this
is a known problem, documentation is available (see URI right above) and
we're working on it.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/

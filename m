From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:23 +0000
Subject: RPM spec file patches for i2c and lm_sensors 2.8.1
Message-Id: <20031029000111.59606dfb.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <9D8C1A43309BAD4A9B46071DAF911D9E13FDA5@exch01.paracel.com>
In-Reply-To: <9D8C1A43309BAD4A9B46071DAF911D9E13FDA5@exch01.paracel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> For people like me, who want to easily deploy lm_sensors across a
> cluster of uniform machines, it's very handy to have a spec file there
> so that we can build our own RPMs for specific systems with specific
> kernels and configurations.  Even though the spec file you had was out
> of date, it still saved me a lot of trouble.  
> 
> My vote would be to keep the spec files.  If nobody wants to maintain
> them, call them unsupported or unmaintained.

OK, why not.

> Who's Axel?  I'd be happy to work with him, or just use whatever he
> has or recommends.

Axel Thimm, the guy behind ATrpms:
http://atrpms.physik.fu-berlin.de/
He has RPMs for lm_sensors, I guess you'd be interested in his .spec
files.

> Unified diffs attached.

Thanks, will take a look tomorrow.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/

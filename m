From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:48 +0000
Subject: [PATCH] Enable the build of isadump only on x86 architectures
Message-Id: <20040321141308.7240c270.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040321114152.GA10777@pc.aurel32.private>
In-Reply-To: <20040321114152.GA10777@pc.aurel32.private>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> It seems that isadump is x86 specific, since it makes calls to inb()
> and outb(). The others utilities and the library build well on non-x86
> architectures. That's why I propose to enable the build of isadump
> only on x86 architectures.

Correct, I think I remember we had complaints about that from times to
times.

> The attached patch against current CVS implements that.

Nice, applied. Thanks.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/

From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:29 +0000
Subject: [PATCH] sensord: wrong error message with /proc or /sys not
Message-Id: <20050105223949.6ac8f2db.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050105212346.GA19356@bode.aurel32.lan>
In-Reply-To: <20050105212346.GA19356@bode.aurel32.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> The problem is that the library returns a negative number if there is
> an error, and the error numbers in the .h files are not negative. Thus
> one of the operand of the comparison should be negated. Patch to fix
> that is attached.

Applied, thanks.

> BTW, on 2.6 kernels the sensors informations are in /sys and not
> /proc. The message may be changed into:
> 
>   Error reading /proc or /sys; modules probably not loaded

True. I would certainly accept a patch that does this ;)

-- 
Jean Delvare
http://khali.linux-fr.org/

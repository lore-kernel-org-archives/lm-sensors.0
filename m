From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:20 +0000
Subject: scaling of loadavg in sensord
Message-Id: <20041026220443.5607865d.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <417CB2E3.3090007@aurel32.net>
In-Reply-To: <417CB2E3.3090007@aurel32.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> It make not much sense for sensord to scale the loadavg itself (*10):
> RRDs work with floating-point values and thus do very well with
> non-integer values even < 1.
> 
> They can even be scaled later at display time by rrdtool itself, if
> the user wants it.

Agreed.

> The attached patch removes the scaling of loadvg in sensord.

Applied, thanks.

-- 
Jean Delvare
http://khali.linux-fr.org/

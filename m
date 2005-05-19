From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:41 +0000
Subject: cpu temperature on abit bx133 (w83782d)
Message-Id: <20040215124748.5efee437.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040103175546.GA560@zorba.ds14.agh.edu.pl>
In-Reply-To: <20040103175546.GA560@zorba.ds14.agh.edu.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> sorry for waisting your time - i've finally found where the problem
> was (meaning there was no problem at all)...
> 
> seems that during bios setup the idle loop (awaiting keyboard input,
> etc) is not quite idle - cpu is heavy loaded. after booting linux
> temperatue falls down, it raises to that level only under heavy
> load...
> 
> that explains why cpu clock had no influence under linux - 800 mhz
> cpu doing nothing is almost same as 500 mhz cpu doing nothing...
> 
> once again sorry...

No problem, I'm glad you could finally understand what was happening. In
fact, I remember a few similar reports of BIOS setup temperatures being
higher than under Linux. We knew that the idle loop in BIOS setup
screens were usually bad resulting in a slightly higher temperature. But
we had never seen a 20 degrees difference like you have. Maybe the idle
loop is particularly bad in yours (well, to that extent, I'd bet there is
no idle loop at all...)

Thanks for letting us know anyway.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/

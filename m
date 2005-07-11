From: khali@linux-fr.org (Jean Delvare)
Date: Mon, 11 Jul 2005 15:50:30 +0000
Subject: [lm-sensors] problems loading i2c-proc
Message-Id: <MU9JuTiT.1121089527.1877710.khali@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <Pine.LNX.4.62.0507071513250.11559@snowball.fnal.gov>
In-Reply-To: <Pine.LNX.4.62.0507071513250.11559@snowball.fnal.gov>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi Steven,

> It appears that this problem was due to my mistakely compiling
> the modules for a SMP kernel with a uniprocessor kernel config.
> Have fixed that, and things load OK now.

Oh, great. This explains why I was unable to reproduce the problem, no
matter the kernel version nor how hard I tried.

Anyway, glad you finally figured it out. I'll try to remember in case
others report the same problem. It was really not obvious what the
problem was from the logs alone.

--
Jean Delvare

From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:23:43 +0000
Subject: (from cvs) sensors binary compile probs on rh8
Message-Id: <20021213100127.2b409581.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <3DF93866.7070502@netroedge.com>
In-Reply-To: <3DF93866.7070502@netroedge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> FYI-
> 
> gcc -o prog/sensors/sensors prog/sensors/main.ro prog/sensors/chips.ro
> -Llib -lsensors
> lib/libsensors.so: undefined reference to `log'
> lib/libsensors.so: undefined reference to `exp'
> collect2: ld returned 1 exit stat

Looks like we need an extra "-lm" on the command line.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/

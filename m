From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:02 +0000
Subject: lm_sensors2/prog/detect sensors-detect
Message-Id: <20030628235503.2afc3b96.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20021107235845.0037e195.khali@linux-fr.org>
In-Reply-To: <20021107235845.0037e195.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> With your fix and perl 5.005.02, at the beginning I get:
> 
> Useless use of a constant in void context at
> prog/detect/sensors-detect line 1345.
> 
> which doesn't s top the script, but later on (just after saying YES to
> ISA bus scan)
> 
> Your vendor has not defined Fcntl macro O_BINARY, used at
> prog/detect/sensors-detect line 1343.
> 
> and the script stops. So how do we get this to work on older perls?

We can simply remove the O_BINARY. I let it there just in case, but the
real fix is binmode() two lines below. Binmode does more than O_BINARY
does, so it seems safe to remove the later. I was once told that
O_BINARY was not portable, now I know why ;)

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/

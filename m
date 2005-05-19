From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:47 +0000
Subject: Small fixes to sensord.8 and sensors.conf.5
Message-Id: <20040314200636.7136c778.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040314182002.GA7183@pc.aurel32.private>
In-Reply-To: <20040314182002.GA7183@pc.aurel32.private>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> Please find attached two small patches against the current CVS to fix
> some minor mistakes in manpages:
> - sensord.8
>   --rrd-cgi used instead of --rrd-file in an example

Seems correct, I'll apply your patch.

> - sensors.conf.5
>   This man page refers to itself in the SEE ALSO section

I would tend to thing that it was trying to reference libsensors(3),
since libsensors(3) is referencing sensors.conf(5). I would take a patch
doing this.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/

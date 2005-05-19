From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:22 +0000
Subject: it87 enhancements
Message-Id: <20031027223757.413fda24.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <3F9C7DFF.28141250@paradyne.com>
In-Reply-To: <3F9C7DFF.28141250@paradyne.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> I was thinking of adding pwm support to it87.
> Also exporting sensor type to /proc a la w83781d so that you don't
> need the temp_type= setting at modprobe time.
> Anybody working on this already?

Not exactly that, but we have a patch pending for the it87. See the
whole (long) thread here:
http://archives.andrew.net.au/lm-sensors/msg04549.html
The patch was never applied. Could you take care of that before adding
your own changes?

> Anybody have a board to test on if I come up with something?
No, I don't.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/

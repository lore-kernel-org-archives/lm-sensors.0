From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:23:47 +0000
Subject: LM78 Temperature reading
Message-Id: <20030215090833.02f80852.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <1045288359.3e4dd5a7db631@webmail.shatteredminds.com>
In-Reply-To: <1045288359.3e4dd5a7db631@webmail.shatteredminds.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> Hi! I've just finished installing lm sensors 2.7.0 on my PII 350
> running Slackware 8.1.  All the readings appear to be correct except
> for the temperature, which just sits at +28.0C and never changes.  I'm
> using a somewhat generic 440BX board with an LM78CCVF-J onboard.

Try to heavily load your CPU (compile some kernel or use cpuburn) and
see wether it changes or not. If the temperature increases only
slightly, it could mean that the value corresponds to the M/B (as
opposed to CPU) temperature, or maybe (but less likely IMHO) P/S. If it
doesn't change at all (or, at least, not in a logical way), it may
simply mean that the sensor is not used for your system, and you may
just want to ignore it through the config file.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/

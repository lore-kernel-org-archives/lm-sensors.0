From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:02 +0000
Subject: Matrox G400DH + lm_sensors problem
Message-Id: <20030625111905.416117f9.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030620001151.GA5184@alf.amelek.gda.pl>
In-Reply-To: <20030620001151.GA5184@alf.amelek.gda.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> I looked at the matrox timeout, it is 100 jiffies (= 1 sec). It could
> be less.

It reminds me that I once had a similar problem while trying lm_sensors
(2.6.x I think) on a system which has an old Matrox Mystique card.
Sensors detect took as long as ten minutes (IIRC) to complete, due to a
very, very slow scan of the Matrox I2C bus. So there may be something to
be fixed there.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/

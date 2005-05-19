From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:12 +0000
Subject: [PATCH 2.4] i2c-dev user/kernel bug and mem leak
Message-Id: <20030814214810.39098df5.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030806100702.78298ffe.khali@linux-fr.org>
In-Reply-To: <20030806100702.78298ffe.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> 4. no one really uses i2c-dev at all...

Greg, how dare you! What's more, CC'd to the sensors mailing-list! I
admit it shows your courage though ;)

Everyone using lm_sensors uses i2c-dev, because our sensors-detect
script relies on it. Our i2cdump tool also relies on it, and this tool
is oh so precious to us developpers. Writing new chip drivers and
debugging existing chip drivers would be almost impossible without it.

Whatever is decided, please keep that in mind.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/

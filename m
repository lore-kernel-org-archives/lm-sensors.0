From: r.marek@sh.cvut.cz (Rudolf Marek)
Date: Thu, 14 Jul 2005 13:18:01 +0000
Subject: [lm-sensors] ASUS P5WD2 Premium - Winbond 83627EHG-A
Message-Id: <42D649D0.6050109@sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <42D27327.7050402@internode.on.net>
In-Reply-To: <42D27327.7050402@internode.on.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

OOps you used quite old version of sensors-detect. Please can you retry with newer one from CVS?

wget http://www2.lm-sensors.nu/~lm78/cvs/lm_sensors2/prog/detect/sensors-detect
chmod 755 sensors-detect
./sensors-detect

Thanks.

We have contacts at Winbond and I will ask them about the chip.

Regards

Rudolf

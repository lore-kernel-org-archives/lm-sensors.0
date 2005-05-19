From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:41 +0000
Subject: W83637HF support in lm_sensors
Message-Id: <20040214173631.51521727.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040213201852.79ee2bcf.khali@linux-fr.org>
In-Reply-To: <20040213201852.79ee2bcf.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> It works. But I've got "in0 in1 in2 in3 in4 in7 in8"
> instead of "VCore 1 VCore 2 +5V +12V -12V -5V"

You must have an old configuration file in place. Manually copy
lm_sensors2/etc/sensors.conf.eg to /etc/sensors.conf. It never gets
overwritten by "make install" (in case the user has made changes).

Then you should have the labels.

Glad that it works, let me know if you notice problems, even minor, as
the time passes.

Thanks for testing :)

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/

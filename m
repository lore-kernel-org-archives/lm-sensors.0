From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:05 +0000
Subject: adm9240 chip on a intel se440bx-2
Message-Id: <20040707214449.7ca89e8a.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <000001c4620c$f27351f0$3635430a@glauke>
In-Reply-To: <000001c4620c$f27351f0$3635430a@glauke>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Additional note: I just committed the necessary stuff in libsensors for
the 2.6 adm9240 driver to work. Note however that I did change the
magnitudes of Michiel's original patch so as to respect the standard
sysfs interface. This means that changes to the drivers will most
certainly be necessary. I also renamed vid to in1_ref, again in order to
respect the new standard.

Thanks.

-- 
Jean Delvare
http://khali.linux-fr.org/

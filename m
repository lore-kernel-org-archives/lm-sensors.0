From: pioppo@ferrara.linux.it (Simone Piunno)
Date: Thu, 19 May 2005 06:25:31 +0000
Subject: 2.6.10-mm2: it87 sensor driver stops CPU fan
Message-Id: <200501162332.14324.pioppo@ferrara.linux.it>
List-Id: <lm-sensors.vger.kernel.org>
References: <g7Idbr9m.1105713630.9207120.khali@localhost> <200501151654.46412.pioppo@ferrara.linux.it> <20050115175545.743a39f9.khali@linux-fr.org>
In-Reply-To: <20050115175545.743a39f9.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: LM Sensors <sensors@stimpy.netroedge.com>, LKML <linux-kernel@vger.kernel.org>
Cc: Greg KH <greg@kroah.com>, Jonas Munsin <jmunsin@iki.fi>, djg@pdp8.net


Hi,

While we're at it, the fan speed sensor reports an absurd speed when the fan 
is driven with very low but non-zero pwm values.  For example, driving it 
with pwm=2 I get speeds over 50K rpms, while of course the fan is stopped 
(almost?).  This could be just an hardware sensitivity problem in the sensor 
chip, or a false measure triggered by fan vibration, but maybe you know 
better.

/Simone

-- 
http://thisurlenablesemailtogetthroughoverzealousspamfilters.org

From: Romain Dolbeau <romain@dolbeau.org>
Date: Tue, 06 May 2008 12:53:50 +0000
Subject: [lm-sensors]  Supermicro C2SBE
Message-Id: <482054DE.1070005@dolbeau.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

As I have posted the dmidecode for this board, I'll mention it for the
sake of completeness.

I don't have any configuration for the C2SBE, as the on board W83627DHG
is seen on the ISA bus (not on i2c?) but doesn't display anything.
Here's what dmesg has to say:

w83627ehf: Found W83627DHG chip at 0x290
w83627ehf w83627ehf.656: VID pins in output mode, CPU VID not available

-- 
Romain Dolbeau
<romain@dolbeau.org>


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

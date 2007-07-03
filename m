From: Hans de Goede <j.w.r.degoede@hhs.nl>
Date: Tue, 03 Jul 2007 19:28:05 +0000
Subject: [lm-sensors] generic in and fan print code update headsup
Message-Id: <468AA345.30209@hhs.nl>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

I'm working on and will shortly commit an update to the generic in and fan 
print code.

The in code currently will not print the ")" after printing the min voltage if 
an in input has a min limit but not a max.

The fan code currently will not print the divider for chips without a min 
limit, such as the fscpos ans fscher chips.

The update will fix this.

Regards,

Hans

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

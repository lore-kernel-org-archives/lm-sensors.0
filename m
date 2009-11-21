From: "Jan Bessai" <jan.bessai@uni-dortmund.de>
Date: Sat, 21 Nov 2009 17:28:25 +0000
Subject: [lm-sensors] Support for Family 10h CPUs - Not all sensors are
Message-Id: <232a75d96e552164f4c7073154b36172.squirrel@unimail.uni-dortmund.de>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

according to AMD (
http://www.amd.com/us-en/assets/content_type/white_papers_and_tech_docs/41322.pdf
) not all AMD K10 CPUs have defect sensors. In fact only DR-* revisions
are affected. All CPUs with Socket AM3 as well as all Phenom II Processors
and some Opterons are unaffected (DA-*, RB-*, HY-*).
Please reconsider the statement "Embedded sensors are known to be
unreliable, and won't be supported ever.". Linux should not lack
temperature sensor support for such popular Processors.

Kind regards,

 Jan


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

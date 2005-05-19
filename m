From: robert@paulsenonline.net (Robert C. Paulsen Jr.)
Date: Thu, 19 May 2005 06:23:34 +0000
Subject: sensors-detect problem in CVS 2.6.4 -- patch included
Message-Id: <20020612223708.GA8506@avalon.paulsen.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Minor problem in sensors-detect. Here is the output from cvs diff:

> cvs diff prog/detect/sensors-detect
Index: prog/detect/sensors-detect
=================================RCS file: /home/cvs/lm_sensors2/prog/detect/sensors-detect,v
retrieving revision 1.167
diff -r1.167 sensors-detect
103c103
<        procid => "Intel 82801DB ICH4,
---
>        procid => "Intel 82801DB ICH4",

-- 
Robert C. Paulsen, Jr.
robert@paulsenonline.net

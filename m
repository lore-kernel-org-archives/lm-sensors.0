From: Stefan =?utf-8?b?QnLDvG5z?= <stefan.bruens@rwth-aachen.de>
Date: Sun, 01 Feb 2009 22:35:25 +0000
Subject: Re: [lm-sensors] Support for Intel DG33FB main board?
Message-Id: <loom.20090201T222717-938@post.gmane.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <495C30EF.3090708@earthlink.net>
In-Reply-To: <495C30EF.3090708@earthlink.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Monitoring _should_ be supported via the HECI driver. If it actually works
depends (for now) on the MB having an AMT engine or not (Everything labeled with
vPro has one, other ones dont know ...).

For AMT, have a look at www.openamt.org

For everything else, sensors are supported via QST over HECI - unfortunately,
there is no support for this yet, but have a look at
http://software.intel.com/en-us/forums/manageability-software-
the (near) future.

Regards,

Stefan


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

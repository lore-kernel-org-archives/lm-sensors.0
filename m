From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 07 Jun 2007 17:40:32 +0000
Subject: [lm-sensors] sis5595
Message-Id: <20070607194032.3af0e6aa@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <200307161427.08403.linux@1g6.biz>
In-Reply-To: <200307161427.08403.linux@1g6.biz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Ivo,

Now that we got your SiS5595 to work again, maybe you want to spend
some time finding out why the sensors output doesn't match what you
have in your BIOS? If so, please provide the following information:

* Full output of the latest version of sensors-detect (just to make
sure you don't have a _second_ hardware monitoring chip).
* A list of all hardware monitoring information that is listed by your
BIOS. Labels and values, in order.
* Several outputs of "sensors -c /dev/null", 1 minute apart or so.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

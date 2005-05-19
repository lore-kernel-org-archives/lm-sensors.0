From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:27 +0000
Subject: question
Message-Id: <20041228134319.418a2bbb.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20020214113146.O24643@Stimpy.netroedge.com>
In-Reply-To: <20020214113146.O24643@Stimpy.netroedge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Paul,

> One question I have is that I have two indentical systems from the
> same  manufacturer, Tyan. One has a Celeron CPU and the other has a P4
> with HT,  but the motherboards are the same. On one unit I must use a
> lm85-* in  sensors.conf and the the other with a adt7463-* for the
> chips section or the  values don't make sense.
> 
> Could the different CPU's be causing lmsensors to get confused? I even
> ran  the detect routines and came with the same results. What else
> could I do to  check this?

There's nothing wrong with that. Both chips are mostly compatible, so
Tyan may simply have switched at some point in time for some reason
(price or availabilty for example). You can notice that both chips are
supported by the same driver (lm85).

You can share a section of sensors.conf among several chips by simply
giving it more than just one chip name. If you take a look at the
default configuration file, that's exactly what we do for the lm85
driver:

chip "lm85c-*" "adm1027-*" "adt7463-*" "lm85-*" "lm85b-*"

   set temp1_max 50

(...)

Just do that for your own file and you will have a single file to
maintain for both boards.

-- 
Jean Delvare
http://khali.linux-fr.org/

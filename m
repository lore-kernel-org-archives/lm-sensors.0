From: Matt.Smith@analog.com (Smith, Matt)
Date: Thu, 19 May 2005 06:24:24 +0000
Subject: ADM1032 documentation
Message-Id: <F7CB408531C5264680C9E37DE4FE71A403BE1776@limkexm2.ad.analog.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20031109171910.7d942c42.khali@linux-fr.org>
In-Reply-To: <20031109171910.7d942c42.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean

Appreciate your feedback and will revise the datasheet.

Thanks
Matt

-----Original Message-----
From: Jean Delvare [mailto:khali@linux-fr.org]
Sent: Sunday, November 09, 2003 4:19 PM
To: Smith, Matt; Burke, Mary
Cc: sensors@stimpy.netroedge.com
Subject: ADM1032 documentation



Hello Matt,

While writing an ADM1032 driver for Linux, I came upon a few
incorrectnesses and omissions in the data sheet (revision C). I thought
you might be interested in a report, so that you can have the errors
fixed in the next revisions.

1* Page 6, right column
"When Flags 1 and 0 are set" should be "When flag 1 or 0 is set". Either
flag can trigger the THERM output.

2* Page 7, left column
Table VI would benefit a comment about why higher conversion rates need
a lower average supply current. The reason is given at the bottom of the
column, but that's not where you would be looking for it (IMHO).

3* Page 7, right column
"This value written to this register" should be "The value written to
this register".

4* Page 8
The die revision code is missing. Since I already told Mary about that,
it might be already fixed.

Thanks a lot for your great data sheets and excellent support.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/

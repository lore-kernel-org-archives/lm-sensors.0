From: Mary.Burke@analog.com (Burke, Mary)
Date: Thu, 19 May 2005 06:24:15 +0000
Subject: ADM1032 die revision code
Message-Id: <F7CB408531C5264680C9E37DE4FE71A402F4B8F9@limkexm2.ad.analog.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030830225705.5f8dea91.khali@linux-fr.org>
In-Reply-To: <20030830225705.5f8dea91.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean

The value that register should hold is 
ADM1032 = 4xh  (0100 xxxx)

Hope this helps. Let me know if there is anything else I can do

Thanks and Regards
Mary



-----Original Message-----
From: Jean Delvare [mailto:khali@linux-fr.org] 
Sent: 30 August 2003 21:57
To: Mary Burke
Cc: sensors@stimpy.netroedge.com
Subject: ADM1032 die revision code



Hi Mary,

We are planning to add support for the ADM1032 to our hardware
monitoring program. In order to do so, we would need to be able to
identify the ADM1032. The problem is that the data sheet doesn't give us
the die revision code for the ADM1032. It says: "Undefined". I can't
believe it is actually undefined. It wouldn't make sense to define a
register to hold such a value and not to define that value, isn't it?

I hope you'll be able to get this information back to us so that we have
a reliable ADM1032 detection routine, and can then work on fully
supporting it.

Thanks a lot.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/

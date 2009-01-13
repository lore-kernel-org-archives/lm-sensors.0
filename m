From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 13 Jan 2009 12:31:04 +0000
Subject: Re: [lm-sensors] [Bugme-new] [Bug 12362] New: Extremely high cpu
Message-Id: <20090113133104.3577d07d@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20090112135948.12a01501.akpm@linux-foundation.org>
In-Reply-To: <20090112135948.12a01501.akpm@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Looking for regression in the coretemp driver is barking up the wrong
tree. That driver is _reporting_ the higher temperature usage, it's not
causing it. It is possible that the reported temperature has shifted up
by 15 degrees C between 2.6.24 and 2.6.25 (this can be seen with max
temperature changing from 85 degrees C to 100 degrees C - is it the
case?) But here the reported difference is 25 degrees C, so that can't
be the sole cause. And the differences in reported CPU usage make it
pretty clear that there is a real problem and it's not only a matter of
temperature reporting. So I seriously doubt this has anything to do
with lm-sensors.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

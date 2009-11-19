From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 19 Nov 2009 13:23:06 +0000
Subject: Re: [lm-sensors] amd phenom ii temp
Message-Id: <20091119142306.59de308f@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <379c0ddc0911190214x7808a9f9m47349413351ffa0c@mail.gmail.com>
In-Reply-To: <379c0ddc0911190214x7808a9f9m47349413351ffa0c@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hallo Clemens,

On Thu, 19 Nov 2009 14:09:57 +0100, Clemens Ladisch wrote:
> Jean, who is the hwmon maintainer?

There is no maintainer, as MAINTAINERS says:

HARDWARE MONITORING
L:      lm-sensors@lm-sensors.org
W:      http://www.lm-sensors.org/
S:      Orphan
F:      drivers/hwmon/

> Or where should new drivers be submitted?

Try the lm-sensors list and see if someone picks it up. Or send it to
Andrew Morton, sometimes he can help push new drivers upstream for
orphaned subsystems.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

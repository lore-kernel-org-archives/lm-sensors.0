From: Martin Michlmayr <tbm@cyrius.com>
Date: Fri, 19 Feb 2010 15:39:16 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (g760a) Make rpm_from_cnt static
Message-Id: <20100219153916.GJ1679@jirafa.cyrius.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20100218184625.6dd29565@hyperion.delvare>
In-Reply-To: <20100218184625.6dd29565@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

* Jean Delvare <khali@linux-fr.org> [2010-02-18 18:46]:
> Function rpm_from_cnt is only used internally so it can be made
> static. Make it inline while we're here, for performance reasons
> (although hopefully gcc would figure out by itself...)

Signed-off-by: Martin Michlmayr <tbm@cyrius.com>

-- 
Martin Michlmayr
http://www.cyrius.com/

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

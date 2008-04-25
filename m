From: Jean Delvare <khali@linux-fr.org>
Date: Fri, 25 Apr 2008 06:43:43 +0000
Subject: Re: [lm-sensors] [PATCH 2/3] hwmon (dme1737): skip detection if
Message-Id: <20080425084343.0036f99b@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <480EC828.8080105@gmail.com>
In-Reply-To: <480EC828.8080105@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, 22 Apr 2008 22:24:56 -0700, Juerg Haefliger wrote:
> Skip the checking of the device ID register in the hwmon register block 
> if the force_id option is used.
> 
> Signed-off-by: Juerg Haefliger <juergh at gmail.com>

Of course, otherwise the force_id parameter just can't work. Good catch.

Acked-by: Jean Delvare <khali@linux-fr.org>

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

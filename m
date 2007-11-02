From: Jean Delvare <khali@linux-fr.org>
Date: Fri, 02 Nov 2007 10:24:19 +0000
Subject: Re: [lm-sensors] hwmon/f75375s.c: buggy if()
Message-Id: <20071102112419.60c9be51@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20071017195439.GD3778@stusta.de>
In-Reply-To: <20071017195439.GD3778@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Christian,

On Thu, 1 Nov 2007 12:27:53 +0100 (CET), Christian Emmerich wrote:
> The only modification i made in lm-sensors, setting the value of
> driver to "f75375s" in prog/detect/sensors-detect for "Fintek
> F75373S/SG".

Good catch, this was somehow overlooked. I just fixed it in SVN, thanks
for reporting.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

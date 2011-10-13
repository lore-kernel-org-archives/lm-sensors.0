From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 13 Oct 2011 06:50:18 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon:lm75 add ADT75 support - requires
Message-Id: <20111013085018.563d5ef7@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1318412218-4237-1-git-send-email-michael.hennerich@analog.com>
In-Reply-To: <1318412218-4237-1-git-send-email-michael.hennerich@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, 13 Oct 2011 08:12:43 +0200, Michael Hennerich wrote:
> Considering the number of other LM75 derivatives this driver 
> supports,
> I had wondered if every derivativehad the same behavioron unspecified 
> registers.

No, they definitely don't, but the point was never to auto-detect them
all (some are plain undetectable anyway.) The point was get lm-sensors
to work out of the box on 1997-1999 PC hardware, and the detection code
we had was enough for this. It has been improved since then mainly to
prevent misdetection of newer (incompatible) chips.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

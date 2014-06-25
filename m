From: Kevin Lo <kevlo@kevlo.org>
Date: Wed, 25 Jun 2014 01:39:37 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (w83l786ng) Report correct minimum fan speed
Message-Id: <20140625013937.GA45615@ns.kevlo.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <1403658152.18417.0.camel@phoenix>
In-Reply-To: <1403658152.18417.0.camel@phoenix>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, Jun 25, 2014 at 09:02:32AM +0800, Axel Lin wrote:
> 
> Current code is buggy, it shows the current fan speed as minimum fan speed.
> Fix up show_fan_reg macro to correctly report fan and fan_min speed.
> 
> Signed-off-by: Axel Lin <axel.lin@ingics.com>

Looks good to me, thanks. 

Acked-by: Kevin Lo <kevlo@kevlo.org>

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

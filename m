From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 05 Dec 2011 17:02:54 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (coretemp) Fix oops on driver load
Message-Id: <20111205180254.2808184d@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20111201110047.130190a5@endymion.delvare>
In-Reply-To: <20111201110047.130190a5@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sat, 03 Dec 2011 09:32:24 +0800 (HKT), undersys wrote:
> I've now got the latest microcode from Intel loading fine.
> The coretemp module still will case an "OPPS" but the new code will solve that
> from what i understand but it also still means that coretemp no longer pics up my CPU temp..

Odd. Which microcode package version are you running?
What's your exact CPU family/model/stepping?
Did you get the coretemp driver to work for this CPU with any kernel
version in the 2.6.22 to 2.6.39 range?

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

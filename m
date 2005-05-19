From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:52 +0000
Subject: RFC: test results for adm9240 auto fan clock divider
Message-Id: <20050418221618.287f9424.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <u2l6615hof5r7s4u44gslcaseabv44kbmn@4ax.com>
In-Reply-To: <u2l6615hof5r7s4u44gslcaseabv44kbmn@4ax.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Grant,


> Requirements:

Agreed on everything, except:

> automatic fan clock divider
> ````````````````````````````
>     * User sets 0 to fan_min limit
>       - low speed alarm is disabled
>       - fan clock divider not changed
>       - auto fan clock adjuster disabled

Why would we want to disable the auto fan clock adjuster in this case?

>     * User sets fan_min limit too low
>       - low speed alarm is enabled
>       - fan clock divider set to max
>       - fan_min set to register value 254 which corresponds 
> 	to 664 rpm on adm9240
>       - low speed alarm will be asserted if fan speed is 
> 	less than minimum measurable speed
>       - auto fan clock adjuster disabled (by virtue fan_div = max)
>     * User sets reasonable fan speed
>       - low speed alarm is enabled
>       - fan clock divider set to suit fan_min
>       - auto fan clock adjuster enabled
>     * User sets unreasonably high low fan speed limit
>       - resolution of the low speed limit may be reduced
>       - alarm will be asserted
>       - fan speed may be displayed as zero until the auto fan 
> 	clock divider adjuster brings fan speed clock divider 
> 	back into chip measurement range, this will occur 
> 	within a few measurement cycles.

You also missed one case, which is the main reason why the whole thing
is (IMHO) needed:

     * User doesn't set any limit
       - auto fan clock adjuster enabled

But all in all it looks like we finally agree on what the best strategy
is :)

-- 
Jean Delvare

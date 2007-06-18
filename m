From: Simon Farnsworth <simon.farnsworth@onelan.co.uk>
Date: Mon, 18 Jun 2007 16:02:33 +0000
Subject: Re: [lm-sensors] Possible support for the SMSC SCH5317? (found on
Message-Id: <4676AC99.9080504@onelan.co.uk>
List-Id: <lm-sensors.vger.kernel.org>
References: <46711ACE.3070809@onelan.co.uk>
In-Reply-To: <46711ACE.3070809@onelan.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Juerg Haefliger wrote:
> If you have a sensors.conf for your system, please post it and I'll
> put it in the Wiki.
> 
> Thanks
> ...juerg
> 
I'm just using the following, as I don't need to track all the fans or
temperatures:

chip "smsc47b397-*"

    label fan1 "CPU Fan"
    label fan4 "Sys Fan"

    label temp1 "CPU Temp"
    label temp3 "Sys Temp"

I think I could add:
    label temp2 "M/B Temp"
    label fan3 "PSU Fan"

to get all the fans and temperatures on the HP dc7700 labelled properly.
-- 
Simon Farnsworth


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

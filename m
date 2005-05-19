From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:15 +0000
Subject: interface changes in linux 2.6, lm_sensors 2.8.8
Message-Id: <20040916203232.17e9d385.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040916123814.M40115@linux-fr.org>
In-Reply-To: <20040916123814.M40115@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> Hello,
> 
> I think we need to add "it8712-*" to the sensors.conf.eg,
> because, again, there is difference between 87xx chip family.
> 
> I hope I'm not completly wrong I'm in hurry :)

No, you're correct, this has to be done.

> It was changed in 2.6.9-rc1 with my patch (VRM part 2) that added
> support for it87 VID lines. I will go to slovakia in few hours, so I
> cant provide a patch now. Sorry about that. I can do that on monday if
> really needed.

Well, this can wait a few days, we haven't even set a deadline for 2.8.8
yet. End of the next week maybe? (September 25)

-- 
Jean "Khali" Delvare
http://khali.linux-fr.org/

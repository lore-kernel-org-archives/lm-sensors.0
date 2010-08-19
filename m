From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 19 Aug 2010 09:37:56 +0000
Subject: Re: [lm-sensors] pwmconfig doesn't detect correlations properly
Message-Id: <20100819113756.152ca60c@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <AANLkTinN=fLZZyMNfHL5CShkRDOjMTUQeV+GZChUKdWy@mail.gmail.com>
In-Reply-To: <AANLkTinN=fLZZyMNfHL5CShkRDOjMTUQeV+GZChUKdWy@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, 19 Aug 2010 11:06:41 +0200, Jean Delvare wrote:
> Thanks a lot for reporting. I have a hard time believing that this has
> been broken for years and you're the first one to report, but this is
> the case... I'm even more surprised that _I_ did not notice the bug,
> while I have been using pwmconfig a lot and worked a lot on it over the
> past few years.

I've created ticket #2380 to track this issue, so that it doesn't get
lost:
http://www.lm-sensors.org/ticket/2380

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

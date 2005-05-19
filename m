From: mds@paradyne.com (Mark D. Studebaker )
Date: Thu, 19 May 2005 06:24:02 +0000
Subject: lm_sensors2/kernel/include sensors.h
Message-Id: <3EFDDCFE.4050209@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <3EFCD70E.8030401@paradyne.com>
In-Reply-To: <3EFCD70E.8030401@paradyne.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

It may be dangeroous (but I don't think so) but it's already happened. 
sensors.h is overwritten by the automatically-generated version.
Looks to me like it works great.
Keep testing...

Jean Delvare wrote:
>>Don't do this!
>>sensors.h is now automatically generated...
>>(see sensors.h.template and Module.mk).
>>We're going to remove sensors.h from CVS before the release.
>>If there's a warning to be fixed it's in sensors.h.template??
> 
> 
> Isn't removing sensors.h right before the release a bit dangerous? The
> autogeneration feature should be tested before that.
> 
> As for the warning I removed, it's in a comment that does not exist in
> sensors.h.template, so there's nothing to care about.
> 

From: Guenter Roeck <groeck-dsl@sbcglobal.net>
Date: Tue, 11 Dec 2012 14:43:34 +0000
Subject: Re: [lm-sensors] Fwd:  Driver for Bulldozer
Message-Id: <20121211144334.GA30334@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <CAMcsHH3ou4U_v5oFGivFPKMKKWKG7guueS=byF5pTqB8Q9VuDQ@mail.gmail.com>
In-Reply-To: <CAMcsHH3ou4U_v5oFGivFPKMKKWKG7guueS=byF5pTqB8Q9VuDQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, Dec 11, 2012 at 04:19:17AM -0500, Vahid Keykhaey wrote:
> Dear Reader,
> Hi,
> When I try to install cpufreqmodules, I get a fail on "loading cpufreq
> kernel modules".
> 
> and the result of my sensors-detect command is enclosed.
> 
> thank you for your help. I do not need power monitoring modules but thermal
> monitoring modules.
> 
Guess you are asking to have the respective change change made to the k10temp
driver. Should not be a problem if someone happens to know the correct PCI
device ID (it might be 0x1533 but I am just guessing).

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Thu, 05 Apr 2012 14:39:43 +0000
Subject: Re: [lm-sensors] ASUS Kfn4-dre
Message-Id: <20120405143943.GB24078@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20120405154219.206754q3naxbvvp7@webmail.tuwien.ac.at>
In-Reply-To: <20120405154219.206754q3naxbvvp7@webmail.tuwien.ac.at>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, Apr 05, 2012 at 09:42:19AM -0400, Michael Weingartner wrote:
> Dear Ladies and Gentlemen,
> 
> I have a asus kfn4-dre serverboard. I use lm-sensors form ubuntu repositories.
> With ubuntu 8.04 LTS. I had with full CPU load 55-60 degrees celsius.
> 
> I have done a distributionupgrade to 10.04 LTS and I use a backport kernel.
> 
Nice, but all you are saying is that you use a kernel later than 2.6.32, but not exactly
which one. Not very helpful.

> I have done a "sensors-detect" and now I have 40-50 degree celsius  
> with k8temps CPU.
> 
There were several changes in the driver over time to fix wrong temperature readings.
Which ones affect your kernel are impossible to say without knowing the exact kernel version.

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

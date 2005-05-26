From: akpm@osdl.org (Andrew Morton)
Date: Thu, 26 May 2005 09:05:28 +0000
Subject: [lm-sensors] Re: Who should I write to about this OOPS in 2, 6,
Message-Id: <20050525225352.5a3e94ae.akpm@osdl.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050315050746.GB13009@kroah.com>
In-Reply-To: <20050315050746.GB13009@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Miles Lane <miles.lane@gmail.com> wrote:
>
> Yes, this is all fixed in the recent mm series trees.
> I haven't checked 2.6.12-rc5 and 2.6.12-rc5-mm1 
> gave me a build error, which I have reported to 
> Andrew. I will test within the next couple of days
> on 2.6.12-rc5, but I am pretty certain that all is
> working well now that nvidiafb defaults to using
> 64MB at boot time. Also, the problems with the i2c
> stuff getting mucked up when the nvidiafb driver
> was automatically unloaded, due to vesafb being
> used instead, is fixed.
> 

Sweet,  thanks.


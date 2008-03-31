From: Wes Felter <wesley@felter.org>
Date: Mon, 31 Mar 2008 19:55:52 +0000
Subject: Re: [lm-sensors] [PATCH 1/2] Define sysfs interfaces for ibmaem
Message-Id: <47F141C8.50401@felter.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20080328213646.GC7191@tree.beaverton.ibm.com> <20080329145603.7e47418f@hyperion.delvare>
In-Reply-To: <20080329145603.7e47418f@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: lm-sensors@lm-sensors.org

Jean Delvare wrote:

> On Fri, 28 Mar 2008 14:36:46 -0700, Darrick J. Wong wrote:

>> +energy[1-*]_input		Instantaneous energy use
> 
> This doesn't make sense to me. Energy is a quantity, it exists
> independently of time. An "instantaneous energy use" only makes sense
> if you tell in what (presumably very small) amount of time the energy
> was used... and then what you are measuring is not an energy but a
> power, for which we already have an interface. Please clarify.

I agree. May I suggest "cumulative energy use"?

Wes Felter - wesley@felter.org


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

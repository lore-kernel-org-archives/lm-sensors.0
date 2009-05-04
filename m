From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 04 May 2009 09:42:28 +0000
Subject: Re: [lm-sensors] [PATCH 7/8] sensord: Use sigaction() for signal
Message-Id: <20090504114228.5378e714@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20090406075758.GH4734@ubuntu>
In-Reply-To: <20090406075758.GH4734@ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Andre,

On Mon, 4 May 2009 11:22:51 +0200, Andre Prendel wrote:
> On Mon, Apr 06, 2009 at 09:57:58AM +0200, Andre Prendel wrote:
> > Replace the deprecated signal() function by sigaction().
> > 
> > The signal() function has some disadvantages. This patch replaces
> > signal() by sigaction() to install the signal handlers.
> 
> Hi Jean,
> 
> there are two patches left for reviewing (7/8, 8/8).
> 
> Maybe you have forgotten about that. So here is the reminder ;)

Not forgotten, just too busy. I hope to have some time to review them
second half of this week.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

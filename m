From: david-b@pacbell.net (David Brownell)
Date: Sun, 12 Jun 2005 16:16:49 +0000
Subject: [lm-sensors] Re: i2c_set/get_clientdata inconsistencies
Message-Id: <200506120715.53413.david-b@pacbell.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050612082400.78699b29.khali@linux-fr.org>
In-Reply-To: <20050612082400.78699b29.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Saturday 11 June 2005 11:24 pm, Jean Delvare wrote:
> 
> I noticed that a few Linux i2c chip drivers do not use
> i2c_set_clientdata and i2c_get_clientdata in a consistent manner.
> 
> The isp1301_omap and tps65010 drivers do call i2c_set_clientdata at
> client registration time, but then never call i2c_get_clientdata, not
> even at release time, instead using container_of directly.

I don't see a problem.  They allocated the memory and know how it's
laid out; why shouldn't they use container_of()?  A subtraction being
cheaper than a memory access, and all that.  Though it's true that if
they don't get_clientdata, they might as well not set_clientdata.

- Dave


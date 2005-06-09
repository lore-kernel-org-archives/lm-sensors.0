From: rlrevell@joe-job.com (Lee Revell)
Date: Thu, 09 Jun 2005 17:48:57 +0000
Subject: [lm-sensors] Re: [RFC] SPI core
Message-Id: <1118331690.15527.32.camel@mindpipe>
List-Id: <lm-sensors.vger.kernel.org>
References: <1117555756.4715.17.camel@diimka.dev.rtsoft.ru>
	 <20050531233215.GB23881@kroah.com>
	 <20050602040655.GE4906@jupiter.solarsys.private>
	 <20050602045145.GA7838@kroah.com>
	 <1117717356.5794.9.camel@localhost.localdomain>
	 <20050609071523.GE22729@kroah.com>  <42A81C56.1070602@cetrtapot.si>
In-Reply-To: <42A81C56.1070602@cetrtapot.si>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Hinko Kocevar <hinko.kocevar@cetrtapot.si>
Cc: Greg KH <greg@kroah.com>, Rui Sousa <rui.sousa@laposte.net>, "Mark M. Hoffman" <mhoffman@lightlink.com>, dmitry pervushin <dpervushin@ru.mvista.com>, linux-kernel@vger.kernel.org, lm-sensors <lm-sensors@lm-sensors.org>

On Thu, 2005-06-09 at 12:39 +0200, Hinko Kocevar wrote:
> I would also like to see SPI core in linux driver model, but nothing
> like I2C 
> stuff. SPI is far to simple (and yet so diverse) that much more simple
> concept 
> could be used. 

Did you look at sound/i2c/i2c.c?  ALSA has its own i2c implementation,
only 333 lines, due to the kernel i2c core being overly complex for
ALSA's needs.

"Although there is a standard i2c layer on Linux, ALSA has its own i2c
codes for some cards, because the soundcard needs only a simple
operation and the standard i2c API is too complicated for such a
purpose." 

(from http://www.alsa-project.org/~iwai/writing-an-alsa-driver/x77.htm)

Personally, I would start with this, then add any needed functionality.

Lee


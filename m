From: Jean Delvare <khali@linux-fr.org>
Date: Fri, 12 Nov 2010 15:09:50 +0000
Subject: Re: [lm-sensors] IT8721F fan control?
Message-Id: <20101112160950.223ba5f8@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20101106002259.GA1871@hellug.gr>
In-Reply-To: <20101106002259.GA1871@hellug.gr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Fri, 12 Nov 2010 01:23:05 +0200, Alexandros Diamantidis wrote:
> * Luca Tettamanti [2010-11-11 14:56]:
> > > For the moment I've disconnected the chassis fan because it was very
> > > distracting.
> > 
> > It should be controllable with QFan, no?
> 
> Do you mean the BIOS Q-Fan option? It only mentions a "CPU Q-Fan", which
> is enabled and doesn't seem to do much for the front fan. The other two
> fans indeed aren't so loud, so it probably works for them. Could that
> mean that the front fan speed isn't controllable at all by the hardware?
> 
> Since even with Q-Fan enabled it's not as quiet as I'd like and
> temperatures don't rise much even under full load, I'd be nice if fans
> could go even slower if possible. My initial message was mostly a query
> about whether the native driver will allow this when complete.

Looking at the it87 driver code, it is pretty clear that I messed up
the manual fan speed control support for the IT8721F. Sorry about that.
It requires much larger changes compared to other chips, than I first
thought.

Working on it, stay tuned...

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

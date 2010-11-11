From: Alexandros Diamantidis <adia@hellug.gr>
Date: Thu, 11 Nov 2010 23:23:05 +0000
Subject: Re: [lm-sensors] IT8721F fan control?
Message-Id: <20101111232305.GA1972@hellug.gr>
List-Id: <lm-sensors.vger.kernel.org>
References: <20101106002259.GA1871@hellug.gr>
In-Reply-To: <20101106002259.GA1871@hellug.gr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

* Luca Tettamanti [2010-11-11 14:56]:
> > For the moment I've disconnected the chassis fan because it was very
> > distracting.
> 
> It should be controllable with QFan, no?

Do you mean the BIOS Q-Fan option? It only mentions a "CPU Q-Fan", which
is enabled and doesn't seem to do much for the front fan. The other two
fans indeed aren't so loud, so it probably works for them. Could that
mean that the front fan speed isn't controllable at all by the hardware?

Since even with Q-Fan enabled it's not as quiet as I'd like and
temperatures don't rise much even under full load, I'd be nice if fans
could go even slower if possible. My initial message was mostly a query
about whether the native driver will allow this when complete.

* Jean Delvare [2010-11-11 15:37]:
> > In fact, that fan speed is usually read correctly, but intermittently
> > jumps to some absurd value. I don't think it's a problem of the driver,
> 
> This is a common problem when using external fan speed control
> solutions (potentiometers, fanbus and the like.)

There's nothing of the sort in use here, but maybe you're right that the
CPU fan itself causes the misreading. No big problem anyway...

Thanks again!

Alexandros

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

From: khali@linux-fr.org (Jean Delvare)
Date: Tue, 31 Oct 2006 21:15:36 +0000
Subject: [lm-sensors] "Built-in" via686a sensors names
Message-Id: <ijh1OxPz.1162329336.8461890.khali@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <4545A129.5000600@comcast.net>
In-Reply-To: <4545A129.5000600@comcast.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi Ian,

On 10/31/2006, Ian Pilcher wrote:
> Jean Delvare wrote:
> > This is a bug in Fedora and/or gkrellm. What do you expect from us by
> > reporting it on the lm_sensors list?
>
> I guess it would be a bug in gkrellm, since it's making the assumption
> that a voltage sensor will be named "inX".  OTOH, I'm not really sure
> what else an application is supposed to do, since there doesn't appear
> to be an API to determine the type of a sensor.

Indeed, this part is missing from the current API, has been identified as
such, and should be added in a near future. Right now, applications must
either include device-specific code to format the values properly (as
sensors does), or display only numbers without units (as sensors -u
does). I guess this is the major reason why the author of gkrellm never
wanted to use libsensors in the first place.

> Mostly, I wanted to start a discussion about whether the current
> behavior is useful.  From what you say about 2.11.0, it sounds like the
> problems it causes have been recognized, which is good news.

The current behavior must be somewhat useful, as a dozen applications
have been using it for many years. But it's admittedly suboptimal.
Something better should be available soon (say mid-2007), making it
possible for application authors to write only generic code and still
handle all devices propely with nicely formatted output (Linux 2.6 only.)

--
Jean Delvare


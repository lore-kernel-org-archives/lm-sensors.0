From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Date: Thu, 16 Sep 2010 16:54:41 +0000
Subject: Re: [lm-sensors] [PATCH 1/2] hwmon: (adm1031) Replace update_rate
Message-Id: <20100916165441.GA11371@khazad-dum.debian.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1284602835-7605-1-git-send-email-guenter.roeck@ericsson.com>
 <1284602835-7605-2-git-send-email-guenter.roeck@ericsson.com>
 <20100916171443.0322bdb6@hyperion.delvare>
 <20100916154243.GB25145@khazad-dum.debian.net>
 <20100916180112.2ce29d2a@hyperion.delvare>
In-Reply-To: <20100916180112.2ce29d2a@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean Delvare <khali@linux-fr.org>
Cc: Randy Dunlap <rdunlap@xenotime.net>, linux-doc@vger.kernel.org, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org

On Thu, 16 Sep 2010, Jean Delvare wrote:
> > I'd rather have it in Hz, actually.  I consider that more user-friendly.
> > But that's just personal preference.
> 
> The problem with Hz is that we need to be able to handle values lower
> than 1, and mHz as a unit isn't exactly friendly. I would be very fine
> with Hz (especially as we use it for pwmN_freq already) if we didn't
> have to support frequencies below 1 Hz. For such low frequencies,
> period (or interval) is clearer than frequency IMHO.

We can always use fixed point math... ;-)

I am kidding, I am perfectly aware it is not worth the trouble.

And I agree with you, mHz would be horrible as far as usability goes.  And
prone to be confused with MHz, too.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

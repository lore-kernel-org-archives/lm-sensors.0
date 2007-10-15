From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 15 Oct 2007 13:17:39 +0000
Subject: Re: [lm-sensors] lm-sens 2.10.5 fschmd support
Message-Id: <20071015151739.473fd5d6@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <470F3474.5040809@hhs.nl>
In-Reply-To: <470F3474.5040809@hhs.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sun, 14 Oct 2007 13:57:01 +0200, Hans de Goede wrote:
> Jean Delvare wrote:
> > As a side note, I am curious how the fscher driver was supposed to work
> > before your patch. The driver creates fan#_div when libsensors lists
> > fan#_ripple. So unless I'm missing something, it probably just wasn't
> > working, and nobody ever bothered to report. Odd.
> 
> It didn't work with "sensors -u", the normal "sensors" print code for the fsc 
> chips using the old drivers doesn't show the divider, so there it worked fine.

Ah, OK, that explains it. Thanks.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

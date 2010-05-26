From: Wim Van Sebroeck <wim@iguana.be>
Date: Wed, 26 May 2010 07:38:43 +0000
Subject: Re: [lm-sensors] [PATCH 3/3] [RFC] watchdog: f71808e_wdt: new
Message-Id: <20100526073843.GJ3972@infomag.iguana.be>
List-Id: <lm-sensors.vger.kernel.org>
References: <20100325125005.6d58cfaf@lxorguk.ukuu.org.uk> <1269523063-30346-1-git-send-email-me@mortis.eu> <1269523063-30346-2-git-send-email-me@mortis.eu> <1269523063-30346-3-git-send-email-me@mortis.eu> <20100330090639.GA8822@salidar.me.mortis.eu> <20100520075229.GO4008@infomag.iguana.be> <20100525210824.GA7815@salidar.me.mortis.eu>
In-Reply-To: <20100525210824.GA7815@salidar.me.mortis.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Giel van Schijndel <me@mortis.eu>
Cc: Hans de Goede <hdegoede@redhat.com>, Jean Delvare <khali@linux-fr.org>, Jonathan Cameron <jic23@cam.ac.uk>, Laurens Leemans <laurens@signips.com>, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org

Hi Giel,

> > Driver looks OK to me. Can't apply it before the I/O resource sharing
> > is in place.  How do you want to proceed?
> 
> I would think applying it to watchdog-next to apply it for the next
> kernel release (similar to Jean Delvare's linux-next).

Will add it after 2.6.35-rc1 is out then.

Kind regards,
Wim.


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

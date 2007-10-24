From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 24 Oct 2007 15:30:13 +0000
Subject: Re: [lm-sensors] lm-sensors 3.0.0-rc1 has been released!
Message-Id: <20071024173013.479b98d6@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20070925233316.7afaa297@hyperion.delvare>
In-Reply-To: <20070925233316.7afaa297@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Hans,

On Mon, 22 Oct 2007 21:27:29 +0200, Hans de Goede wrote:
> Jean Delvare wrote:
> > On Mon, 22 Oct 2007 15:15:51 +0200, Hans de Goede wrote:
> >> Well with mine one can do:
> >> #if (SENSORS_API_VERSION / 100) = 4
> >>
> >> But I'm fine with either.
> > 
> > Ah right, I tend to forget that >> is nothing more than a division ;)
> > But... still, I think I'd feel more confident if we used hexadecimal.
> 
> Ok, changed to hexadecimal

OK, thanks. Additionally, don't you think you should document it in
libsensors.3? I guess that this is what application authors are
reading, rather than sensors.h itself.

Thanks,
-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

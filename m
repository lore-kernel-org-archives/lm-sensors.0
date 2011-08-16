From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 16 Aug 2011 16:18:48 +0000
Subject: Re: [lm-sensors] [PATCH v3] hwmon: add caseopen detection to
Message-Id: <20110816181848.2ee10241@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1313181671-5164-1-git-send-email-mad_soft@inbox.ru>
	<1313422796.2214.133.camel@groeck-laptop>
In-Reply-To: <1313422796.2214.133.camel@groeck-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: guenter.roeck@ericsson.com
Cc: Dmitry Artamonow <mad_soft@inbox.ru>, lm-sensors@lm-sensors.org, Ian Dobson <i.dobson@planet-ian.com>, linux-kernel@vger.kernel.org

On Mon, 15 Aug 2011 08:39:56 -0700, Guenter Roeck wrote:
> On Fri, 2011-08-12 at 16:41 -0400, Dmitry Artamonow wrote:
> > Export caseopen alarm status into userspace for Winbond W83627*
> > and Nuvoton NCT677[56] chips and implement alarm clear knob.
> > Second caseopen alarm on NCT6776 is also supported.
> > 
> > Thanks to Guenter Roeck for information about Nuvoton chips
> > and suggestion to use SENSOR_ATTR_2.
> > 
> > Signed-off-by: Dmitry Artamonow <mad_soft@inbox.ru>
> 
> Applied to -next.

Looks very good, thanks to both of you. It's nice to see more drivers
implement this feature after it got standardized.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

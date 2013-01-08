From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 08 Jan 2013 07:30:41 +0000
Subject: Re: [lm-sensors] ASUS M5A99X EVO R2.0
Message-Id: <20130108083041.4d553056@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <201301050318.r053Ioa1022953@mx3.lsn.net>
In-Reply-To: <201301050318.r053Ioa1022953@mx3.lsn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, 7 Jan 2013 17:31:16 -0600, Leslie Rhorer wrote:
> > -----Original Message-----
> > From: Jean Delvare [mailto:khali@linux-fr.org]
> > Sent: Monday, January 07, 2013 3:54 PM
> > To: Leslie Rhorer
> > Cc: lm-sensors@lm-sensors.org
> > Subject: Re: [lm-sensors] ASUS M5A99X EVO R2.0
> > (...)
> > Try /etc/sensors3.conf instead, or even better, create a new file
> > under /etc/sensors.d for your board.
> 
> 	Ah!  I hadn't even noticed there was already a /etc/sensors3.conf
> file.  Editing that instead of /etc/sensors.conf did the trick.  I may
> create the file in /etc/sensors.d after I get all the other stuff worked
> out.  Would M5A99X_EVO.conf be OK for the name, or does the name have to be
> sensors.conf?

Any name will work, although I suggest one ending in .conf, as this
might become a requirement in the future.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

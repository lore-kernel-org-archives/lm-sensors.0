From: Guenter Roeck <linux@roeck-us.net>
Date: Tue, 14 Jan 2014 17:58:42 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (coretemp) Fix truncated name of alarm attributes
Message-Id: <20140114175842.GD11586@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <20140114155955.7db1fa2b@endymion.delvare>
In-Reply-To: <20140114155955.7db1fa2b@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, Jan 14, 2014 at 06:56:57PM +0100, Jean Delvare wrote:
> On Tue, 14 Jan 2014 09:50:23 -0800, Guenter Roeck wrote:
> > On Tue, Jan 14, 2014 at 03:59:55PM +0100, Jean Delvare wrote:
> > > When the core number exceeds 9, the size of the buffer storing the
> > > alarm attribute name is insufficient and the attribute name is
> > > truncated. This causes libsensors to skip these attributes as the
> > > truncated name is not recognized.
> > > 
> > > Reported-by: Andreas Hollmann <hollmann@in.tum.de>
> > > Signed-off-by: Jean Delvare <khali@linux-fr.org>
> > > Cc: stable@vger.kernel.org
> > 
> > Applied. I'll run my usual full-blown test series and send it to Linus
> > tomorrow.
> 
> I was about to send it, but if you take care of that for me, even
> better :-)
> 
My pleasure.

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

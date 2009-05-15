From: Andre Prendel <andre.prendel@gmx.de>
Date: Fri, 15 May 2009 09:20:16 +0000
Subject: Re: [lm-sensors] [PATCH RFC 2/2] tmp401: Add support for
Message-Id: <20090515092016.GB4656@ubuntu>
List-Id: <lm-sensors.vger.kernel.org>
References: <20090515091222.GA4656@ubuntu>
In-Reply-To: <20090515091222.GA4656@ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Fri, May 15, 2009 at 10:00:41AM +0200, Jean Delvare wrote:
> On Fri, 15 May 2009 09:47:49 +0200, Hans de Goede wrote:
> > On 05/14/2009 11:24 AM, Andre Prendel wrote:
> >  > +		if(data->kind = TMP411_DEVICE_ID) {
> > 
> > This should be:
> > +		if(data->kind = tmp411) {
> > 
> > !!
> 
> This should actually be:
> 
> 		if (data->kind = tmp411) {
> 
> Something scripts/checkpatch.pl would have warned Andre about.

Sorry, I forgot to check the patch.

Andre

> 
> -- 
> Jean Delvare
> 
> _______________________________________________
> lm-sensors mailing list
> lm-sensors@lm-sensors.org
> http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

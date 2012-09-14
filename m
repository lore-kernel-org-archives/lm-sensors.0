From: Guenter Roeck <linux@roeck-us.net>
Date: Fri, 14 Sep 2012 13:45:51 +0000
Subject: Re: [lm-sensors] No such subfeature known when sensors -s
Message-Id: <20120914134551.GA12890@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <5051971B.7030608@iol.ie>
In-Reply-To: <5051971B.7030608@iol.ie>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Fri, Sep 14, 2012 at 01:56:40PM +0200, Jean Delvare wrote:
> Sorry I forgot to reply to the list last time, adding it back...
> 
> On Thu, 13 Sep 2012 15:07:30 +0100, MrNice wrote:
> > On 13/09/12 10:15, Jean Delvare wrote:
> > > On Thu, 13 Sep 2012 09:19:39 +0100, MrNice wrote:
> > >> Following the advice
> > >> http://lm-sensors.org/browser/lm-sensors/trunk/doc/fan-divisors
> > > This doesn't apply to the NCT6776. See in the output above, there is no
> > > "div =" on the fan lines.
> > >
> > > Maybe the document should be clarified.
> 
> I just did so [1], hopefully the updated document is clearer and users
> will understand whether they have to read it or not.
> 
> [1] http://www.lm-sensors.org/changeset/6071
> 
> > Do you know if is there any way to collect the right speeds as UEFI 
> > values are good.
> 
> No idea. Check the motherboard documentation. If the fans are really
> connected to the NCT6776, this may be a driver bug. BTW you said you're
> using the w83627ehf driver from groeck, but there is a better driver
> for the NCT6776 now:
>   https://github.com/groeck/nct6775
> Guenter, maybe this driver should be listed at
>   http://roeck-us.net/linux/drivers/
> so that users find it?
> 
Thought it did. I'll check (and remove the old one).

> If the new driver doesn't help, maybe the fans are connected to another
> monitoring chip.
> 
Some of the Intel motherboards use MEI to control the fans. Best way to
find out is to read the motherboard specification - it is usually mentioned
somewhere in there.

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

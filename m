From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 30 Jun 2009 08:17:40 +0000
Subject: Re: [lm-sensors] [PATCH v2 0/2] hwmon: Add support for TI's
Message-Id: <20090630101740.79cdebb8@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20090626081031.GA4510@ubuntu>
In-Reply-To: <20090626081031.GA4510@ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, 30 Jun 2009 10:12:20 +0200, Andre Prendel wrote:
> On Mon, Jun 29, 2009 at 06:48:29PM +0200, Jean Delvare wrote:
> > On Mon, 29 Jun 2009 10:54:10 +0200, Andre Prendel wrote:
> > > On Sun, Jun 28, 2009 at 02:25:51PM +0200, Jean Delvare wrote:
> > > > On Fri, 26 Jun 2009 10:10:31 +0200, Andre Prendel wrote:
> > > > > Hello Jean, Hans,
> > > > > 
> > > > > Here is an updated version of the tmp421 driver. I've fixed the issues
> > > > > according to your review. Please take a closer look at the
> > > > > is_visible() callback of the sysfs group. I'm using the attributes' index
> > > > > to decide whether the file is visible or not.
> > > > > 
> > > > > Jean, I know you're on vacation, so take your time :)
> > > > 
> > > > Now that the wiki is back, please update the TMP421 etc. entry.
> 
> Done.

Thanks. Care to add support to sensors-detect too?

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

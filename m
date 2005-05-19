From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:23:52 +0000
Subject: [PATCH-2.5] Fix w83781d sensor to use Milli-Volt for in_* in sysfs
Message-Id: <20030409074124.GA9813@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1049750163.4174.35.camel@nosferatu.lan> <20030407215443.GA4386@kroah.com> <1049775078.23992.2.camel@nosferatu.lan> <20030408220444.GA6674@kroah.com> <1049869101.2754.31.camel@workshop.saharact.lan>
In-Reply-To: <1049869101.2754.31.camel@workshop.saharact.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Martin Schlemmer <azarah@gentoo.org>
Cc: KML <linux-kernel@vger.kernel.org>, sensors@Stimpy.netroedge.com

On Wed, Apr 09, 2003 at 08:18:21AM +0200, Martin Schlemmer wrote:
> On Wed, 2003-04-09 at 00:04, Greg KH wrote:
> 
> > Oh, I'm getting the following warning when building the driver, want to
> > look into this?
> > 
> > drivers/i2c/chips/w83781d.c: In function `store_fan_div_reg':
> > drivers/i2c/chips/w83781d.c:715: warning: `old3' might be used uninitialized in this function
> >   
> 
> It is because old3 is only referenced if:
> 
>  ((data->type != w83781d) && data->type != as99127f)
> 
> as those two chips don't have extended divisor bits ...
> 
> It is however set in the first occurrence:
> 
> ---------------------------------------------------------------------
>        /* w83781d and as99127f don't have extended divisor bits */
>        if ((data->type != w83781d) && data->type != as99127f) {
>                old3 = w83781d_read_value(client, W83781D_REG_VBAT);
>        }
> ---------------------------------------------------------------------
> 
> and thus is rather gcc being brain dead for not being able to figure
> old3 is only used within a if block like that.
> 
> I was not sure about style policy in a case like this, so I left it as
> is, it should however be possible to 'fix' it with:

Thanks, I've applied this.

greg k-h

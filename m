From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 16 Sep 2009 19:07:35 +0000
Subject: Re: [lm-sensors] FW: PATCH: add sections for the new FTS chips to
Message-Id: <20090916210735.3463378b@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1C27BF3FB8EE3A4D8F901C22ADE1DE07CE9D65F6E0@ABGEX72E.FSC.NET>
In-Reply-To: <1C27BF3FB8EE3A4D8F901C22ADE1DE07CE9D65F6E0@ABGEX72E.FSC.NET>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Andre,

On Wed, 16 Sep 2009 20:45:06 +0200, Andre Prendel wrote:
> On Wed, Sep 16, 2009 at 10:18:53AM +0200, Cestonaro, Thilo wrote:
> > here is a patch which adds new sections to the sensors.conf.default.
> > The fts.conf can be used as a custom configuration in the wiki.
> > 
> > I was not able to create a new page, as described at the bottom of the page, cause no create button is there and I found no register button or such thing.
> > Could someone please add this custom configuration to the wiki as long as the patch is not included in the sources.
> 
> While doing this I realized that it isn't a motherboard specific
> configuration. It's just the chip configuration. On which motherboard
> one can find the chips?
> 
> Jean, sorry I did a typo creating the page. So we now have a second
> page named "Configurations/FujitsuSiemensTechnology" :(
> Can you please delete the page? It seems I don't have the permissions.

Done.

> 
> > btw. Fujitsu Siemens Computers GmbH is known as FUJITSU TECHNOLOGY SOLUTIONS GmbH since 1st April 2009.
> > and the webpage address has changed to http://ts.fujitsu.com/, perhaps someone can change this in the device wiki page.
> 
> I've updated the wiki but now we have a mismatch between the
> manufacturer and the driver name. Jean, any objections?

This is a frequent problem, not just when manufacturers change their
name, but also when chip divisions are sold from one manufacturer to
another (for example Analog Devices to ON Semi, recently). But it
doesn't really matter. Driver names are arbitrary anyway, and once we
have settled for a name, this is how people (and sensors-detect!) know
the driver and I'd rather not change it afterwards: that's more pain
than is worth.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

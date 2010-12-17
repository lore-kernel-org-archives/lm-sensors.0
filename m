From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Fri, 17 Dec 2010 22:28:11 +0000
Subject: Re: [lm-sensors] [Patch]Adding_threshold_support_to_coretemp
Message-Id: <20101217222811.GC13207@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <D6D887BA8C9DFF48B5233887EF04654105C117387C@bgsmsx502.gar.corp.intel.com>
In-Reply-To: <D6D887BA8C9DFF48B5233887EF04654105C117387C@bgsmsx502.gar.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Fri, Dec 17, 2010 at 04:56:39PM -0500, Jean Delvare wrote:
> On Fri, 17 Dec 2010 23:10:17 +0530, R, Durgadoss wrote:
> > > What is supposed to happen if this threshold is reached ? Does it mean "it is
> > > too cold",
> > > or does it mean "it is ok to turn off some of the cooling devices which were
> > > turned on earlier" ?
> > > 
> > > If it means "it is too cold", question is what the system is supposed to do
> > > about it.
> > > I am not sure if such a use would be of much value.
> > > 
> > > If it means "it is no longer too hot", the atribute name should really be
> > > temp1_max_threshold.
> > 
> > It means "it is no longer too hot". So, shall change the name to _max_threshold.
> 
> I'm fairly certain Guenter actually meant temp1_max_hyst, per
> Documentation/hwmon/sysfs-interface.
> 
Definitely yes ... I must have been low on coffee or something :(.
Thanks for correcting me.

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

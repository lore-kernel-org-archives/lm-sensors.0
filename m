From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Fri, 24 Dec 2010 03:09:43 +0000
Subject: Re: [lm-sensors] [PATCH v3] drivers/hwmon NTC Thermistor Initial
Message-Id: <20101224030943.GA30130@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1292842122-3992-1-git-send-email-myungjoo.ham@samsung.com>
In-Reply-To: <1292842122-3992-1-git-send-email-myungjoo.ham@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: lm-sensors@vger.kernel.org

On Thu, Dec 23, 2010 at 09:37:37PM -0500, 함명주 wrote:
> 
> Sender : Guenter Roeck<guenter.roeck@ericsson.com>
> > On Thu, Dec 23, 2010 at 08:36:04PM -0500, MyungJoo Ham wrote:
> > [ ... ]
> > > >> +int ntc_thermistor_read(struct device *dev)
> > > >> +{
> > > >> + ? ? ? return _ntc_thermistor_read(dev_get_drvdata(dev));
> > > >> +}
> > > >
> > > > Function should be removed since it is no longer exported.
> > > >
> > > 
> > > I have been considering to use this function at the board file in the
> > > kernel space.
> > 
> > That means you would have to export the function, and we are back to square one,
> > ie you really use a hwmon driver to provide functions to a non-hwmon driver.
> > 
> 
> Yes, this hwmon driver is used by another (board file) when CONFIG_HWMON and
> CONFIG_NTC_.... is "y". Otherwise, the code that requires hwmon driver is not
> compiled and a dummy is used instead. Thus, we don't need EXPORT anyway.
> 
Have you tried to compile the driver as module ?

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

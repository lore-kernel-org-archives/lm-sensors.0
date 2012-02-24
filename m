From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Fri, 24 Feb 2012 14:46:05 +0000
Subject: Re: [lm-sensors] Chip missing from the drivers list.
Message-Id: <20120224144605.GA14858@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1330089448.3270.9.camel@torre-enrique>
In-Reply-To: <1330089448.3270.9.camel@torre-enrique>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Fri, Feb 24, 2012 at 08:58:48AM -0500, Lee Burchett wrote:
> On 02/24/2012 08:17 AM, Enrique wrote:
> > Hello,
> >
> > my name is Enrique and after looking how to monitor the temperature of
> > the system in my computer with lm-sensors, it turn up that my chip
> > "Nuvoton W83677HG-I Super IO Sensors" is not supported yet.
> >
> > This mail is to make you know about this, and also that I'm up to help
> > with the testing.
> >
> > Best regards,
> >
> > Enrique.
> >
> >
> > _______________________________________________
> > lm-sensors mailing list
> > lm-sensors@lm-sensors.org
> > http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
> 
> Enrique,
> 
> I have the same chip in my system. Guenter helped me get it working. 
> Luckily, this chip is already supported in the latest version. If you 
> get Guenter's driver for the NCT6776F 
> (http://roeck-us.net/linux/drivers/) and pull the latest trunk of 
> lm-sensors from the repository, then you should be good to go. I did 
> have to add
> 
> w83627ehf
> 
> to my /etc/modules file. I'm not sure what distro you are using, but 
> that worked on Ubuntu x64 11.10 with the 3.0.0-16-generic kernel.
> 
It might not even be necessary to pull the latest driver. Support for NCT6775F/W83677HG-I
has been available since 2.6.39 (see http://www.lm-sensors.org/wiki/Devices).

Thanks,
Guenter


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

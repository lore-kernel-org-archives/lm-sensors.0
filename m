From: mds@paradyne.com (Mark Studebaker)
Date: Thu, 19 May 2005 06:24:21 +0000
Subject: i2c for Alpha
Message-Id: <3F9484A0.F04F940@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <200310121707.56799.jeff@jdfiles.org>
In-Reply-To: <200310121707.56799.jeff@jdfiles.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

'make -k' lets you keep building after an error which is easier than
editing Module.mk.


Jean Delvare wrote:
> 
> > > I suspect that you tried to update lm_sensors to 2.8.0 but did not
> > > update i2c to 2.8.0 preliminarily. Do that and it should work OK.
> > > You
> >
> > I built i2c outside the kernel using a package for my distribution.
> 
> Still it needs to be a version equal to or greater than the version of
> lm_sensors you are trying to install. Also, make sure that lm_sensors
> picks the right header files. If you have old i2c header files lying
> around in /usr/local/include or /use/include, you might want to wipe
> them out to make sure the newer ones are used.
> 
> > > might want to take a look at our installation guide at
> > > http://www.ensicaen.ismra.fr/~delvare/devel/i2c/ since installing
> > > i2c 2.8.0 is somewhat tricky.
> >
> > Is it still the case with 2.8.1, that you have to have the kernel
> > patch applied to build?
> 
> Yes, you have.
> I'm currently working on an i2c patch for submission into Linux 2.4.23
> so that lm_sensors will be easier to install, but for now you are
> advised to stick to the installation guide says.
> 
> That said, Philip Edelbrock's remark is absolutely right. Some, if not
> most, drivers of our package are useless on Alpha, so if a particular
> driver doesn't compile for some reason, and you know you won't need it,
> just remove it from Module.mk so that it isn't compiled at all.
> 
> --
> Jean Delvare
> http://www.ensicaen.ismra.fr/~delvare/

From: mds@paradyne.com (Mark Studebaker)
Date: Thu, 19 May 2005 06:23:40 +0000
Subject: ITE8707F (was Re: SiS)
Message-Id: <3DAC74E1.4D6DD753@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20021014202219.A28202@mercury.solarsys.net>
In-Reply-To: <20021014202219.A28202@mercury.solarsys.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org



"Mark M. Hoffman" wrote:
>
> Also, there was a question in all the quoted text that I am still
> interested in having answered:
> 
> > Right now, our driver is called i2c-sis645... I would like to change the
> > name to i2c-sis0016 at some point.  I need some guidance from the project
> > maintainers for how to do that without messing up all our users.
> 
>

I do not recommend renaming.

 - we lose all the CVS history
 - upgrading gets tricky - both old and new modules could be loaded, user confusion
 - names are fairly arbitrary anyway. look at our list of what's supported
   by the various modules, it's all over the place.

mds

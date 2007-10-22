From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 22 Oct 2007 07:48:21 +0000
Subject: Re: [lm-sensors] lm-sensors 3.0.0-rc1 has been released!
Message-Id: <20071022094821.3d0d935a@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20070925233316.7afaa297@hyperion.delvare>
In-Reply-To: <20070925233316.7afaa297@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Hans,

On Mon, 22 Oct 2007 09:06:27 +0200, Hans de Goede wrote:
> Jean Delvare wrote:
> > I'm interested in this because in openSuse, there's currently no
> > separate devel package for sensors. I plan to make one before moving to
> > 3.0.0, so I need to learn how this is supposed to work.
> 
> In general, anything not needed runtime goes in the -devel package, so thats 
> the .so symlink, static (.a) versions of the lib (if you want to have one at 
> all, Fedora has done away with static libs), headers, developer documentation 
> like section 3 manpages, and README's / FAQ's / whatever more geared towards 
> developers then users.

OK.

>                        You may also want to build sensorsd and put it in a 
> seperate sub-package.

That's my plan, yes. We do provide sensord but not in a separate
sub-package at the moment. Given that most users do not use sensord, I
don't think it makes sense to include it by default.

> Also you will need to create a package for the now seperated i2c tools. I still 
> need todo this too, you may use mine as a base once its there.

This is done already, I started with this right after releasing
i2c-tools 3.0.0.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

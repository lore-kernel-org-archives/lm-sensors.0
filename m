From: mds4@verizon.net (Mark Studebaker)
Date: Thu, 19 May 2005 06:24:31 +0000
Subject: lm_sensors 2.8.2 / DESTDIR / root
Message-Id: <3FE8C4B6.8070403@verizon.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <20031218214236.GA4787@s.chello.no>
In-Reply-To: <20031218214236.GA4787@s.chello.no>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

applied
thanks

Haakon Riiser wrote:
> The reason for this email is that I always try to avoid running
> Makefiles as root, even during 'make install'.  Therefore, I
> always use the DESTDIR feature, when it's available.  Until today,
> I always built i2c and lm_sensors by doing
> 
>   $ make
>   $ make -i install DESTDIR=/foo
>   $ cd /foo && su root && fix permissions/ownership && install
> 
> The -i flag to make install is a kludge to avoid having to be root
> while installing to the DESTDIR, and it's only required because
> the files are installed with "-o root -g root".  Using the -i
> flag is of course not a good idea, since more fatal errors can
> easily fly by undetected.
> 
> Today, I upgraded to Linux 2.6.0, and tried a similar install
> procedure for lm_sensors, except that the make target is now "user"
> and the install target is "user_install".  I now noticed that the
> DESTDIR variable is not used everywhere in "user_install", so I
> couldn't use the -i kludge anymore.  Instead, I wrote a patch that
> removes the "-o root -g root" arguments to install everywhere, and
> I also tried to add DESTDIR to all files/directories installed.
> (The patch only applies to lm_sensors, not i2c, since only
> lm_sensors is required in Linux 2.6.0.)
> 
> There's really no reason to say -o root -g root anyway, since if you
> do install directly with make install, you have to be logged in as
> root, and then the files will get the right ownership by default.
> Much of the point of installing to a temporary DESTDIR is that you
> don't have to be root, and that you can prepare the installation
> by hand.  Fixing the ownership is trivial:
> 
>   chown -R root.root $DESTDIR
> 
> That being said, here's the patch:

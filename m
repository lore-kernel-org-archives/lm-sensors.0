From: blues@ds6.pg.gda.pl (Blues)
Date: Thu, 19 May 2005 06:23:37 +0000
Subject: fixes to instalation process
Message-Id: <Pine.LNX.4.44L.0208042257110.29630-100000@piorun.ds.pg.gda.pl>
List-Id: <lm-sensors.vger.kernel.org>
References: <Pine.LNX.4.44L.0207232057370.30478-200000@piorun.ds.pg.gda.pl>
In-Reply-To: <Pine.LNX.4.44L.0207232057370.30478-200000@piorun.ds.pg.gda.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sat, 3 Aug 2002, Mark D. Studebaker wrote:
> thank you for the patch.
> I note that it simply adds "||true" to all the install lines.
> This will prevent 'make' from stopping on a real install failure.

yes, it's true.
And yes, this is very dirty patch :]

> Is there better way to allow non-root users to install without
> ignoring failures for root users?

well... maybe this:
- remove setting user and group from install command. put it in separate 
line as "chown ... || true". This will be good solution, I think.

> > This patch helps to make instalation in some DESTDIR on non-root user.
> > For example: when making rpm-package from non-privileged user. Options `-o
> > root` in install causes build to fail.
> > After all - there is some inconsequence in instalation process.
> > install-kernel uses MODDIR, install-kernel-busses and install-kernel-chips
> > uses MODPREF. This should be unified.

-- 
---------------------------------
pozdr.  Pawe? Go?aszewski        
---------------------------------
CPU not found - software emulation...

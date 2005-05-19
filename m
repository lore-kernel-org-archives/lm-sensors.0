From: spstarr@sh0n.net (Shawn Starr)
Date: Thu, 19 May 2005 06:23:45 +0000
Subject: 2.5.54 lm_sensors stuff
Message-Id: <200301111756.01346.spstarr@sh0n.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <200301100001.59064.spstarr@sh0n.net>
In-Reply-To: <200301100001.59064.spstarr@sh0n.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Here it is, but as I said, its a really bad hackup I would apply this on a 
separate tree not to break anything ;)

On Friday 10 January 2003 10:18 pm, Mark Studebaker wrote:
> great.
> please email your diffs to our list
> thanks
>
> Shawn Starr wrote:
> > I managed to get my sensors chip
> >
> > w83782d-i2c-0-2d
> > Adapter: SMBus AMD75x adapter at e4e0
> >
> > Working with 2.5.54 but its very ugly hacking and backports some minor
> > changes.
> >
> > the w83782d driver isn't in 2.5.54 (haven't checked .55 yet) but this
> > works with a few minor changes.
> >
> > Shawn.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+IKD/ePHb7Xli5GsRAmWOAKCLfxjEaB7pLhjlV88KI/EvhzKuTwCeOfhF
Y2llJ5KN/Iwbldc6+/Fbyog=yV39
-----END PGP SIGNATURE-----
-------------- next part --------------
A non-text attachment was scrubbed...
Name: lm-sensors-2.5.54.patch.diff
Type: text/x-diff
Size: 86424 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20030111/10013048/lm-sensors-2.5.54.patch.bin

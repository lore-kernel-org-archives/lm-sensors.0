From: BGardner@Wabtec.com (BGardner@Wabtec.com)
Date: Fri, 29 Jul 2005 20:10:46 +0000
Subject: [lm-sensors] LM93 driver for 2.6
Message-Id: <F06EB2894F3F0D45AD9BEA7246DE9C90E2471D@WCSEXCMBS1.ad.wabtec.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1121815671.1604.16.camel@wiz.dev.aspsys.com>
In-Reply-To: <1121815671.1604.16.camel@wiz.dev.aspsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

 
> > We will need the patch againts at least 2.6.13rc3
> 
> Is there a place where I can download the tarball of this kernel?  If
> not, what is the procedure for producing it?  Will I have to download,
> say, 2.6.12, and then apply all the various patch-2.6.13-rc[1-3]-git*
> patches, in order?  (Actually, there's an rc4 out now, it seems, so I
> could go to that if it's more advisable.)

Eric, 

Just thought I'd jump in on this one, because it wasn't at all obvious
to me how to do this & I'd like to spare you  the learning curve. =)

1) Install quilt on your system.
2) Download the latest non-rc release (linux-2.6.12.tar.bz2)
3) Download the 2.6.13-rcX patch (patch-2.6.13-rc3.bz2)
4) Download the 2.6.13-rcX-mmY patch (2.6.13-rc3-mm3.bz2)
5) untar the release (linux-2.6.12.tag.bz2) in your work folder, rename
it to something appropriate, say linux-2.6.13-rc3-mm3
6) import those patches into quilt and apply
 In your linux-2.6.13-rc3-mm3 folder, do this
 $ quilt import ~/downloads/patch-2.6.13-rc3.bz2
 $ quilt import ~/downloads/2.6.13-rc3-mm3.bz2
 $ quilt push -a

You now have the linux-2.6.13-rc3-mm3 tree.

If you haven't done so already, take the time to learn quilt.
Quilt has saved me many, many hours.

Ben


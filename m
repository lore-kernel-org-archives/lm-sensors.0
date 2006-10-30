From: Axel.Thimm@ATrpms.net (Axel Thimm)
Date: Mon, 30 Oct 2006 22:33:43 +0000
Subject: [lm-sensors] grafting lm-sensors 2.10.1 onto red hat kernel
Message-Id: <20061030223343.GE19783@neu.nirvana>
List-Id: <lm-sensors.vger.kernel.org>
References: <Pine.LNX.4.64.0610251056560.7544@snowball.fnal.gov>
In-Reply-To: <Pine.LNX.4.64.0610251056560.7544@snowball.fnal.gov>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, Oct 30, 2006 at 11:17:08AM -0600, Steven Timm wrote:
> On Wed, 25 Oct 2006, Jean Delvare wrote:
> 
> > Hi Steven,
> >
> > On Wed, 25 Oct 2006 10:59:20 -0500 (CDT), Steven Timm wrote:
> >>
> >> Has anyone successfully managed to compile i2c 2.10.1 and lm_sensors
> >> 2.10.1 so that they work with kernels such as "2.6.9-42.0.2.ELsmp" as
> >> distributed with Red Hat Enterprise Linux 4?
> >>
> >> For some of the 2.9 version of lm_sensors there used to be
> >> lm_sensors-kmdl and i2c-kmdl rpms available in the ATRPMS repository
> >> but now I do not see those anymore.  any hints are welcome.
> >
> > For 2.6 kernels, you don't need the separate module packages,
> > everything's already in the kernel tree. All you need is the user-space
> > part of lm_sensors, which is available from ATrpms:
> > http://atrpms.net/dist/el4/lm_sensors/
> >
> >
> 
> I guess what I am really trying to get at here is the following:
> If I just take the source code for the various modules I want
> from the lm_sensors 2.10.x tree and patch it into a 2.6.9 kernel,
> is it going to compile, or is the source code out there only
> good to compile into 2.4 kernels.
> 
> Has nobody ever tried to patch the latest lm_sensors code
> into a 2.6.9. enterprise kernel?  Under enterprise linux 3
> we used to do this all the time, I don't understand why
> nobody has tried to do it in Enterprise linux 4.

Of course, that happens from time to time by the distribution
vendor. I already posted a bugzilla entry of a previous kernel merge:

https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id1507

And if you look into the current src.rpm you'll find the patch to
2.6.9 of lm_sensors' code of that time.

What you really want is to notify RH about the need for updating this
patch against recent lm_sensors' code and hope to get it approved to
enter the next kernel errata. If you are in a hurry you don't need to
wait until RH's QA is done, usually the upcoming kernel rpms & patches
are released at J. Baron's redhat.com web space.
-- 
Axel.Thimm at ATrpms.net
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 189 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20061030/ab6805b3/attachment-0001.bin 

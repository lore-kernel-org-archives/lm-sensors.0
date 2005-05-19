From: decibel8@charter.net (David)
Date: Thu, 19 May 2005 06:24:00 +0000
Subject: 1250
Message-Id: <200306191644.00119.decibel8@charter.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <200306021011.37032.decibel8@charter.net>
In-Reply-To: <200306021011.37032.decibel8@charter.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Applied the patch, works this time!!!
 
Results:patch --verbose -p1 < /home/david/lm_sensors-2.7.0-sysctl-2.patch
Hmm...  Looks like a unified diff to me...
The text leading up to this was:
--------------------------
|--- lm_sensors-2.7.0/lib/proc.c        Sun Nov 10 15:13:38 2002
|+++ lm_sensors-2.7.0/lib/proc.c        Wed May 28 14:04:25 2003
--------------------------
Patching file lib/proc.c using Plan A...
Hunk #1 succeeded at 184.
Hmm...  Ignoring the trailing garbage.
done

1) Then I tar'd the package back up and put in my /usr/portage/distfiles.
Rebuilt the digest and emerged it again.  (Gentoo speak, easier to remove
if let portage handle the install.)

2)  Installed fine. Tried several things. Still get same error. I restarted lm_sensors
and rebooted. Still:
#sensors -s
via686a-isa-6000: Can't access /proc file for writing;
Run as root?

3) So still same problem. I remember Philip P. saying something about having
i2c source also. Since the patch is only applied against lm_sensors I don't think
that was necessary, maybe he was mentioning it just because he was installing the
whole ball of wax at once. I already had i2c installed so didn't reinstall. 

If you want me to do something else OR install with  'make', 'make install',..... instead
of letting Gentoo install it let me know.  

Let me know.

Dave



On Thursday 19 June 2003 02:34 am, you wrote:
> > > Some times ago, Philip Pokorny sent you a patch that could possibly
> > > solve your problem with lm_sensors. Did you try it? Did it work?
> >
> > No it didn't. I couldn't get the patch to work. He told me exactly
> > what to do after try several times myself to patch the source, with
> > errors. I got the same errors, so doesn't look like it was me. One of
> > the lines it was suppose to look for wasn't there. I grepped the
> > source files and I think a couple of the lines weren't there.
> > Looks like a bad patch.
> > I sent the patch to someone else and apparently they didn't have any
> > success either.
>
> I'd like you to try again. Attached is a modified version of the same
> patch that should apply. I tested it some minutes ago, and it does apply
> cleanly to lm_sensors-2.7.0. Go inside the directory where the
> lm_sensors sources reside and apply with "patch -p1 <
> /path/to/lm_sensors-2.7.0-sysctl-2.patch".
>
> We are planing to release a new version of lm_sensors in a few days and
> I'd like to know if your problem is still present or not.
>
> Thanks.

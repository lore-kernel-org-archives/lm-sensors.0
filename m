From: j.w.r.degoede@hhs.nl (Hans de Goede)
Date: Sun, 11 Mar 2007 19:23:25 +0000
Subject: [lm-sensors] libsensors patches
Message-Id: <45F4572D.6040801@hhs.nl>
List-Id: <lm-sensors.vger.kernel.org>
References: <20070311152104.bd092ff9.khali@linux-fr.org>
In-Reply-To: <20070311152104.bd092ff9.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org



Mark M. Hoffman wrote:
> Hi Hans:
> 

<discussion about 3.0 versus increments snipped>

> 
> I don't agree.  I think the sum of changes we are planning does warrant the
> move to 3.0.  It will be easier than the alternative, e.g.:
> 
> 	2.10.4 - drop support for 2.4.x proc file access
> 	2.10.5 - new API function
> 	2.10.6 - include command in config file
> 

Okay, first of all this is me with my lmsensors-contributers hat firmly 
off and my packager maintaining over a 100 packages in Fedora hat firmly on:

Lets try to split 2 things here, doing a 3.0 release to indicate some 
kinda milestone and breaking the ABI.

I've got nothing against putting some big changes (esp dropping 2.4 
support) in a 3.0 release. However unless it really is necessary I'm 
against breaking the ABI.

Adding a function does not break any old applications and thus is not a 
problem, most distributions work with repositories of packages, whereby 
new packages for a repo get build against other packages already in the 
same repo. Thus before any new package in such a repo can use the new 
API functions, libsensors must be updated first. Then applications may 
start using the new function after being (re)build against the repo with 
the new libsensors in it.

Normal users use some update tool which will automaticly install all new 
packages including the new libsensors + any apps needing the new version.

Now one can do so called piecemeal upgrades manually but that is asking 
for trouble and usually voids your support if any. One of the great 
successes of gtk2 actually is that every new release is ABI compatible 
with the old, so old apps stay working.

Also keep in mind that besides package-manager installed apps a user may 
also have manually installed apps. When the package manager then updates 
a library to a new not ABI compatible (and thus hopefully a different 
soname) version, these manually installed apps will break.

In short soname changes / ABI breakage cause both user and packager pain 
and inconvenience. Thus if it isn't really necessary / there is little 
gain, as with the by const reference versus by value change you propose, 
then you should not break the ABI and thus keep the soname.

Regards,

Hans







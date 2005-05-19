From: kmalkki@cc.hut.fi (=?ISO-8859-1?Q?Ky=F6sti_M=E4lkki?=)
Date: Thu, 19 May 2005 06:23:46 +0000
Subject: Which branch to work?
Message-Id: <Pine.OSF.4.50.0301170651370.16986-100000@kosh.hut.fi>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030116222611.C8619@earth.solarsys.net>
In-Reply-To: <20030116222611.C8619@earth.solarsys.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, 16 Jan 2003, Mark M. Hoffman wrote:
>
> I want to add some code to i2c-sis645.c to support the
> multiple recent requests we've had.  So let me make
> sure I understand how we want to do this...
>
> a) I should work from HEAD, and then merge my stuff
> back to the 2.4 branch, or
>
> b) I should work the 2.4 branch and merge it up to
> HEAD.

The last days I have ported 2.5.53-54 i2c changes back to CVS.
These changes will apply almost as-is to 2.4.x tree.

Currently we have not branched sensors CVS, nor have any reason to
do so. Feel free to work on the HEAD, and get the latest of i2c CVS if
you want 2.4 compatibility.

I try to tag both i2c and sensors, so that checking out both with tag
-kmXX will have chance of working.

See the last CVS log messages for more info about this.

-- 
  Ky?sti M?lkki
  kmalkki@cc.hut.fi

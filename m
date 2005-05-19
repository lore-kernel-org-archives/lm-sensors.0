From: mds@paradyne.com (Mark Studebaker)
Date: Thu, 19 May 2005 06:23:46 +0000
Subject: CVS cleanup status
Message-Id: <3E342E56.4090103@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <Pine.OSF.4.50.0301222332420.19858-100000@kosh.hut.fi>
In-Reply-To: <Pine.OSF.4.50.0301222332420.19858-100000@kosh.hut.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

i2c-voodoo3 is unusable right now, the PCI changes are half done,
please let me know if you have more changes pending, if not
I will attempt to fix and test, let me know.
thanks
mds


Ky?sti M?lkki wrote:
> I have used a postfix "-kmX" in both i2c and sensors CVS to tag which
> i2c and lm should work together. I have no HW to test these, I will
> not risk my desktop I have to do some real work with for this (any
> longer).
> 
> A problem using sysctls is that the adapter with a busy sensor sysctl is
> not refcounted, and could be removed on the fly. Might have been like
> that always, though. Fixing this may force us to add one more node in
> the sysctl path. I'll ask about this on LKML, but not before I have some
> feedback of the made changes.
> 
> You could run something like:
> 
>   cvs diff -u -r POST-2-4-9-KERNELS -r lk2-4-km2 > major-cleanup.diff
> 
> 

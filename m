From: khali@linux-fr.org (Jean Delvare)
Date: Wed, 03 Jan 2007 14:25:53 +0000
Subject: [lm-sensors] W83627DHG, steps to use
Message-Id: <20070103152553.68587901.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <200612271943.00165@goldspace.net>
In-Reply-To: <200612271943.00165@goldspace.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Rudolf,

On Tue, 02 Jan 2007 19:49:24 +0100, Rudolf Marek wrote:
> > It looks like there is some code in the kernel that could be extended
> > to provide MSR data for the coretemp driver--maybe you already know
> > about this?
> 
> My last incarnation of the driver uses the msr.c functions. I wrote to LKML
> about this but there was no result. The interface is bit unclean.
> 
> Jean,
> 
> Any ideas how to proceed with coretemp driver? Maybe best would be just to copy
> the routines to the driver and wait until some sane interface to msr appear?

That's a possibility, I admit I just don't know what is best, and I'm a
bit too busy with other stuff to think about it. I have large i2c core
patches on my plate at the moment, and I also need to push a few urgent
patches to Linus using git. Then we have the lm-sensors 2.10.2 release
scheduled. Only after it's done I will have some time to work on
individual drivers.

-- 
Jean Delvare


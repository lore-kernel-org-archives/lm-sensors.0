From: joden@lee.k12.nc.us (James Olin Oden)
Date: Thu, 19 May 2005 06:25:01 +0000
Subject: linking against libsensors
Message-Id: <Pine.LNX.4.58.0406171332011.1024@malachi.lee.k12.nc.us>
List-Id: <lm-sensors.vger.kernel.org>
References: <Pine.LNX.4.58.0406170815240.13125@malachi.lee.k12.nc.us>
In-Reply-To: <Pine.LNX.4.58.0406170815240.13125@malachi.lee.k12.nc.us>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, 17 Jun 2004, Mark M. Hoffman wrote:

> * James Olin Oden <joden@lee.k12.nc.us> [2004-06-17 08:20:07 -0400]:
> > created the link and my test programed linked fine.  My question is, is 
> > there away to tell the ld (or ld through gcc) to use a particular version 
> > of a .so (for instance I had a libsensors.so.1 and a libsensors.so.1.2.1)?
> 
> I don't think so - that would defeat one reason for using a shared library.
> If you want to nail down the exact library version at compile time, then pass
> the '-static' option to gcc/ld during the link stage.
>
Hmm.  Makes sense.  The only reason I started thinking down that road, was 
I was trying to figure out why the libsensors.so link did not exist, and I 
supposed (without checking the specfile of the rpm mind you) that it did
not exist because whoever build the rpm was trying to force you to at 
least specify verision 1 of the library.  I was probably thinking amiss.

Thanks...james 

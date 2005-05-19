From: joden@lee.k12.nc.us (James Olin Oden)
Date: Thu, 19 May 2005 06:25:01 +0000
Subject: linking against libsensors
Message-Id: <Pine.LNX.4.58.0406170815240.13125@malachi.lee.k12.nc.us>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi All,

I realize this is a real stupid question, but I was hopping that it would
also be an easy one for someone to answer.  I was trying write a simple 
program that uses libsensors, mainly to try to figure out how to use it,
and when I tried to link against libsensors (using -lsensors as the linker 
option), it would never be able to find the libsensors library.  I finally
figured out that I did not have a symlink /usr/lib/libsensors.so.  I 
created the link and my test programed linked fine.  My question is, is 
there away to tell the ld (or ld through gcc) to use a particular version 
of a .so (for instance I had a libsensors.so.1 and a libsensors.so.1.2.1)?

Thanks...james

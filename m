From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 19 Dec 2010 17:16:18 +0000
Subject: Re: [lm-sensors] Build warning in w83795.c
Message-Id: <20101219181618.2aba5306@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Guenter,

On Sun, 19 Dec 2010 08:57:34 -0800, Guenter Roeck wrote:
> On Sun, Dec 19, 2010 at 05:49:33AM -0500, Jean Delvare wrote:
> > Hi Guenter,
> > 
> > On Sat, 18 Dec 2010 20:40:55 -0800, Guenter Roeck wrote:
> > > per http://lkml.indiana.edu/hypermail/linux/kernel/1012.2/01156.html,
> > > the following build warning is seen in w83795.c for 2.6.37-rc6.
> > > 
> > > src/drivers/hwmon/w83795.c: warning: 'lsb' may be used uninitialized in this function: => 483
> > 
> > Hehe, this is the same loop that confused you when you reviewed the
> > driver ;) I don't get a warning here, using a fairly recent compiler
> > (4.5.0).
> > 
> Yes, I noticed.
> 
> Still not sure if it really confused me. I didn't find a clear definition of the scope
> of variables in C, but I am still not sure if you can "officially" re-use the value of 
> a function-local variable across loop iterations.

I don't know what the spec says. All I know is that I tried it with
sample code in user-space and it worked.

> > I believe that this is a false positive. The code is apparently too
> > tricky for older versions of gcc.
>
> Do we know which version of gcc was used for the compilation ?

I don't know which version the person on LKML was using, but I was able
to reproduce the warning with gcc 4.1.2.

> > Proposed workaround:
> > Subject: hwmon: (w83795) Silent false warning from gcc
> > 
> > The code triggers a false warning with older versions of gcc:
> > w83795.c: In function 'w83795_update_device':
> > w83795.c:475: warning: 'lsb' may be used uninitialized in this function
> > 
> > I admit that the code is a little tricky, but I see no way to write it
> > differently without hurting performance. So let's just silent the
> > warning with a needless initialization.
> > 
> Depends. Might also be good enough to just declare the variable at the beginning 
> of the function, ie extend its scope to be valis across multiple iterations of the loop.

No, I tried this first and it didn't work. I think gcc simply notices
that the code setting lsb is called conditionally, and isn't smart
enough to make sense of the actual conditions and see that this is OK.
The conditions are rather tricky, I admit, so I'm not exactly
surprised. And I don't know why the warning is gone with gcc 4.5.0,
because gcc is now smart enough to understand the conditions, or
because the whole thing was dropped because of the high number of false
positives.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

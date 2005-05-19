From: joden@lee.k12.nc.us (James Olin Oden)
Date: Thu, 19 May 2005 06:25:03 +0000
Subject: Return code of i2c transaction ignored in lm87
Message-Id: <Pine.LNX.4.58.0406281401570.12911@malachi.lee.k12.nc.us>
List-Id: <lm-sensors.vger.kernel.org>
References: <Pine.LNX.4.58.0406250822110.16214@malachi.lee.k12.nc.us>
In-Reply-To: <Pine.LNX.4.58.0406250822110.16214@malachi.lee.k12.nc.us>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sun, 27 Jun 2004, Jean Delvare wrote:

<snip> 
> With your method, the user application will be told that some of the
> values are wrong, but not which ones. So every value will have to be
> ignored. Second, every application will have to do it. I guess that the
> application will return the old value instead in this case, which means
> it'll have to remember it. All in all you want to do at the chip level
> in user-space what my method (as implemented in the w83l785ts driver)
> does at feature level in kernel-space, so it's finer grained and not
> every application has to handle it. Since our chip drivers already cache
> the old values, the amount of additional code needed is low.
> 
> Please take a look at what is done in w83l785ts and tell me why it
> woudln't solve you problem, if it actually doesn't.
> 
Just took a look, and that seems very reasonable.  If I did this in 
the LM87 driver would this be an acceptable patch?

I still would like some way of notifing user space of such an error, 
but if I had too, I could follow the syslog and get this (hackish, but
it would work).  OTOH, if I took the aproach of the w83l785ts (what a name 
(-;), but yet also added an error proc entry so that a user space app
could (if they choose) detect the error would this be a bad thing?

Thanks...james
> Thanks.
> 
> 

From: p5yke@optusnet.com.au (p5yke)
Date: Thu, 19 May 2005 06:24:54 +0000
Subject: LM99 support
Message-Id: <1082749445.2933.5.camel@c211-30-214-50.rivrw3.nsw.optusnet.com.au>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I have started 12 hour shifts this morning so it might be 4 days before
I have time to apply with this. I tried briefy. 

I dont know C and I have never patched before. Unfortunately I think I
know just enough to be dangerous! LOL

Is the command 'patch <linux-2.6.3-i2c-lm99.diff' in the chips
directory?? Do the Failed messages matter?

Scott

On Sat, 2004-04-24 at 04:24, Jean Delvare wrote:
> Hi Psyke,
> 
> Here are the relevant patches to add LM99 support to the lm90 kernel.
> There's one against 2.6.3 and one against 2.6.6-rc2, pick the one you
> prefer. If you prefer a patch against a different kernel, just tell me.
> 
> Let me know how it works for you! I will now be adding support to the
> user-space tools.
> 
> Thanks.

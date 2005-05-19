From: mds@paradyne.com (Mark D. Studebaker )
Date: Thu, 19 May 2005 06:24:03 +0000
Subject: mkpatch works
Message-Id: <3F05D9B1.7030909@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <3EF5B5CE.6050103@paradyne.com>
In-Reply-To: <3EF5B5CE.6050103@paradyne.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Thanks for testing.
Let's fix this the simplest way possible.
We'll continue to claim support for 2.4.9 but say that
if you are using mkpatch the minimum kernel is 2.4.13.

As far as SCx200, since mkpatch will render it unusable anyway
(due to struct changes) it's probably a good thing that
it get "unsupported" by mkpatch.

I'll update the docs.

Mark M. Hoffman wrote:
> * Jean Delvare <khali@linux-fr.org> [2003-06-26 15:28:31 +0200]:
> 
>>>The line which specifies CONFIG_I2C_PROC in i2c/mkpatch/Config.in is
>>>missing from the kernel file: drivers/i2c/Config.in.  Of course
>>>CONFIG_SENSORS depends on CONFIG_I2C_PROC so that's why I never saw
>>>it.  I'm not familiar w/ the guts of mkpatch - but I'll try to look at
>>>it unless someone else gets there first (hopefully... took a quick
>>>peek but I'm no Perl guru.)
>>
>>Oh, I didn't know mkpatch was written in Perl. Maybe I can help?
>>
> 
> 
> Recap: I tested mkpatch against linux 2.4.9 and found that CONFIG_I2C_PROC
> and therefore CONFIG_SENSORS (and all dependents) were missing from
> "make config".
> 
> Looks like CONFIG_I2C_PROC used to be patched into drivers/char/Config.in
> by i2c mkpatch, but that's commented out now.  Meanwhile, linux 2.4.13
> adds CONFIG_I2C_PROC to drivers/i2c/Config.in instead.
> 
> I think i2c mkpatch needs to be able to patch drivers/i2c/Config.in
> if we want to support linux 2.4.9.  I guess that the contents of
> i2c/mkpatch/Config.in would be suitable for this, except that it's
> missing some adapters that are present in later kernels. (1)
> 
> Or, declare minimum supported kernel >= 2.4.13 and this particular
> problem goes away.  I mean, 2.4.9 is almost *two years* old.  Probably
> if I didn't test this nobody would have ever noticed. ;)
> 
> Also, I'm soon on vacation... whatever is decided (if I'm to work on it)
> will wait until mid-July at least.
> 
> (1) That's actually a whole seperate problem: linux 2.4.21 has i2c code
> that we don't have in CVS - e.g. "NatSemi SCx200 I2C using GPIO pins".
> Should we bring that into CVS before the next release?  Otherwise
> mkpatch will "unsupport" it.
> 
> Regards,
> 

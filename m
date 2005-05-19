From: jerj@coplanar.net (Jeremy Jackson)
Date: Thu, 19 May 2005 06:25:20 +0000
Subject: getting 2.8.7 or better for 2.6 kernel?
Message-Id: <417D4036.1090108@coplanar.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <4178A7BD.9070607@coplanar.net>
In-Reply-To: <4178A7BD.9070607@coplanar.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I tried the patch with a Dell Optiplex GX110.  The module loads, finds a 
device at 0x09, but says it's "not activated".  What do you need to 
debug this problem?

Regards,

Jeremy

Jean Delvare wrote:
> Hi Jeremy,
> 
> 
>>I wish to try the pc87364 with 2.6 kernel.  The downloads page indicates
>> that the patches must not be used with 2.6, and that development is in
>>the kernel tree.  I don't see any mention of that driver in change logs
>>for kernel 2.6.9, or -bk? so i seem to have hit a dead end.
>>
>>Any pointers would be appreciated.
> 
> 
> You're of the lucky kind, aren't you? One week ago I'd have told you
> to wait, possibly for a long time, unless someone would port the driver
> to 2.6.
> 
> However I just ported the driver yesterday, after Wincor-Nixdorf Germany
> requested me to do so in exchange of some hardware I wanted. I guess you
> can thank them as I do :) You can pick the patch here:
> http://khali.linux-fr.org/devel/i2c/linux-2.6/linux-2.6.8-i2c-pc87360-alpha1.diff
> Note that it is totally untested since I do not own a compatible chip
> myself. The patch should apply and compile on almost any 2.6.8+ kernel
> tree.
> 
> If you give it a try, please let me know how it works for you and report
> any problem you encounter, so that I can fix theses.
> 
> Thanks,
> Jean Delvare


-- 
Jeremy Jackson
Coplanar Networks
(519)897-1516
http://www.coplanar.net

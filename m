From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:52 +0000
Subject: [PATCH] ds1337 4/4
Message-Id: <20050418195252.0e6b351e.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050407231904.GE27226@orphique>
In-Reply-To: <20050407231904.GE27226@orphique>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Ladislav, hi James,

> > Attached are two ds1337 patches for your comment. For convenience,
> > I've  also included the ppc7d rtc patch that is already in queue.
> > 
> > ds1337-api.patch  - fixes the call to ds1337_do_command() to pass
> >                     bus/addr rather than a magic "id".
> 
> I'm afraid, it wouldn't be right to comment this patch, since my
> knowledge of design and future development of i2c subsystem is rather
> limited. Jean? I'd also like to learn the right way, so I could write
> proper support for SGI O2 I2C adapter...

ds1337_do_command() is not related with i2c-core in anyway, so I am not
authoritative here. That being said, I do like the patch as I think it
makes much sense.

I'd be happy to apply this patch on top of my stack, unfortunately it
conflicts with previous cleanups from Ladislav.

James, could you please provide a patch which would apply properly on
top of my stack? You can get it from here:
  http://khali.linux-fr.org/devel/i2c/linux-2.6/
In particular you'll find the 3 patches I have for the ds1337 driver
already.

Please do not forget to comment and sign patches when you send them, so
that they can be accepted.

> Yes, that's it! :) Thanks a lot. You might want generate your patch
> against ds1337 patches 1-3, otherwise someone would have to apply it
> manually. To save you some work, patch is attached. Also sorry it took
> me so long to reply, I was off work...
> 
> (...)

I think I understand that this part is only one half of the complete
patch. We can only apply complete patches, obviously. One of you please
send such a patch with comment and signed-off-by line.

Thank to both of you for the cleanups to this driver, BTW, these were
needed.

-- 
Jean Delvare

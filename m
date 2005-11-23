From: khali@linux-fr.org (Jean Delvare)
Date: Wed, 23 Nov 2005 22:28:26 +0000
Subject: [lm-sensors] [PATCH] Support for Barco LTP->DVI parport I2C
Message-Id: <20051123222910.107c1bee.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <87oe4d4uit.fsf@48ers.dk>
In-Reply-To: <87oe4d4uit.fsf@48ers.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Peter,

>  Jean> Is there any reason why someone outside of Barco would use that
>  Jean> interface and driver?
> 
> Realistically no. I could provide the schematics and someone could
> make their own prints, but as all of the parport boards are pretty
> much the same anyway, it doesn't really have any advantages compared
> to the one in Documentation/i2c/busses/i2c-parport.
> 
> The reason why I would like it included is simply that it doesn't
> harm anyone and it would make it easier for us since it's used by
> several people - some without much Linux mojo, so having it in the
> mainline kernel would be nice instead of having to patch the kernels.

OK, fair enough, I was thinking quite the same. The overhead is indeed
so thin it's not even worth arguing about.

>  Jean> May I have a Barco device for free, just to test the driver? :)
>  Jean> Just kidding...
> 
> I'll see what I can do..

Come on, I was *really* kidding :) You don't even need to try and
corrupt me, your patch is already accepted as far as I am concerned.

Thanks,
-- 
Jean Delvare

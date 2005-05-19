From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:23:51 +0000
Subject: Cannot have lm-sensors work with my NV7m ABIT motherboard
Message-Id: <20030324093634.59a23e6f.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <1048326224.4015.63.camel@Ordiyann>
In-Reply-To: <1048326224.4015.63.camel@Ordiyann>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> I followed your idea. Here's the list of all the modules loaded on my
> computer, after removing everything related to bttv and so on... I
> think I haven't forgotten anything:

Actually, my idea was not to remove them, but to never load them. I
suspect that one of these modules could generate the problem when being
loaded, which hardly implies it would clean up when being unloaded.

> dsbr100                 5176   1
> videodev                7872   2  [dsbr100]

And I believe you should not load these two ones too.

> If you can help... I really don't understand why I always get lm75 and
> lm80, and all the other chips...

As said earlier, the bus is going mad, it detects hundreds of things you
don't have. If we could find out why, then we could investigate. So I
suggest you prevent the modules from loading (rename them of something)
and then restart you system (I hope you can) to see what happens then.
And I really like to know what Mark thinks about it, I may be missing
something.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/

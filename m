From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 23 Nov 2009 09:00:17 +0000
Subject: Re: [lm-sensors] pwmconfig can only control fan speed at beginning
Message-Id: <20091123100017.7a854b2e@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <39eba8470911210719l17f35e2eoeda973ab0724130b@mail.gmail.com>
In-Reply-To: <39eba8470911210719l17f35e2eoeda973ab0724130b@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Allen,

On Sun, 22 Nov 2009 13:47:24 -0800, Allen Edwards wrote:
> With your help all is working and the fan noise cannot be heard from across
> the room.  The "make clean" did the trick.  Thanks so much for your help.
> 
> I have a small follow-up question.  I searched for a long time looking for
> how to start fancontrol automatically.  All I found was a rather elaborate
> script here: http://ubuntuforums.org/showthread.php?tB737 but it looked
> old (2005) and the paths didn't look correct so I didn't use it.

It is your distribution's responsibility to provide an initialization
script for the fancontrol service. On openSUSE this is included in the
lm_sensors service. But maybe some distributions think fancontrol is
not good enough to deserve it (and I can't blame them.)

> I put a line in my rc.local file "/usr/local/sbin/fancontrol" and all seems
> well.
> 
> Is this acceptable?

Yes it is, even though I would be a little more cautious:

if [ -x /usr/local/sbin/fancontrol -a -r /etc/fancontrol ]
then
	/usr/local/sbin/fancontrol
fi

-- 
Jean Delvare
http://khali.linux-fr.org/wishlist.html

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

From: Jean Delvare <khali@linux-fr.org>
Date: Sat, 11 Jun 2011 14:10:19 +0000
Subject: Re: [lm-sensors] WPCD374L question
Message-Id: <20110611161019.510b84eb@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <4DDD468B.2060106@flexstar.com>
In-Reply-To: <4DDD468B.2060106@flexstar.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Carl,

On Wed, 25 May 2011 12:12:27 -0600, Carl Morris wrote:
> All,
> 	Just joined the list, I'm writing because the wiki/Devices
> page specifically asked me to contact lm-sensors if I was using the WPCD374L
> (replaced PC8374L according to Winbond) chip.  I searched the archives for
> info on how to monitor data from this chip and found one thread from a
> couple of years ago asking for info when using the latest version of
> sensors-detect.
> 
> I get the "Found 'Nat. Semi. PC8374L Super IO Sensors' (but not activated)"
> message, but nothing else that seems to be related.  And of course, I
> can't seem to get any data from it when I run /usr/bin/sensors.
> 
> I'm new to all this and pretty clueless about Linux in general (I'm an
> embedded FW for storage guy), but if anybody has any clues or wants
> any info from me as implied by the wiki/Devices page let me know.

I would be the one who posted the call for contact. Meanwhile, looking
at ticket:
  http://www.lm-sensors.org/ticket/2182
it seems that everything is solved, both in sensors-detect and in the
lm85 driver, so the call should be cleared. I've just done that.

As far as your system is concerned, I can't say anything without the
complete output of (a recent version of) sensors-detect. Maybe your
system simply doesn't implement hardware monitoring, or it has a not
yet supported device.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

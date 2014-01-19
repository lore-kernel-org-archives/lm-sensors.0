From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 19 Jan 2014 13:51:59 +0000
Subject: Re: [lm-sensors] Some questions from first user
Message-Id: <20140119145159.4d75cd31@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <CADR1r6jbaekgXZTJQ7n+5MJW13miQdtbGG=KimEqTT8t2BDKLg@mail.gmail.com>
In-Reply-To: <CADR1r6jbaekgXZTJQ7n+5MJW13miQdtbGG=KimEqTT8t2BDKLg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Martin,

On Sun, 19 Jan 2014 14:32:37 +0100, Martin Herrman wrote:
> However, it doesn't reset values to the BIOS settings (I guess it
> cannot retrieve the BIOS settings). So when removing a setting in
> sensors.conf and using the init script, will not reset the removed
> setting to BIOS value.

Indeed BIOS values aren't stored anywhere so the only way to go back to
them is to cold boot the machine.

> (...)
> I can explain negative values: BIOS sets offset to 72, so when set to
> 10 it will decrease by 62 instead of adding 10 :-)

72 is an unusually high offset. It might have to do with PECI sensor
type where values are reported relatively to a limit. Different
monitoring chips handle this case differently.

> (...)
> I believe that I have a configuration file that is worth to be put on
> the trac/wiki. Just one issue.. where can I register for trac access?

You can't, we have disabled user self-registration due to the high
amount of spam. Just send your file to the list and I'll add it to the
wiki myself.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

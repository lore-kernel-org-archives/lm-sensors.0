From: r.marek@sh.cvut.cz (Rudolf Marek)
Date: Sun, 14 May 2006 20:55:54 +0000
Subject: [lm-sensors] W83627EHF driver enhancements
Message-Id: <4467995A.9090905@sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <442ED616.4070109@sh.cvut.cz>
In-Reply-To: <442ED616.4070109@sh.cvut.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi all

> Trying to build against 2.6.16.16, I ran into undefined references to
> SENSOR_ATTR arrays. After a quick search it looks like it was introduced
> little time ago.

> Do I need to upgrade to 2.6.17-rc4 or is there another separate patch to
> apply ?

upgrade to this kernel version plus use supplied w83627ehf.c

It should work with that - but David fixed one of the patches by hand and it is
malformed now. I will post tomorrow bigger patch putting together what we have
until now.

David, do you have somewhere the speed cruise mode or we postpone it to later?
I went through your patches and they look good to me, I just fixed a codingstyle
on some place plus I want to verify some of your changes, I will do that tomorrow.

plan:

1) I will merge yours patches to one bigger (tomorrow)
2) I have fixed the sysfs docs and I post them (tomorrow)
3) I still think that check for fan4 and fan5 is not sufficient.
   see page 94 (printed) in datasheet, the pin 119 can be GPIO,
   similar for other fan which is shared with serial flash interface,
   but it seems the datasheet is not sharing with us the pin control.

PI) speed cruise mode patch ?
4) cleanup patch for whole file
5) docs update reflecting the fan control (got some notes about the files)

Personally I think we can wait with fanspeed cruise a bit and concentrate to
finish our stuff...


Regards
Rudolf


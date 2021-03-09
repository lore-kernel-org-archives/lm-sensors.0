From: riveravaldez <riveravaldezmail@gmail.com>
Date: Tue, 09 Mar 2021 07:39:03 +0000
Subject: Was `sensors` causing a lag in input devices?
Message-Id: <CAD8U+g97zbF3uwGLkbxT4Gp-MtffV4bZzSUZ_Hixe5LUC-AvNQ@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi, I'm not subscribed to the list, and sorry in advance if this is not the
place to ask.

On an updated Arch system in a Dell XPS L502X laptop I was having
an issue that started after kernel 5.7.12 and disappeared (so far at
least) with kernel 5.11.2 (but maybe it disappeared a little before).

Calling `sensors` from terminal caused an interruption in the
keyboard/mouse reception, and even some glitches on audio.
If running `psensor` - which calls `sensors` every 2 seconds in its
default setting - system became unusable, because mouse and
keyboard stopped responding with that frequency.

Right now the issue is not present anymore, but it would be good I
suppose to confirm which was its origin.

When the issue first appeared I reported it in the Arch forums for
assistance, so, there's the logs and hardware info I was able to
collect trying to diagnose this:

https://bbs.archlinux.org/viewtopic.php?id%9414

Let me know if I can do something useful about this,

and thanks a lot in advance.

Kind regards!

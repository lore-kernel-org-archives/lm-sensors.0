From: j.ellerbroek@student.tudelft.nl (Joost Ellerbroek)
Date: Thu, 19 May 2005 06:24:17 +0000
Subject: problem with it87.o
Message-Id: <200309221205.47962.j.ellerbroek@student.tudelft.nl>
List-Id: <lm-sensors.vger.kernel.org>
References: <200308161353.53028.j.ellerbroek@student.tudelft.nl>
In-Reply-To: <200308161353.53028.j.ellerbroek@student.tudelft.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

here are the files you requested (before and after loading it87.o)
hope they're of some help.

On Saturday 20 September 2003 19:03, you wrote:
> > Thanks for replying, and don't worry about how long it took you, I'm
> > in no hurry. In fact, I've replaced the case fan with a very silent
> > 220V fan, which means I haven't got a problem with the sensors driver
> > anymore. Should you want the information anyway to improve the modules
> > or something like that just let me know, i'd gladly test it for you
> > since you've been so helpful.
>
> Yes, I'd appreciate if you could test. Maybe we could tweak our
> initialization procedure, or provide an additional module parameter, in
> order to prevent the problem you encountered.
>
> > On Saturday 20 September 2003 10:56, you wrote:
> > > > I still haven't been able to resolve my problem with the fan
> > > > spinup, you asked for the value in 'alarms':
> > > >
> > > > cat /proc/sys/dev/sensors/it87-i2c-1-2d/alarms returns:
> > > > 26130
> > > >
> > > > Do you think this problem can be resolved by means of a specific
> > > > config, or is it really a driver problem?
> > >
> > > First, I'd like to apologize for the slow answer. I've been very
> > > busy these days (moved in to a new place for a new job). If you're
> > > still interested in solving your fan problem, here we go.
> > >
> > > It looks like one of the steps taken by the it87 module while
> > > initializing your chipset doesnt please it. We simply have to find
> > > out which one. For that, we'd need to see the configuration
> > > register(s) state(s) before the module is loaded (which means the
> > > module should not be loaded automatically at boot time).
> > >
> > > Run the following command (as root) before loading the module:
> > > i2cdump 1 0x2d b > ~/it87-before-init.out
> > >
> > > Then, load the module, then unload it, and run the command again:
> > > i2cdump 1 0x2d b > ~/it87-after-init.out
> > >
> > > And send us the two files so that we can analyze them.
-------------- next part --------------
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
00: 11 16 66 00 00 00 00 00 00 00 08 09 16 7d ff ff    ??f.......???}..
10: e1 e1 e1 70 00 00 00 00 16 16 16 16 16 16 16 16    ???p....????????
20: 67 5e d2 be b4 33 68 be ff 2c 2e 2b 16 16 16 16    g^???3h?.,.+????
30: 75 60 ac 8d 71 5d cc a8 d8 b2 72 5e 3d 33 cc a8    u`??q]????r^=3??
40: 3c 14 3c 14 3c 14 ff ff 2d ff ff ff ff ff ff ff    <?<?<?..-.......
50: ff 38 7f 7f 7f ff ff ff 90 56 fd 12 00 00 00 00    .8???...?V??....
60: 7f 7f 7f 7f 7f 00 00 00 7f 7f 7f 7f 7f 00 00 00    ?????...?????...
70: 7f 7f 7f 7f 00 00 00 00 ff ff ff ff ff ff ff ff    ????............
80: 11 16 66 00 00 00 00 00 00 00 08 09 16 7c ff ff    ??f.......???|..
90: e1 e1 e1 70 00 00 00 00 16 16 16 16 16 16 16 16    ???p....????????
a0: 67 5e d2 bf b4 33 69 bf ff 2c 2e 2b 16 16 16 16    g^???3i?.,.+????
b0: 75 60 ac 8d 71 5d cc a8 d8 b2 72 5e 3d 33 cc a8    u`??q]????r^=3??
c0: 3c 14 3c 14 3c 14 ff ff 2d ff ff ff ff ff ff ff    <?<?<?..-.......
d0: ff 38 7f 7f 7f ff ff ff 90 56 fd 12 00 00 00 00    .8???...?V??....
e0: 7f 7f 7f 7f 7f 00 00 00 7f 7f 7f 7f 7f 00 00 00    ?????...?????...
f0: 7f 7f 7f 7f 00 00 00 00 ff ff ff ff ff ff ff ff    ????............
-------------- next part --------------
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
00: 11 16 76 00 00 00 00 00 00 00 08 5b 16 20 ff ff    ??v.......?[? ..
10: e1 e1 e1 74 d7 00 00 81 16 16 16 16 16 16 16 16    ???t?..?????????
20: 67 5e d2 be b4 34 69 be ff 2c 2f 2b 16 16 16 16    g^???4i?.,/+????
30: 75 60 ac 8d 71 5d cc a8 d8 b2 72 5e 3d 33 cc a8    u`??q]????r^=3??
40: 3c 14 3c 14 3c 14 ff ff 2d ff ff ff ff ff ff ff    <?<?<?..-.......
50: ff 38 7f 74 d7 ff ff ff 90 5d fd 12 80 00 00 00    .8?t?...?]???...
60: 7f 7f 7f 7f 7f 00 00 00 7f 7f 7f 7f 7f 00 00 00    ?????...?????...
70: 10 10 30 36 3a 03 04 09 ff ff ff ff ff ff ff ff    ??06:???........
80: 11 16 66 00 00 00 00 00 00 00 08 5b 16 1f ff ff    ??f.......?[??..
90: e1 e1 e1 74 d7 00 00 81 16 16 16 16 16 16 16 16    ???t?..?????????
a0: 67 5e d2 c0 b3 33 69 bf ff 2b 2f 2b 16 16 16 16    g^???3i?.+/+????
b0: 75 60 ac 8d 71 5d cc a8 d8 b2 72 5e 3d 33 cc a8    u`??q]????r^=3??
c0: 3c 14 3c 14 3c 14 ff ff 2d ff ff ff ff ff ff ff    <?<?<?..-.......
d0: ff 38 7f 74 d7 ff ff ff 90 5d fd 12 80 00 00 00    .8?t?...?]???...
e0: 7f 7f 7f 7f 7f 00 00 00 7f 7f 7f 7f 7f 00 00 00    ?????...?????...
f0: 10 10 30 36 3a 03 04 09 ff ff ff ff ff ff ff ff    ??06:???........

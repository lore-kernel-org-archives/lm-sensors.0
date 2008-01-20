From: "Juerg Haefliger" <juergh@gmail.com>
Date: Sun, 20 Jan 2008 22:15:07 +0000
Subject: Re: [lm-sensors] SMSC Super I/O: unknown chip with ID 0x8902
Message-Id: <191fb4ca0801201415m4e93034bw220488380a02d27e@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <004e01c856bc$6f975c10$0204a8c0@IT>
In-Reply-To: <004e01c856bc$6f975c10$0204a8c0@IT>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean,


On Jan 19, 2008 4:00 PM, Jean Delvare <khali@linux-fr.org> wrote:
> Hi Juerg,
>
> On Fri, 18 Jan 2008 16:08:00 +0100, Juerg Haefliger wrote:
> > Again, I'll take a look at the datasheets and if the chips are indeed
> > compatible, I'll fix the dme1737 driver to support the sch5027. I
> > don't have access to a test machine until next week, so it has to wait
> > until then.
>
> You may be interested in the following recipe then:
>
> * Have Andrew send you a dump of his chip:
>   i2cdump 0 0x2e b > sch5027.dump
>
> * Download and run my i2c-stub-from-dump script on it:
>   http://www.lm-sensors.org/browser/i2c-tools/trunk/stub/i2c-stub-from-dump
>
>   Syntax:
>   i2c-stub-from-dump 0x2e sch5027.dump
>   You'll need the "i2c-stub" kernel driver and the "i2cset" helper.
>
> Then you have an emulated chip to play with. It should let you test things
> like device detection, value register reads, etc.
>
> It's always better to have a real device of course, but I still find
> i2c-stub very helpful when I need to touch drivers for SMBus devices I
> don't own.

Very good! I'll give it a try, sounds very useful.

...juerg



> --
> Jean Delvare
>

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

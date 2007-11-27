From: "Joseph L. Casale" <jcasale@ActiveNetwerx.com>
Date: Tue, 27 Nov 2007 00:46:45 +0000
Subject: Re: [lm-sensors] Beginner Question
Message-Id: <1C8CF1EA1A5B5940B81B0710B2A4C93823D5A5C64D@an-ex.ActiveNetwerx.int>
List-Id: <lm-sensors.vger.kernel.org>
References: <1C8CF1EA1A5B5940B81B0710B2A4C93823D5A5C63E@an-ex.ActiveNetwerx.int>
In-Reply-To: <1C8CF1EA1A5B5940B81B0710B2A4C93823D5A5C63E@an-ex.ActiveNetwerx.int>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

David,

-----Original Message-----
From: David Hubbard [mailto:david.c.hubbard@gmail.com]
Sent: Monday, November 26, 2007 12:01 AM
To: Joseph L. Casale; lm-sensors@lm-sensors.org
Subject: Re: [lm-sensors] Beginner Question

Hi Joseph,

> Hello Everyone,
>  Forgive the beginner question, as I also have limited experience in Linux
> as well. I have a VMware esx server running 2.4.21-47.0.1.ELvmnix kernel. I
> cannot recompile this kernel and add driver support to it. I suspect from
> reading so far that this prevents me from running lm-sensors?
>
>
>
> If not, can someone point me to some documentation that might help me get
> started with this kernel version or suggest a alternative approach? I really
> need to monitor a series of fan speeds on an Asus P5B-VM motherboard.
>
>
>
> Thank you,
>  jlc

I believe what you want to do is possible. You will need to figure out
if it really is possible to run a guest OS and grant it access to the
non-virtualized hardware. Then you can compile a guest OS with hwmon
support and monitor the fan speeds. That kind of question is something
I cannot answer for you. I suggest you join the gentoo forums and ask
there (http://forums.gentoo.org) because they are responsive and
helpful. You will still need to be persistent and patient (and as
clear as possible). If you know of another forum you would rather use,
by all means go ahead.

From my understanding, VMware is very capable and should be able to
pass through I/O accesses to the "raw hardware". The overhead will be
significant, but hwmon is not latency or bandwidth limited, so you
should be fine.

Perhaps, when you find an answer, if you would post a summary here,
that would be appreciated.

Good luck,
David
-----End Original Message-----

As powerful as VMware is, it won't allow access to the host's hardware in this manner. So if I glean correctly, there does not exist a method without compiling in drivers currently?

Thanks,
jlc

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

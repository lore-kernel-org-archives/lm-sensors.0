From: "David Hubbard" <david.c.hubbard@gmail.com>
Date: Tue, 27 Nov 2007 05:20:40 +0000
Subject: Re: [lm-sensors] Beginner Question
Message-Id: <4dfa50520711262120u48783bd2m42c00b2decfc4bed@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1C8CF1EA1A5B5940B81B0710B2A4C93823D5A5C63E@an-ex.ActiveNetwerx.int>
In-Reply-To: <1C8CF1EA1A5B5940B81B0710B2A4C93823D5A5C63E@an-ex.ActiveNetwerx.int>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Joseph,

> I believe what you want to do is possible. You will need to figure out
> if it really is possible to run a guest OS and grant it access to the
> non-virtualized hardware. Then you can compile a guest OS with hwmon
> support and monitor the fan speeds. That kind of question is something
> I cannot answer for you. I suggest you join the gentoo forums and ask
> there (http://forums.gentoo.org) because they are responsive and
> helpful. You will still need to be persistent and patient (and as
> clear as possible). If you know of another forum you would rather use,
> by all means go ahead.
>
> From my understanding, VMware is very capable and should be able to
> pass through I/O accesses to the "raw hardware". The overhead will be
> significant, but hwmon is not latency or bandwidth limited, so you
> should be fine.
>
> Perhaps, when you find an answer, if you would post a summary here,
> that would be appreciated.
>
> Good luck,
> David
> -----End Original Message-----
>
> As powerful as VMware is, it won't allow access to the host's hardware in this manner. So if I glean correctly, there does not exist a method without compiling in drivers currently?

Well, I am surprised that VMware doesn't support it. But you are
right: if the hwmon driver can't access the hardware, you should look
at ACPI and see if there is any useful information there.

David

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

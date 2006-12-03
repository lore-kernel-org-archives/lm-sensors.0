From: udovdh@xs4all.nl (Udo van den Heuvel)
Date: Sun, 03 Dec 2006 14:34:55 +0000
Subject: [lm-sensors] new vt1211 driver: Can't access procfs/sysfs file
Message-Id: <4572E08F.2000005@xs4all.nl>
List-Id: <lm-sensors.vger.kernel.org>
References: <45728865.5020308@xs4all.nl>
In-Reply-To: <45728865.5020308@xs4all.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean Delvare wrote:
>> The Tsss could show a lack of something.
>> You are moving way off the focus of this quest which is very clear.
> 
> It looks like you are missing a very important point here. You are the
> one asking for help. I am the one providing the help FOR FREE, on my
> SPARE TIME. The least you can do is make it easy for me, provide
> correct answers to my questions, and assist as much as you can, instead
> of waiting for me to do all the work based on incomplete information.

Sure. I agree completely.
On the other hand you can be sure that in most sensors.conf there will
be ignore statemnts so that the abuser is not overwhelmed with sensors
giving nonsense values.
The sensors that /made/ sense had no ignore statments in my config.
Of coure I was not so clear.

> point I still don't know what was that system. 2.4 kernel? Or 2.6 with
> Lars Ekman's unofficial driver?

2.6 on FC6 with Lars' driver (and various changes in the recent past).

> Why did you upgrade your system if it was working?

To keep up. It is routine. Vt1211 would be one of the reasons to
actually gain something. `Official` support. No more patching to make
things work.

> (Seriously, if you're not happy with what we do, feel tree to join the
> development team and show us how to make things better. I'm eager to
> improve. There's plenty of work for everyone interested.)

lm-sensors was not the cause. it was the new driver and associated
expectations ('drop-in replacement')

>> Where can I find the very simple knowledge to build new compute
>> statments, my only interesting hobby?

[..]

> Most probably, you don't actually
> need to change the formula, just replace "compute temp3" by "compute
> temp1".

Done.


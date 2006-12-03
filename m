From: khali@linux-fr.org (Jean Delvare)
Date: Sun, 03 Dec 2006 13:42:06 +0000
Subject: [lm-sensors] new vt1211 driver: Can't access procfs/sysfs file
Message-Id: <20061203144206.2dd5d26d.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <45728865.5020308@xs4all.nl>
In-Reply-To: <45728865.5020308@xs4all.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Udo,

On Sun, 03 Dec 2006 13:33:59 +0100, Udo van den Heuvel wrote:
> Jean Delvare wrote:
> > On Sun, 03 Dec 2006 12:13:50 +0100, Udo van den Heuvel wrote:
> >> Jean Delvare wrote:
> >>> are ignore statements for them in your configuration file. 
> >> Sure. But not for the temperatures.
> >> (...)
> >> chip "vt1211-*" "vt8231-*"
> >> #
> >> #
> >> #ignore in6
> >> #set config 12
> >> ignore in0
> >> ignore in1
> >> ignore temp1
> >> ignore temp2
> >> ignore temp4
> >> ignore temp5
> >> ignore temp6
> >> ignore temp7
> > 
> > "No, Sir, I don't have ignore statements for temperatures. I swear!"
> > 
> > Tsss...
> 
> As you can see the situation was edited for temp3 which was the cpu temp
> sensor. All other temp sesnors are of no interest at all.
> So my answer should be read as 'not for the temperatures that are
> interesting'.

As the person asking for help here, it's your job to make complete
answers, that don't require me to "read as". I am no seer.

> The Tsss could show a lack of something.
> You are moving way off the focus of this quest which is very clear.

It looks like you are missing a very important point here. You are the
one asking for help. I am the one providing the help FOR FREE, on my
SPARE TIME. The least you can do is make it easy for me, provide
correct answers to my questions, and assist as much as you can, instead
of waiting for me to do all the work based on incomplete information.

Your question is NOT very clear. If it were, it would have been
answered already. First of all you omitted to tell us that you were
migrating from a different system where the vt1211 was working. At this
point I still don't know what was that system. 2.4 kernel? Or 2.6 with
Lars Ekman's unofficial driver?

> That's very nice to do! Why oh why keep something that works?

Why did you upgrade your system if it was working?

Our main point with that change, as you can easily imagine, was to
gratuitously break as many user systems as possible. And make them
angry after us, to trigger many complaints on this list. If it works
well, we'll make sure to do it again with every new kernel version,
it'll be great fun.

(Seriously, if you're not happy with what we do, feel tree to join the
development team and show us how to make things better. I'm eager to
improve. There's plenty of work for everyone interested.)

> Where can I find the very simple knowledge to build new compute
> statments, my only interesting hobby?

Start from etc/sensors.conf.eg in lm_sensors 2.10.1, as I suggested
already. Then read the vt1211 driver documentation
(Documentation/hwmon/vt1211 in the kernel tree), which Juerg Haefliger
was nice enough to update and extend. Most probably, you don't actually
need to change the formula, just replace "compute temp3" by "compute
temp1".

-- 
Jean Delvare


From: grant_lkml@dodo.com.au (Grant Coady)
Date: Thu, 19 May 2005 06:25:52 +0000
Subject: [PATCH 2.6.12-rc2-mm3] i2c: modify lm87 to use auto fan_div
Message-Id: <v8a4619bk1gcrpk0b0jgbrdp377ccfbvq5@4ax.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <t4uv511i3ntqtdblptvsko6tfvcm27k7hf@4ax.com>
In-Reply-To: <t4uv511i3ntqtdblptvsko6tfvcm27k7hf@4ax.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Khali,
On Sun, 17 Apr 2005 10:53:49 +0200, Jean Delvare <khali@linux-fr.org> wrote:

>Hi Grant,
>
>> > I understand that new_min++ is for rounding purposes, but it doesn't
>> > sound good to me, because of cumulated errors.
>> >
>> > Consider the case where the user asked for a low limit of 2630.
>> > new_min will be computed as 513, new_div as 0. First iteration of the
>> > loop, new_div becomes 1, new_min becomes 257. Second iteration of the
>> > loop, new_div becomes 2, new_min becomes 129. We're happy and leave
>> > the loop. The effective min limit is now (1350000 + (2 * 129)) / (4 *
>> > 129) = 2616 RPM.
>> >
>> > Without the rounding now. First iteration of the loop, new_div
>> > becomes 1, new_min becomes 256. Second iteration of the loop, new_div
>> > becomes 2, new_min becomes 128. We're happy and leave the loop. The
>> > effective min limit is now (1350000 + (2 * 128)) / (4 * 128) = 2637
>> > RPM, which is nearer from 2630 than 2616 was.
>>
>> And the other side of the same decision point: 255? 
>
>What do you mean exactly?

Centre the decision point to the middle of the bit, basic measurement.
>
>If that was the sense of your question, I agree that in some cases your
>rounding will happen to do the right thing (e.g. for 2640, your method
>leads to 2636, mine leads to 2657). My point was that your method would
>introduce cumulated rounding errors in some cases. I don't think you can
>argue with that. This is a mathematical fact.

I can easily counter that: 

  imagine the value 15 / 8 

Your method (x >> 3) results in 1, proper rounding results in 2 :)

I argue that 15/8 is two.  You argue 7/8 = 0.  o_O
>
>So, either do proper rounding, or don't do any rounding at all. Rounding
>that will work properly for half of the cases and make things worse for
>the other half isn't worth the additional effort. As the proper rouding
>looked significantly more expensive, I opted for no rounding at all. If you
>come with an elegant, proper rounding solution, I'll consider it.

I do proper binary rounding :)

>Also beware that whatever rounding you do should be taken into
>consideration in the earlier test which discards the corner cases.
>Failing to do so might result in overflows.

>And this is a bad idea. Asking the user to choose between having a low
>speed alarm and "better" fan speed measurements is stupid. The whole
>point of hardware monitoring is to detect hardware problems, and you are
>almost inviting the user to disable the alarms in exchange of better
>measurements!

We need a way to resolve this:
if the user set too low value, disable alarms

if the user sets too high value, reduce fan limit resolution to 
guarantee display of fan speed -- thus if user sets stupid alarm 
point we only ... need ... to ... assert the alarm, gotcha!

fan speed resolution goes out the window, as long as alarm state 
stays valid this will work.  Okay.  "Shift the focus, the vision 
will become clear".  Famous person...
>
>Please remember that we are *not* introducing automatic fan clock
>divider selection to provide stlightly more accurate fan speed readings.
>We are doing it so that people stop wondering and complaining that their
>fan speed reads 0 while the fan is spinning. My implementation does just
>this, while yours fails to address the problem. This is the reason why I
>can't accept it.

My argument is if user sets a known limit they know what 
they want.

Okay, I've decided: stupid alarm settings are harmless as long as 
we correctly show alarm state, we trade low speed resolution for 
displaying fan speed.  Okay.  Priority is fan speed display and 
correct alarm state, and we trade unwanted limit resoultion to 
get it 'cos stupid values only need one bit to say they're stupid.

Earlier I wrote:
What I'm exploring is intentionally reducing the resolution of the 
alarm setting to allow a wider speed indication range.  

On the right track then.

Cheers,
Grant.

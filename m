From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Sun, 08 Jan 2012 17:43:03 +0000
Subject: Re: [lm-sensors] next 17 checkpatch patches
Message-Id: <20120108174303.GB23387@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <CACW_hTZ1cYLXJS3cpsQ8fDTrr40PqPc654892a7FRR7VNng9GA@mail.gmail.com>
In-Reply-To: <CACW_hTZ1cYLXJS3cpsQ8fDTrr40PqPc654892a7FRR7VNng9GA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Frans,

On Sun, Jan 08, 2012 at 11:23:29AM -0500, Frans Meulenbroeks wrote:
> Hi all,
> 
> I've examined some more files for checkpatch problems.
> After this I'll post 17 patches.
> checkpatch lists no problems with them
> They are all compile tested
> 
> Within the files I address some problems are not resolved:
> 
> There were a few places where lines were a few chars too long but were not easy
> to break
> (e.g. because it was a long URL).
> 
> There was one place where a macro needed a do while(0); didn't peek at that one
> yet
> 
> And on a place there were two assignments in an if. Previously on a different
> case Jean told me
> it was intentional, therefore I did not touch it
> (I did touch a few places where there was a single assignment within an if).
> 
> I might be doing a few more of these later today or next few days.
> There are still about 50 files with errors or warning left. However, I have
> kinda picked the low hanging fruit (= the files that only have a few errors).
> 
> Best regards, Frans
> 
> PS: I did not bother to report the details of the checkpatch errors that were
> fixed in the commit message.

Would be great if you could do that, though. Not in the headline, but in the text.
Otherwise, I or Jean would have to do it, for which we don't necessarily have the time.

> For some of the files that still are to be done that would result in commit
> messages of > 100 lines (and not too useful).

That is why you do it in the explanation, not in the headline ...

Another nitpick: We commonly use

hwmon: (drivername) This is a commit message

as commit headline. Not much difference, but it would save us a couple of minutes
if you could do that as well.

Patches look good, except for the last one for which I sent you separate feedback.
Would be great if you could resubmit the series with the above changes.

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

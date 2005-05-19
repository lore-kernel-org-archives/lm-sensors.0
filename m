From: grant_nospam@dodo.com.au (Grant Coady)
Date: Thu, 19 May 2005 06:25:48 +0000
Subject: RFC: vid scaling does not belong in kernel?
Message-Id: <ass451l842mv00krrmpf8cdjr2nb0q8psv@4ax.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <14b451tlic7clc0rgn5aquvd4iqa7mre55@4ax.com>
In-Reply-To: <14b451tlic7clc0rgn5aquvd4iqa7mre55@4ax.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, 5 Apr 2005 12:09:39 +0200 (CEST), "Jean Delvare" <khali@linux-fr.org> wrote:

>
>Hi Philip, Grant,
>
>> But the code that exists in the kernel sensor drivers today, checks the
>> CPU, verifies which VRM standard applies to that rev of CPU and then
>> produces the correct VID to voltage mapping automatically.
>
>I would like to insist on this. The fact that vrm is writable is a legacy
>of the past. There is no more reason to set the vrm value now that
>Rudolf Marek added auto-detection stuff (which BTW should be ported back
>to lm_sensors CVS).
>
>Even exporting the VRM version to user-space makes little sense now. This
>now only serves for debugging, but this would be more efficient to
>simply print the VRM value in the logs at the moment we detect it.

That's one knocked over then, glad I asked before coding, just need to 
fix the odd-one-out: adm1026, to match the others then.  Much less work.

So I don't have vrm, therfore I don't need to scale vid, that's the 
logical reduction I've been trying to reach.  Why am I scaling a value 
when nothing can write access vrm?

Yeah, I'm missing something, too late, localtime...
Cheers,
Grant.

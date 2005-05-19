From: ppokorny@penguincomputing.com (Philip Pokorny)
Date: Thu, 19 May 2005 06:25:03 +0000
Subject: LM75 detection reworked
Message-Id: <40E89F6E.3090303@penguincomputing.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040703105636.6ba726d6.khali@linux-fr.org>
In-Reply-To: <20040703105636.6ba726d6.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Will the LM75 driver still work with the LM77?  Is the only difference 
the encoding of the temperature values?

If so, then it looked like a simple chip specific shift could be added 
to the FROM_REG and TO_REG macros to make the same driver work for both 
chips.

But I haven't looked into the code in detail or the datasheet for the 
chips...

:v)

Jean Delvare wrote:

>Hi all,
>
>As a consequence of the discovery that the LM77 is not compatible with
>the LM75, I have been reworking the LM75 detection process in both
>sensors-detect (yesterday) and the lm75 driver (today). The main idea is
>to take benefits of the no register addresse which always return the
>last read value. Additionally, the driver now checks the unused bits (I
>was surprises that it wasn't done yet, since it's a common technique).
>Anyone with a good old LM75 chip, or supposedly compatible chip, or
>reputedly not compatible and possibly misdetected chip, is welcome to
>give it a try and report.
>
>If it works OK, I'll send a similar change to Greg for 2.6.
>
>  
>


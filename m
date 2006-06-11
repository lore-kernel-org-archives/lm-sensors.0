From: dieter.jurzitza@t-online.de (Dieter Jurzitza)
Date: Sun, 11 Jun 2006 18:36:18 +0000
Subject: [lm-sensors] [PATCH] Fix the AMD756 SMBus Controller hang
Message-Id: <200606112036.18765.dieter.jurzitza@t-online.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <4485AD8C.5010906@sh.cvut.cz>
In-Reply-To: <4485AD8C.5010906@sh.cvut.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Dear all,
sorry for my delayed reply - I was out for holidays :-)). This is the reason 
why I did not report my latest findings yet and did not reply to Rudolf's 
inputs either. 
As a matter of fact I would strongly support the statement of Jean - 
especially after I found that this very same patch did not work out the same 
for the latest kernel (2.6.11.X) that has been issued by SuSE.
My patch was just guessing - and for some (to me ...) unknown reason it partly 
worked. I would highly appreciate if someone could give me a pointer to 
something to read so I can better understand what i2c-amd756.c actually does 
and how it interacts with other drivers and how my patch influences what. 
I would highly appreciate if there was someone to help me if I have related 
questions and I would personally be very reluctant to push something like my 
patch upstream not knowing what it actually does and not being sure why it 
(partly) had helped.
So, I would be really happy if someone could tell me where to start with 
understanding how things interact here - I need something black and white to 
get a clue what is happening here. Then I'll keep you updated with my 
experiences.
Many thanks in advance,
take care




Dieter Jurzitza
 
Am Mittwoch, 7. Juni 2006 23:19 schrieb Rudolf Marek:
> Hello all,
>
> > I don't like it. This is basically doubling the amount of sleep time
> > for all simple transactions. For HZ0, this means 10 ms of
******

-- 
-----------------------------------------------------------

                               |
                                \
                 /\_/\           |
                | ~x~ |/-----\   /
                 \   /-       \_/
  ^^__   _        /  _  ____   /
 <??__ \- \_/     |  |/    |  |
  ||  ||         _| _|    _| _|

if you really want to see the pictures above - use some font
with constant spacing like courier! :-)
-----------------------------------------------------------


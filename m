From: udovdh@xs4all.nl (Udo van den Heuvel)
Date: Sun, 04 Dec 2005 14:46:12 +0000
Subject: [lm-sensors] Re: hwmon-vid: Unknown VRM version of your x86 CPU
Message-Id: <4392F308.10407@xs4all.nl>
List-Id: <lm-sensors.vger.kernel.org>
References: <43834A86.6090205@sh.cvut.cz>
In-Reply-To: <43834A86.6090205@sh.cvut.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello Rudolf,

Rudolf Marek wrote:
>>Dec  4 12:56:59 epia kernel: vt1211: Ignoring new-style parameters in
>>presence of obsolete ones
>>Dec  4 12:56:59 epia kernel: CALLING WITH: 6 7 3 5
>>Dec  4 12:56:59 epia kernel: 85 is back
>>
>>Is that enough info?
>>At least it's no error?
> 
> Hmm so previous version must have worked too. I did not change anything in the code...
> (except int->u8)

I use this at the moment:
Linux epia 2.6.14.3-dbg #3 PREEMPT Sun Dec 4 07:45:24 CET 2005 i686 i686
i386 GNU/Linux

-dbg because of via rhine ethernet driver fix

> Anyway this is good. I will post new patch to Jean so it finaly will be in 2.6.16...

OK, would be interested to see this in the kernel.
Thank you!

Kind regards,
Udo


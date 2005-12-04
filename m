From: r.marek@sh.cvut.cz (Rudolf Marek)
Date: Sun, 04 Dec 2005 14:13:27 +0000
Subject: [lm-sensors] Re: hwmon-vid: Unknown VRM version of your x86 CPU
Message-Id: <4392E5CC.4040007@sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <43834A86.6090205@sh.cvut.cz>
In-Reply-To: <43834A86.6090205@sh.cvut.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> Now I got:
> 
> Dec  4 12:56:59 epia kernel: vt1211: Ignoring new-style parameters in
> presence of obsolete ones
> Dec  4 12:56:59 epia kernel: CALLING WITH: 6 7 3 5
> Dec  4 12:56:59 epia kernel: 85 is back
> 
> Is that enough info?
> At least it's no error?
> 
> Kind regards,
> Udo

Hmm so previous version must have worked too. I did not change anything in the code...
(except int->u8)

Anyway this is good. I will post new patch to Jean so it finaly will be in 2.6.16...

Regards
Rudolf

From: j.w.r.degoede@hhs.nl (Hans de Goede)
Date: Mon, 10 Jul 2006 04:33:45 +0000
Subject: [lm-sensors] new abituguru driver in mm kernel
Message-Id: <44B1D8A9.6010203@hhs.nl>
List-Id: <lm-sensors.vger.kernel.org>
References: <ce9ef0d90607041146t6837a584x68d1ab7e528139ea@mail.gmail.com>
In-Reply-To: <ce9ef0d90607041146t6837a584x68d1ab7e528139ea@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org



Sunil Kumar wrote:
> Why I expect re-compile to work is that I might have done some kernel 
> rebuild with a newer option (I don't remember if I disabled HIGHPTE 
> before or after I built abituguru last time) and it is possible that the 
> module still loads fine but can't really get initialized the first time.
> 

Ah I see.

> What is the unit for those timeouts you mentioned? In case I need to go 
> there.
> 
Number of attempted ISA reads while waiting for a certain response 
before giving up.

> This is the advantage of having it in the kernel tree itself. When is it 
> expected to be in kernel mainline? 2.6.17 series? (I can't run mm for now.)
>

Its in 2.2.18rc1

Regards,

Hans


p.s

Everyone I'm going on a short vacation till friday so don't expect any 
response /replies from me till saturday.



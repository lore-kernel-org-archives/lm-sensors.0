From: fhj52rags@yahoo.com (Ric)
Date: Sun, 20 Aug 2006 04:10:43 +0000
Subject: [lm-sensors] Using ... SMSC EMC6W201
Message-Id: <20060820041043.19161.qmail@web37406.mail.mud.yahoo.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20060613202602.560.qmail@web81611.mail.mud.yahoo.com>
In-Reply-To: <20060613202602.560.qmail@web81611.mail.mud.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi:

I don't think so. The EMC6w201 uses the SMBus...
Seems like, IIRC, that's why the smsc47* cannot be used.

Is it possible to make a usable driver by implementing only temperature
readings first, then later adding voltages, then still later fans'
RPMs, then PWM fan control, etc... rather than trying to get all of it
done at one whack?

Regards,
Ric

========
--- Rudolf Marek <r.marek at sh.cvut.cz> wrote:

[snip]
> This makes me wonder if this is not similar to DME1737 or  EMC6W201.
> Please can
> someone check it? (Ric, Alex?)
> 
> Regards
> Rudolf



__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 


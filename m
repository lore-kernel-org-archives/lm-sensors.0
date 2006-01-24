From: filip.tsachev@gmail.com (Filip Tsachev)
Date: Tue, 24 Jan 2006 07:24:04 +0000
Subject: [lm-sensors] I switched from AMD XP TB to AMD Mobile Barton
Message-Id: <ea9ff50b0601232324v419f6502p@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <ea9ff50b0601230528q3f9e2f26j@mail.gmail.com>
In-Reply-To: <ea9ff50b0601230528q3f9e2f26j@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello,

if I use the set sensor 2 - I get:

Temp 3:      +74??C  (low  =   +35??C, high =   +55??C)   sensor thermistor

If I use type 3 - I get:

Temp 3:      -79??C  (low  =   +35??C, high =   +55??C)   sensor = diode

I have no compute temp 3 line, if I try the suggested (for some other board
in the conf file) -15.096+1.4893*@), (@+15.096)/1.4893

It's going down to:

 -134??C (diode)

If I try the following formula: compute temp3 (@+128)/3, (3*@-128)

I get +16*C

The CPU temp should be around 45-55*C.. please guys help me out here, what
could be done?

On 24/01/06, Rudolf Marek <r.marek at sh.cvut.cz> wrote:

> > I switched from AMD XP TB to AMD Mobile Barton on a GB 7n400e-l (it8217)
> > and now CPU temp reading has gone to -74*C from the previous +45*C
> > readings. In bios temp readings are just it's fine.. right now it looks
> > as a diode (meaning auto selected by sensors) but if I change it to
> > thermistor (which I doubt is the type in this MB) it just changes to
> > +74*C or something similar, please tell me how to reset all-together
> > sensors data about the diode/thermistor settings or to pastebin my
> > config? there is no offset for cputemp in bios. Many thanks in advance!
>
> Hmm thats really strange. Maybe the temp reading are inverted for some
> reason?
>
> Please have a look to propper /etc/sensors.conf section
> (look for:  compute temp1     (-15.096+1.4893*@), (@+15.096)/1.4893 ) or
> similar)
>
> Maybe other people round can have some idea?
>
> Regards,
> Rudolf
>



--
Cheers,
Filip
-------------- next part --------------
An HTML attachment was scrubbed...
URL: http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20060124/708c0843/attachment.html

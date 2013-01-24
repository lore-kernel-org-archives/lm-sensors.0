From: Robert Smith <rs.porsche@gmail.com>
Date: Thu, 24 Jan 2013 10:01:37 +0000
Subject: Re: [lm-sensors] tap SMBus vis PCI slot?
Message-Id: <CAEGEQCKd3_iTveXk1tc8yH=QzL9X3WAQ4p554CK3EFWD2EE_fA@mail.gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============6451312355051914153=="
List-Id: <lm-sensors.vger.kernel.org>
References: <CAEGEQC+-T34gofYjZyGZ-NQtJK+smUghtbLXx-h5GgMbqO2FVQ@mail.gmail.com>
In-Reply-To: <CAEGEQC+-T34gofYjZyGZ-NQtJK+smUghtbLXx-h5GgMbqO2FVQ@mail.gmail.com>
To: lm-sensors@vger.kernel.org

--===============6451312355051914153==
Content-Type: multipart/alternative; boundary=047d7bb04daeb8220804d405e647

--047d7bb04daeb8220804d405e647
Content-Type: text/plain; charset=ISO-8859-1

Thanks,

My motherboard is an Intel DX58SO. I have read the documentation and it
doesn't mention a header but it does mention that the SMBus is routed to
the (single) PCI slot.

I understood that SMBus is a multi master bus? certainly my plans rely on
this.

"SMBus is a two-wire multi-master bus, meaning that more than one device
capable of controlling the bus
can be connected to it."

from section 2 'Characteristics' of:

http://smbus.org/specs/smbus110.pdf


On Thu, Jan 24, 2013 at 10:51 AM, Jean Delvare <khali@linux-fr.org> wrote:

> On Thu, 24 Jan 2013 10:17:17 +0100, Robert Smith wrote:
> > I am interested in connecting my arduino to my motherboard's SMBus and I
> > read the 'Hardware Hacking' web page here:
> >
> > http://www.lm-sensors.org/wiki/HardwareHacking
> >
> > It occurred to me that the SMBus pins are routed to the PCI slot pins
> > A40/A41, so I figured it should be possible to modify a PCI riser card
> and
> > use this to access the SMBus.
> >
> > Just wondering if anyone has any experience to share regarding this as it
> > wasn't mentioned as a possibility on the Hardware page it seems that it
> > would be a lot simpler than modifying a DIMM since you can get riser
> cards
> > which use ribbon cables.
>
> I have not done that, but it should work, assuming the vendor actually
> routed the SMBus signals to all PCI slots. I think they are supposed to
> do so, but...
>
> Alternatively, a number of motherboard models make the SMBus accessible
> directly through pins, similar to extra USB port connectors. You should
> check first if your board has this.
>
> > FYI, with the Arduino I would like to create a PID fan controller which
> can
> > access the motherboard sensors directly. It would also be able to
> > control/read the motherboard's built in fan controller as well as control
> > additional PWM fans, at least that's the idea.
>
> I admit I am very skeptical how you intend to achieve this. Please
> remember that the SMBus is not designed to be multi-master and thus you
> have absolutely no guarantee that things will work if you attempt to
> make the Arduino an SMBus master. I also see no way you can talk to
> non-SMBus (e.g. LPC or CPU-embedded) sensors.
>
> So you would need dedicated software on the host to periodically poll
> and send all the information to the Arduino. At which point you might
> as well have said software do the fan speed control by itself, assuming
> the board includes fan speed controllers. Most do these days.
>
> > I hope to also be able to configure the arduino from the PC via the SMBus
> > and possibly feed it cpu load information if that is useful in
> controlling
> > the fans... probably not necessary with the PID controller. It could be
> > useful to be able to switch between different cooling profiles.
>
> Happy hacking nevertheless :)
>
> --
> Jean Delvare
>

--047d7bb04daeb8220804d405e647
Content-Type: text/html; charset=ISO-8859-1

<div dir="ltr">Thanks,<div><br></div><div>My motherboard is an Intel DX58SO. I have read the documentation and it doesn&#39;t mention a header but it does mention that the SMBus is routed to the (single) PCI slot.</div><div>

<br></div><div>I understood that SMBus is a multi master bus? certainly my plans rely on this.</div><div><br></div><div><div>&quot;SMBus is a two-wire multi-master bus, meaning that more than one device capable of controlling the bus</div>

<div>can be connected to it.&quot;</div><div><br></div><div style>from section 2 &#39;Characteristics&#39; of:</div><div style><br></div><div style><a href="http://smbus.org/specs/smbus110.pdf">http://smbus.org/specs/smbus110.pdf</a><br>

</div><div class="gmail_extra"><br><br><div class="gmail_quote">On Thu, Jan 24, 2013 at 10:51 AM, Jean Delvare <span dir="ltr">&lt;<a href="mailto:khali@linux-fr.org" target="_blank">khali@linux-fr.org</a>&gt;</span> wrote:<br>

<blockquote class="gmail_quote" style="margin:0px 0px 0px 0.8ex;border-left-width:1px;border-left-color:rgb(204,204,204);border-left-style:solid;padding-left:1ex"><div class="im">On Thu, 24 Jan 2013 10:17:17 +0100, Robert Smith wrote:<br>


&gt; I am interested in connecting my arduino to my motherboard&#39;s SMBus and I<br>
&gt; read the &#39;Hardware Hacking&#39; web page here:<br>
&gt;<br>
&gt; <a href="http://www.lm-sensors.org/wiki/HardwareHacking" target="_blank">http://www.lm-sensors.org/wiki/HardwareHacking</a><br>
&gt;<br>
&gt; It occurred to me that the SMBus pins are routed to the PCI slot pins<br>
&gt; A40/A41, so I figured it should be possible to modify a PCI riser card and<br>
&gt; use this to access the SMBus.<br>
&gt;<br>
&gt; Just wondering if anyone has any experience to share regarding this as it<br>
&gt; wasn&#39;t mentioned as a possibility on the Hardware page it seems that it<br>
&gt; would be a lot simpler than modifying a DIMM since you can get riser cards<br>
&gt; which use ribbon cables.<br>
<br>
</div>I have not done that, but it should work, assuming the vendor actually<br>
routed the SMBus signals to all PCI slots. I think they are supposed to<br>
do so, but...<br>
<br>
Alternatively, a number of motherboard models make the SMBus accessible<br>
directly through pins, similar to extra USB port connectors. You should<br>
check first if your board has this.<br>
<div class="im"><br>
&gt; FYI, with the Arduino I would like to create a PID fan controller which can<br>
&gt; access the motherboard sensors directly. It would also be able to<br>
&gt; control/read the motherboard&#39;s built in fan controller as well as control<br>
&gt; additional PWM fans, at least that&#39;s the idea.<br>
<br>
</div>I admit I am very skeptical how you intend to achieve this. Please<br>
remember that the SMBus is not designed to be multi-master and thus you<br>
have absolutely no guarantee that things will work if you attempt to<br>
make the Arduino an SMBus master. I also see no way you can talk to<br>
non-SMBus (e.g. LPC or CPU-embedded) sensors.<br>
<br>
So you would need dedicated software on the host to periodically poll<br>
and send all the information to the Arduino. At which point you might<br>
as well have said software do the fan speed control by itself, assuming<br>
the board includes fan speed controllers. Most do these days.<br>
<div class="im"><br>
&gt; I hope to also be able to configure the arduino from the PC via the SMBus<br>
&gt; and possibly feed it cpu load information if that is useful in controlling<br>
&gt; the fans... probably not necessary with the PID controller. It could be<br>
&gt; useful to be able to switch between different cooling profiles.<br>
<br>
</div>Happy hacking nevertheless :)<br>
<span class=""><font color="#888888"><br>
--<br>
Jean Delvare<br>
</font></span></blockquote></div><br></div></div></div>

--047d7bb04daeb8220804d405e647--


--===============6451312355051914153==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============6451312355051914153==--

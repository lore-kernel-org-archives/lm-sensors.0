From: Justin Chudgar <justin@justinzane.com>
Date: Sun, 22 Feb 2009 18:52:31 +0000
Subject: Re: [lm-sensors] module c7temp shows voltage, but no temperature
Message-Id: <200902221052.31780.justin@justinzane.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============0990661861200212368=="
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org

--===============0990661861200212368==
Content-Type: multipart/alternative; boundary="Boundary-00=_v7ZoJzK1G5HlVt3"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

--Boundary-00=_v7ZoJzK1G5HlVt3
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit

As I understand, VIA has not released documentation to the lm-sensors 
developers on the latest revisions of the C7. I  believe that it is helpful if 
you post the output of cpuid with your info, but I forget which switch(es) to 
use.

As you can see, I CC'd the list with you info. Maybe someone will know 
something that I  do not. Sorry I was not of more help.
-- 

Justin Chudgar
Information Technology Consultant
5040 Saddlehorn Rd, Weed, CA 96084
530-938-9692 (Home Office) | 530-340-5632 (Mobile)

On Sunday 22 February 2009 01:57:06 am you wrote:
> Hi Justin, Juerg,
>
> I just found the c7temp module, and the ticket in the lm-sensors wiki.
> Looks like I'm facing the same problem...
>
> My system is a brand-new VIA EPIA M700 with a 1.5GHz C7 CPU.
>
> As this board is actively cooled, but I want to remove the fan, it would
> be quite important to me to get some CPU temperatures. The funny thing
> is that I don't get temperatures anywhere, neither from any of the
> lm-sensors modules (the board has an additiaonal w83627hf, I'm getting
> some voltages, but no temperatures), nor from the BIOS setup. There is a
>  menu item called "PC Health" but no temperatures inside (except a
> "system temperature", which shows no value because one would need an
> external tmep sensor connected to a pin header)
>
>
> So my question is: Is there some progress on this issue? Can I be of any
> help here?
>
>
>
> Thanks a lot, Michael


--Boundary-00=_v7ZoJzK1G5HlVt3
Content-Type: text/html;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0//EN" "http://www.w3.org/TR/REC-html40/strict.dtd"><html><head><meta name="qrichtext" content="1" /><style type="text/css">p, li { white-space: pre-wrap; }</style></head><body style=" font-family:'Myriad Pro'; font-size:9pt; font-weight:400; font-style:normal;">As I understand, VIA has not released documentation to the lm-sensors developers on the latest revisions of the C7. I  believe that it is helpful if you post the output of cpuid with your info, but I forget which switch(es) to use.<br>
<p style="-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;"><br></p>As you can see, I CC'd the list with you info. Maybe someone will know something that I  do not. Sorry I was not of more help.<br />-- <br /><br>
<span style=" font-family:'betecknalowercasebold';">Justin Chudgar</span><br>
Information Technology Consultant<br>
5040 Saddlehorn Rd, Weed, CA 96084<br>
530-938-9692 (Home Office) | 530-340-5632 (Mobile)<br>
<br />On Sunday 22 February 2009 01:57:06 am you wrote:<br>
&gt; Hi Justin, Juerg,<br>
&gt;<br>
&gt; I just found the c7temp module, and the ticket in the lm-sensors wiki.<br>
&gt; Looks like I'm facing the same problem...<br>
&gt;<br>
&gt; My system is a brand-new VIA EPIA M700 with a 1.5GHz C7 CPU.<br>
&gt;<br>
&gt; As this board is actively cooled, but I want to remove the fan, it would<br>
&gt; be quite important to me to get some CPU temperatures. The funny thing<br>
&gt; is that I don't get temperatures anywhere, neither from any of the<br>
&gt; lm-sensors modules (the board has an additiaonal w83627hf, I'm getting<br>
&gt; some voltages, but no temperatures), nor from the BIOS setup. There is a<br>
&gt;  menu item called "PC Health" but no temperatures inside (except a<br>
&gt; "system temperature", which shows no value because one would need an<br>
&gt; external tmep sensor connected to a pin header)<br>
&gt;<br>
&gt;<br>
&gt; So my question is: Is there some progress on this issue? Can I be of any<br>
&gt; help here?<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt; Thanks a lot, Michael<br>
<p style="-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;"><br></p></body></html>
--Boundary-00=_v7ZoJzK1G5HlVt3--


--===============0990661861200212368==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============0990661861200212368==--

From: James Scott Jr <skoona@verizon.net>
Date: Sat, 20 Oct 2007 02:53:09 +0000
Subject: Re: [lm-sensors] ABIT IP35 Pro mainboard wrong values from	'sensors'
Message-Id: <1192848789.29132.9.camel@homedev.skoona.net>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============6048663246454991765=="
List-Id: <lm-sensors.vger.kernel.org>
References: <1192816904.8203.11.camel@homedev.skoona.net>
In-Reply-To: <1192816904.8203.11.camel@homedev.skoona.net>
To: lm-sensors@vger.kernel.org


--===============6048663246454991765==
Content-Type: multipart/alternative; boundary="=-isxdpjLP+fCW3nD/tjb7"


--=-isxdpjLP+fCW3nD/tjb7
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Hans,

Took me longer to get home than I thought, but I did get it done.  Here
is the sensor output.
Thank you, sensor's output is now correct - coretemp's is wacked.  I
will look into whats happening with coretemp, later.

[jscott@vserv ~]$ sensors
abituguru3-isa-00e0
Adapter: ISA adapter
CPU Core:               +1.23 V  (min  +0.00 V, max  +1.55 V)
DDR2:                   +1.88 V  (min  +1.50 V, max  +2.30 V)
DDR2 VTT:               +0.94 V  (min  +0.75 V, max  +1.15 V)
CPU VTT 1.2V:           +1.20 V  (min  +1.00 V, max  +1.50 V)
MCH 1.25V:              +1.33 V  (min  +1.05 V, max  +1.55 V)
ICHIO 1.5V:             +1.52 V  (min  +1.20 V, max  +1.80 V)
ICH 1.05V:              +1.06 V  (min  +0.85 V, max  +1.25 V)
ATX +12V (24-Pin):     +12.18 V  (min  +9.60 V, max +14.40 V)
ATX +12V (8-pin):      +12.18 V  (min  +9.60 V, max +14.40 V)
ATX +5V:                +4.98 V  (min  +3.99 V, max  +6.00 V)
+3.3V:                  +3.26 V  (min  +2.64 V, max  +3.94 V)
5VSB:                   +5.04 V  (min  +3.99 V, max  +6.00 V)
CPU:                      +40°C  (high =   +65°C, crit =   +75°C)  
System :                  +33°C  (high =   +55°C, crit =   +65°C)  
PWM :                     +55°C  (high =   +80°C, crit =   +90°C)  
PWM Phase2:                +0°C  (high =    +0°C, crit =  +255°C)  
PWM Phase3:                +0°C  (high =    +0°C, crit =  +255°C)  
PWM Phase4:                +0°C  (high =    +0°C, crit =  +255°C)  
PWM Phase5:                +0°C  (high =    +0°C, crit =  +255°C)  
CPU Fan:               1200 RPM  (min  300 RPM)               
SYS Fan:               2940 RPM  (min  300 RPM)               
AUX1 Fan:                 0 RPM  (min  300 RPM)               
AUX2 Fan:                 0 RPM  (min  300 RPM)               
AUX3 Fan:                 0 RPM  (min  300 RPM)               

coretemp-isa-0000
Adapter: ISA adapter
Core 0:      +54°C  (high =  +100°C)                   

coretemp-isa-0001
Adapter: ISA adapter
Core 1:      +51°C  (high =  +100°C)                   

coretemp-isa-0002
Adapter: ISA adapter
Core 2:      +52°C  (high =  +100°C)                   

coretemp-isa-0003
Adapter: ISA adapter
Core 3:      +50°C  (high =  +100°C)                   


[jscott@vserv ~]$ uname -a
Linux vserv 2.6.23.1-4.fc7 #1 SMP Fri Oct 12 21:07:27 EDT 2007 x86_64
x86_64 x86_64 GNU/Linux



On Fri, 2007-10-19 at 20:33 +0200, Hans de Goede wrote:

> James Scott Jr wrote:
> >     Folks,
> > 
> > I have a system with an Intel Q6600 quad core on a ABit IP35 Pro
> > mainboard, using Fedora 7 x64, and lm_sensors-2.10.4-1.fc7.  The output
> > from sensors is wrong.  Is there a preformatted config file for these
> > mainboard somewhere that I can find?  Or can you give me a hit on what I
> > need to know in order to create/adjust one?
> > 
> 
> Abit usually does not use the sensors of the super io chip (which the w83627dhg 
> is), instead they use their own solution called uguru. There is a driver for 
> this, but the uguru isn't detected by sensors-detect.
> 
> Try modprobe abituguru3, and then try running sensors again.
> 
> The abituguru3 driver is only available in kernel 2.6.23 and higher, to install 
> this kernel for F-7 do:
> yum update --enable-repo=updates-testing kernel
> 
> After rebooting into the new kernel do
> modprobe abituguru3
> sensors
> 
> 
> Regards,
> 
> Hans

James,

a.k.a Skoona
Registered Linux User #270764
FC6 on Dual AMD 2400+ MPs, with ATI-9600SE and LG 1680x1050 20inch
FC7 on Intel Q6600, with GeForce 7200GS and Acer 1680x1050 20inch
Folding@home Team: 37988 FedoraFolders
Author: Gkrellfah2 Folding@Home Linux Monitor 
Author: GFHCM GTK Folding@Home Linux Monitor 
Author: GapcMon - Linux UPS Status Monitor 
Contributor: GIW - Gtk Instrumentation Library 

--=-isxdpjLP+fCW3nD/tjb7
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 TRANSITIONAL//EN">
<HTML>
<HEAD>
  <META HTTP-EQUIV="Content-Type" CONTENT="text/html; CHARSET=UTF-8">
  <META NAME="GENERATOR" CONTENT="GtkHTML/3.12.3">
</HEAD>
<BODY>
Hans,<BR>
<BR>
Took me longer to get home than I thought, but I did get it done.&nbsp; Here is the sensor output.<BR>
Thank you, sensor's output is now correct - coretemp's is wacked.&nbsp; I will look into whats happening with coretemp, later.<BR>
<BR>
<TT>[jscott@vserv ~]$ sensors</TT><BR>
<TT>abituguru3-isa-00e0</TT><BR>
<TT>Adapter: ISA adapter</TT><BR>
<TT>CPU Core:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; +1.23 V&nbsp; (min&nbsp; +0.00 V, max&nbsp; +1.55 V)</TT><BR>
<TT>DDR2:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; +1.88 V&nbsp; (min&nbsp; +1.50 V, max&nbsp; +2.30 V)</TT><BR>
<TT>DDR2 VTT:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; +0.94 V&nbsp; (min&nbsp; +0.75 V, max&nbsp; +1.15 V)</TT><BR>
<TT>CPU VTT 1.2V:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; +1.20 V&nbsp; (min&nbsp; +1.00 V, max&nbsp; +1.50 V)</TT><BR>
<TT>MCH 1.25V:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; +1.33 V&nbsp; (min&nbsp; +1.05 V, max&nbsp; +1.55 V)</TT><BR>
<TT>ICHIO 1.5V:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; +1.52 V&nbsp; (min&nbsp; +1.20 V, max&nbsp; +1.80 V)</TT><BR>
<TT>ICH 1.05V:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; +1.06 V&nbsp; (min&nbsp; +0.85 V, max&nbsp; +1.25 V)</TT><BR>
<TT>ATX +12V (24-Pin):&nbsp;&nbsp;&nbsp;&nbsp; +12.18 V&nbsp; (min&nbsp; +9.60 V, max +14.40 V)</TT><BR>
<TT>ATX +12V (8-pin):&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; +12.18 V&nbsp; (min&nbsp; +9.60 V, max +14.40 V)</TT><BR>
<TT>ATX +5V:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; +4.98 V&nbsp; (min&nbsp; +3.99 V, max&nbsp; +6.00 V)</TT><BR>
<TT>+3.3V:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; +3.26 V&nbsp; (min&nbsp; +2.64 V, max&nbsp; +3.94 V)</TT><BR>
<TT>5VSB:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; +5.04 V&nbsp; (min&nbsp; +3.99 V, max&nbsp; +6.00 V)</TT><BR>
<TT>CPU:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; +40&#176;C&nbsp; (high =&nbsp;&nbsp; +65&#176;C, crit =&nbsp;&nbsp; +75&#176;C)&nbsp; </TT><BR>
<TT>System :&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; +33&#176;C&nbsp; (high =&nbsp;&nbsp; +55&#176;C, crit =&nbsp;&nbsp; +65&#176;C)&nbsp; </TT><BR>
<TT>PWM :&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; +55&#176;C&nbsp; (high =&nbsp;&nbsp; +80&#176;C, crit =&nbsp;&nbsp; +90&#176;C)&nbsp; </TT><BR>
<TT>PWM Phase2:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; +0&#176;C&nbsp; (high =&nbsp;&nbsp;&nbsp; +0&#176;C, crit =&nbsp; +255&#176;C)&nbsp; </TT><BR>
<TT>PWM Phase3:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; +0&#176;C&nbsp; (high =&nbsp;&nbsp;&nbsp; +0&#176;C, crit =&nbsp; +255&#176;C)&nbsp; </TT><BR>
<TT>PWM Phase4:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; +0&#176;C&nbsp; (high =&nbsp;&nbsp;&nbsp; +0&#176;C, crit =&nbsp; +255&#176;C)&nbsp; </TT><BR>
<TT>PWM Phase5:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; +0&#176;C&nbsp; (high =&nbsp;&nbsp;&nbsp; +0&#176;C, crit =&nbsp; +255&#176;C)&nbsp; </TT><BR>
<TT>CPU Fan:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1200 RPM&nbsp; (min&nbsp; 300 RPM)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </TT><BR>
<TT>SYS Fan:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2940 RPM&nbsp; (min&nbsp; 300 RPM)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </TT><BR>
<TT>AUX1 Fan:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0 RPM&nbsp; (min&nbsp; 300 RPM)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </TT><BR>
<TT>AUX2 Fan:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0 RPM&nbsp; (min&nbsp; 300 RPM)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </TT><BR>
<TT>AUX3 Fan:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0 RPM&nbsp; (min&nbsp; 300 RPM)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </TT><BR>
<BR>
<TT>coretemp-isa-0000</TT><BR>
<TT>Adapter: ISA adapter</TT><BR>
<TT>Core 0:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; +54&#176;C&nbsp; (high =&nbsp; +100&#176;C)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </TT><BR>
<BR>
<TT>coretemp-isa-0001</TT><BR>
<TT>Adapter: ISA adapter</TT><BR>
<TT>Core 1:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; +51&#176;C&nbsp; (high =&nbsp; +100&#176;C)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </TT><BR>
<BR>
<TT>coretemp-isa-0002</TT><BR>
<TT>Adapter: ISA adapter</TT><BR>
<TT>Core 2:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; +52&#176;C&nbsp; (high =&nbsp; +100&#176;C)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </TT><BR>
<BR>
<TT>coretemp-isa-0003</TT><BR>
<TT>Adapter: ISA adapter</TT><BR>
<TT>Core 3:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; +50&#176;C&nbsp; (high =&nbsp; +100&#176;C)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </TT><BR>
<BR>
<BR>
<TT>[jscott@vserv ~]$ uname -a</TT><BR>
<TT>Linux vserv 2.6.23.1-4.fc7 #1 SMP Fri Oct 12 21:07:27 EDT 2007 x86_64 x86_64 x86_64 GNU/Linux</TT><BR>
<BR>
<BR>
<BR>
On Fri, 2007-10-19 at 20:33 +0200, Hans de Goede wrote:
<BLOCKQUOTE TYPE=CITE>
<PRE>
<FONT COLOR="#000000">James Scott Jr wrote:</FONT>
<FONT COLOR="#000000">&gt;     Folks,</FONT>
<FONT COLOR="#000000">&gt; </FONT>
<FONT COLOR="#000000">&gt; I have a system with an Intel Q6600 quad core on a ABit IP35 Pro</FONT>
<FONT COLOR="#000000">&gt; mainboard, using Fedora 7 x64, and lm_sensors-2.10.4-1.fc7.  The output</FONT>
<FONT COLOR="#000000">&gt; from sensors is wrong.  Is there a preformatted config file for these</FONT>
<FONT COLOR="#000000">&gt; mainboard somewhere that I can find?  Or can you give me a hit on what I</FONT>
<FONT COLOR="#000000">&gt; need to know in order to create/adjust one?</FONT>
<FONT COLOR="#000000">&gt; </FONT>

<FONT COLOR="#000000">Abit usually does not use the sensors of the super io chip (which the w83627dhg </FONT>
<FONT COLOR="#000000">is), instead they use their own solution called uguru. There is a driver for </FONT>
<FONT COLOR="#000000">this, but the uguru isn't detected by sensors-detect.</FONT>

<FONT COLOR="#000000">Try modprobe abituguru3, and then try running sensors again.</FONT>

<FONT COLOR="#000000">The abituguru3 driver is only available in kernel 2.6.23 and higher, to install </FONT>
<FONT COLOR="#000000">this kernel for F-7 do:</FONT>
<FONT COLOR="#000000">yum update --enable-repo=updates-testing kernel</FONT>

<FONT COLOR="#000000">After rebooting into the new kernel do</FONT>
<FONT COLOR="#000000">modprobe abituguru3</FONT>
<FONT COLOR="#000000">sensors</FONT>


<FONT COLOR="#000000">Regards,</FONT>

<FONT COLOR="#000000">Hans</FONT>
</PRE>
</BLOCKQUOTE>
<TABLE CELLSPACING="0" CELLPADDING="0" WIDTH="100%">
<TR>
<TD>
<TT>James,</TT><BR>
<BR>
<TT>a.k.a Skoona</TT><BR>
<I>Registered Linux User #270764</I><BR>
<I>FC6 on Dual AMD 2400+ MPs, with ATI-9600SE and LG 1680x1050 20inch</I><BR>
<I>FC7 on Intel Q6600, with GeForce 7200GS and Acer 1680x1050 20inch</I><BR>
Folding@home Team: <I>37988 FedoraFolders</I><BR>
<B><I><A HREF="http://gkrellfah2.sourceforge.net/">Author: Gkrellfah2 Folding@Home Linux Monitor</A> </I></B><BR>
<B><I><A HREF="http://gfhcm.sourceforge.net/">Author: GFHCM GTK Folding@Home Linux Monitor</A> </I></B><BR>
<B><I><A HREF="http://gapcmon.sourceforge.net/">Author: GapcMon - Linux UPS Status Monitor</A> </I></B><BR>
<B><I><A HREF="http://giw.sourceforge.net/">Contributor: GIW - Gtk Instrumentation Library</A> </I></B>
</TD>
</TR>
</TABLE>
</BODY>
</HTML>

--=-isxdpjLP+fCW3nD/tjb7--



--===============6048663246454991765==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============6048663246454991765==--


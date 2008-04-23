From: "Michael Darling" <darlingm@gmail.com>
Date: Wed, 23 Apr 2008 00:28:13 +0000
Subject: Re: [lm-sensors] How to get lm-sensors to see eight processors
Message-Id: <c33e4330804221728g66ef95fcp5c0e933c75a3df68@mail.gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============5851637728619056298=="
List-Id: <lm-sensors.vger.kernel.org>
References: <c33e4330804211437l37016d1r14943f9c52ef8b07@mail.gmail.com>
In-Reply-To: <c33e4330804211437l37016d1r14943f9c52ef8b07@mail.gmail.com>
To: lm-sensors@vger.kernel.org

--===============5851637728619056298==
Content-Type: multipart/alternative; 
	boundary="----=_Part_13863_26883479.1208910493432"

------=_Part_13863_26883479.1208910493432
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Thanks for your response!

I downloaded (I think) the latest sensors-detect script, it was 181469
bytes.  The stock 2.10.0-3.1 sensors_detect was only finding the
"smsc47b397" chip, but the new one also found "coretemp" and "to-be-written"
for "Chip Intel AMB FB-DIMM thermal sensor".

I am running CentOS 5.1 (more or less RHEL 5.1).  The latest kernel in the
RHEL 5.1 yum repo is unfortunately 2.6.18-53.1.1.4.el5.  "modprobe coretemp"
failed, which makes sense because "locate coretemp" finds nothing on my
system.

Is there a way I can add the coretemp driver, without upgrading to an
outside-repo kernel?  If so, where do I download it, and how do I install
it?

On Mon, Apr 21, 2008 at 7:37 PM, Darrick J. Wong <djwong@us.ibm.com> wrote:

> On Mon, Apr 21, 2008 at 05:37:44PM -0400, Michael Darling wrote:
> > I have a HP XW8400 workstation.  It came with a single Intel Xeon E5335,
> and
> > I correctly got lm_sensors installed so I could see the four processor
> > temperatures.  (The E5335 is a quad xeon chip.)
> >
> > I just installed a second Xeon E5335.  /proc/cpuinfo correctly sees 8
> > logical CPUs, however lm_sensors is still reporting temperatures for
> only 4
> > of those logical CPUs.  When I initially installed the machine on a
> single
> > Xeon, I got lm_sensors working correctly, but can't figure out now how
> to
> > expand it from reporting on 4 CPUs to 8.  My experience with lm_sensors
> is
> > extremely limited, so any advice would be much appreciated!
>
> Hmm... if you're running a recent kernel (2.6.23+, I think?) try the
> coretemp driver to read the temperature sensors that are on the CPU
> die.
>
> --D
>

------=_Part_13863_26883479.1208910493432
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<div>Thanks for your response!</div>
<div>&nbsp;</div>
<div>I downloaded (I think) the latest sensors-detect script, it was 181469 bytes.&nbsp; The stock 2.10.0-3.1 sensors_detect was only finding the &quot;smsc47b397&quot; chip, but the new one also found &quot;coretemp&quot; and &quot;to-be-written&quot; for &quot;Chip Intel AMB FB-DIMM thermal sensor&quot;.</div>

<div>&nbsp;</div>
<div>I am running CentOS 5.1 (more or less RHEL 5.1).&nbsp; The latest kernel in the RHEL 5.1 yum repo is unfortunately 2.6.18-53.1.1.4.el5.&nbsp; &quot;modprobe coretemp&quot; failed, which makes sense because &quot;locate coretemp&quot; finds nothing on my system.</div>

<div>&nbsp;</div>
<div>Is there a way I can add the coretemp driver, without upgrading to an outside-repo kernel?&nbsp; If so, where do I download it, and how do I install it?</div>
<div>&nbsp;</div>
<div class="gmail_quote">On Mon, Apr 21, 2008 at 7:37 PM, Darrick J. Wong &lt;<a href="mailto:djwong@us.ibm.com">djwong@us.ibm.com</a>&gt; wrote:<br>
<blockquote style="PADDING-LEFT: 1ex; MARGIN: 0px 0px 0px 0.8ex; BORDER-LEFT: #ccc 1px solid" class="gmail_quote">
<div class="Ih2E3d">On Mon, Apr 21, 2008 at 05:37:44PM -0400, Michael Darling wrote:<br>&gt; I have a HP XW8400 workstation. &nbsp;It came with a single Intel Xeon E5335, and<br>&gt; I correctly got lm_sensors installed so I could see the four processor<br>
&gt; temperatures. &nbsp;(The E5335 is a quad xeon chip.)<br>&gt;<br>&gt; I just installed a second Xeon E5335. &nbsp;/proc/cpuinfo correctly sees 8<br>&gt; logical CPUs, however lm_sensors is still reporting temperatures for only 4<br>
&gt; of those logical CPUs. &nbsp;When I initially installed the machine on a single<br>&gt; Xeon, I got lm_sensors working correctly, but can&#39;t figure out now how to<br>&gt; expand it from reporting on 4 CPUs to 8. &nbsp;My experience with lm_sensors is<br>
&gt; extremely limited, so any advice would be much appreciated!<br><br></div>Hmm... if you&#39;re running a recent kernel (2.6.23+, I think?) try the<br>coretemp driver to read the temperature sensors that are on the CPU<br>
die.<br><font color="#888888"><br>--D<br></font></blockquote></div><br>

------=_Part_13863_26883479.1208910493432--


--===============5851637728619056298==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============5851637728619056298==--

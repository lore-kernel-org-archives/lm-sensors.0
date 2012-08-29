From: Rakesh Kumar <knrakeshkumar@gmail.com>
Date: Wed, 29 Aug 2012 17:23:13 +0000
Subject: Re: [lm-sensors] Monitoring FPGA
Message-Id: <CANZCtCziwG-Tx_WUdm7a4D6AjQ_P+vTkT3fuj9aEnXBOSXyhdg@mail.gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============4036985877038407219=="
List-Id: <lm-sensors.vger.kernel.org>
References: <CANZCtCz9NKCK1vNPjuRFqwrmyBzb9aehi0OQDZ-=K47==h8JCw@mail.gmail.com>
In-Reply-To: <CANZCtCz9NKCK1vNPjuRFqwrmyBzb9aehi0OQDZ-=K47==h8JCw@mail.gmail.com>
To: lm-sensors@vger.kernel.org

--===============4036985877038407219==
Content-Type: multipart/alternative; boundary=e89a8fb1ff005c78c304c86aa5dc

--e89a8fb1ff005c78c304c86aa5dc
Content-Type: text/plain; charset=ISO-8859-1

Ok. Thanks a lot for the useful information.

On Wed, Aug 29, 2012 at 10:28 PM, Guenter Roeck <linux@roeck-us.net> wrote:

> On Wed, Aug 29, 2012 at 08:27:25PM +0530, Rakesh Kumar wrote:
> > Hello I am Rakesh. I want to know if there are any vendor provided
> library
> > APIs to query FPGA utilization, health, temperature etc. from the
> > application level for developers. I am a student and I am planning to
> > develop an FPGA monitoring tool in a heterogeneous Linux cluster. Or if I
> > have to start everything from scratch what is the procedure? Does lm
> > sensors help me with this? I look forward to hearing from you. Thank you.
> > Please send a mail to knrakeshkumar@gmail.com
>
> Hi,
>
> first of all, the functionality you are looking for depends on the FPGA
> supporting system monitor features. Those will be FPGA specific. Also,
> the functionality has to be enabled in the FPGA design. For example,
> the Virtex-5 FPGAs support system monitor functionality, but it has to be
> enabled by including the SYSMON functional block into the actual design.
> In addition to that, the SYSMON registers have to be exposed to the user.
> This again is design specific.
>
> Ultimately, that means that a generic solution to monitor the health of
> FPGAs is
> likely technically impossible, since there are several layers of
> dependency. I
> could imagine something like a generic hwmon driver for the SYSMON
> functional
> block of Virtex-5 FPGAs, as a slave driver to an FPGA MFD driver. But that
> would
> require an actual design to be able to test the code, and it would only
> apply to
> one specific class of FPGAs.
>
> Guenter
>
>

--e89a8fb1ff005c78c304c86aa5dc
Content-Type: text/html; charset=ISO-8859-1

Ok. Thanks a lot for the useful information.<br><br><div class="gmail_quote">On Wed, Aug 29, 2012 at 10:28 PM, Guenter Roeck <span dir="ltr">&lt;<a href="mailto:linux@roeck-us.net" target="_blank">linux@roeck-us.net</a>&gt;</span> wrote:<br>
<blockquote class="gmail_quote" style="margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><div class="HOEnZb"><div class="h5">On Wed, Aug 29, 2012 at 08:27:25PM +0530, Rakesh Kumar wrote:<br>
&gt; Hello I am Rakesh. I want to know if there are any vendor provided library<br>
&gt; APIs to query FPGA utilization, health, temperature etc. from the<br>
&gt; application level for developers. I am a student and I am planning to<br>
&gt; develop an FPGA monitoring tool in a heterogeneous Linux cluster. Or if I<br>
&gt; have to start everything from scratch what is the procedure? Does lm<br>
&gt; sensors help me with this? I look forward to hearing from you. Thank you.<br>
&gt; Please send a mail to <a href="mailto:knrakeshkumar@gmail.com">knrakeshkumar@gmail.com</a><br>
<br>
</div></div>Hi,<br>
<br>
first of all, the functionality you are looking for depends on the FPGA<br>
supporting system monitor features. Those will be FPGA specific. Also,<br>
the functionality has to be enabled in the FPGA design. For example,<br>
the Virtex-5 FPGAs support system monitor functionality, but it has to be<br>
enabled by including the SYSMON functional block into the actual design.<br>
In addition to that, the SYSMON registers have to be exposed to the user.<br>
This again is design specific.<br>
<br>
Ultimately, that means that a generic solution to monitor the health of FPGAs is<br>
likely technically impossible, since there are several layers of dependency. I<br>
could imagine something like a generic hwmon driver for the SYSMON functional<br>
block of Virtex-5 FPGAs, as a slave driver to an FPGA MFD driver. But that would<br>
require an actual design to be able to test the code, and it would only apply to<br>
one specific class of FPGAs.<br>
<span class="HOEnZb"><font color="#888888"><br>
Guenter<br>
<br>
</font></span></blockquote></div><br>

--e89a8fb1ff005c78c304c86aa5dc--


--===============4036985877038407219==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============4036985877038407219==--

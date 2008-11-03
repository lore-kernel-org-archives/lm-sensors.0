From: "lu zhihe" <tombowfly@gmail.com>
Date: Mon, 03 Nov 2008 12:55:43 +0000
Subject: Re: [lm-sensors] GM965 IGP temperature detector
Message-Id: <73511e6c0811030455n54a5cf45qf2fb261554740125@mail.gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="----=_Part_44723_12609618.1225716943546"
List-Id: <lm-sensors.vger.kernel.org>
References: <73511e6c0810260733h27877c9o25dd5c346a97e9c2@mail.gmail.com>
In-Reply-To: <73511e6c0810260733h27877c9o25dd5c346a97e9c2@mail.gmail.com>
To: lm-sensors@vger.kernel.org

------=_Part_44723_12609618.1225716943546
Content-Type: multipart/alternative; 
	boundary="----=_Part_44724_27185032.1225716943546"

------=_Part_44724_27185032.1225716943546
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Dear Jean:

     Thank you for your advises.

     Maybe your north bridge is GM945? And the support for GM945 is under
development, according to Intel's datasheet, it only report mem.
temperature. On some 945G the vaule is always 0xFF. I had update the
"calibrated current temperature" transfer to "degree Celsius" by refer to
Intel's earlier document.

2008/11/2  Delvare <khali@linux-fr.org>

> On Sun, 26 Oct 2008 14:33:47 +0000, lu zhihe wrote:
> > Dear all:
> >
> >        I just write a little tool to detect my GM965 IGP's temperatue, it
> > bases on coreboot's inteltool.
> >        Several people try it ,and it seems work.
> >        Do you think it can be adapt to Lm-sensors ?
> >        It just use PCI read/write, maybe don't fall on i2c,isa or acpi
> bus.
>
> Yes, it should be easy to adapt to lm-sensors, all you need to do is
> move the code to a Linux kernel driver and add sysfs attributes to
> export the temperature to users-space.
>
> The fact that this is a PCI device isn't a problem at all, we already
> have several hwmon drivers for PCI devices: k8temp, sis5595, via686a,
> vt8231 and, I believe, i5k_amb.
>
> >       The code is here:
> >
> >
> http://www.coreboot.org/pipermail/coreboot/attachments/20081026/0f52e1e7/attachment-0001.gz
> >
> >       It's format is tar.gz
>
> A couple notes:
>
> * You make use of PCI_FILL_CLASS while as far as I can tell you don't
> need it. This prevents your tool from building with older pci header
> files so you may want to stop using it.
>
> * On my laptop with an ICH7, the tool reports "Your GPU temperature is
> under 40 degrees Centigrade". This laptop has an ATI Radeon graphics
> chip so the Intel IGP isn't used. So I am curious if the value returned
> by your tool is meaningful or not?
>
> * Note that the correct unit name is degree Celsius, not degree
> Centigrade.
>
> --
> Jean Delvare
>



-- 
Thx

Lu Zhihe

------=_Part_44724_27185032.1225716943546
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<p>Dear&nbsp;Jean:</p><p>&nbsp; &nbsp; &nbsp;Thank you for your advises. </p><p>&nbsp; &nbsp; &nbsp;Maybe your north bridge is GM945? And the support for GM945 is under development, according to Intel&#39;s datasheet, it only report mem. temperature. On some 945G the vaule is always 0xFF. I had update the &quot;calibrated current temperature&quot; transfer to &quot;degree Celsius&quot; by refer to Intel&#39;s earlier document.</p>
<br><div class="gmail_quote">2008/11/2 &nbsp;Delvare <span dir="ltr">&lt;<a href="mailto:khali@linux-fr.org">khali@linux-fr.org</a>&gt;</span><br><blockquote class="gmail_quote" style="margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex;">
<div class="Ih2E3d">On Sun, 26 Oct 2008 14:33:47 +0000, lu zhihe wrote:<br>
&gt; Dear all:<br>
&gt;<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp;I just write a little tool to detect my GM965 IGP&#39;s temperatue, it<br>
&gt; bases on coreboot&#39;s inteltool.<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp;Several people try it ,and it seems work.<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp;Do you think it can be adapt to Lm-sensors ?<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp;It just use PCI read/write, maybe don&#39;t fall on i2c,isa or acpi bus.<br>
<br>
</div>Yes, it should be easy to adapt to lm-sensors, all you need to do is<br>
move the code to a Linux kernel driver and add sysfs attributes to<br>
export the temperature to users-space.<br>
<br>
The fact that this is a PCI device isn&#39;t a problem at all, we already<br>
have several hwmon drivers for PCI devices: k8temp, sis5595, via686a,<br>
vt8231 and, I believe, i5k_amb.<br>
<div class="Ih2E3d"><br>
&gt; &nbsp; &nbsp; &nbsp; The code is here:<br>
&gt;<br>
&gt; <a href="http://www.coreboot.org/pipermail/coreboot/attachments/20081026/0f52e1e7/attachment-0001.gz" target="_blank">http://www.coreboot.org/pipermail/coreboot/attachments/20081026/0f52e1e7/attachment-0001.gz</a><br>

&gt;<br>
&gt; &nbsp; &nbsp; &nbsp; It&#39;s format is tar.gz<br>
<br>
</div>A couple notes:<br>
<br>
* You make use of PCI_FILL_CLASS while as far as I can tell you don&#39;t<br>
need it. This prevents your tool from building with older pci header<br>
files so you may want to stop using it.<br>
<br>
* On my laptop with an ICH7, the tool reports &quot;Your GPU temperature is<br>
under 40 degrees Centigrade&quot;. This laptop has an ATI Radeon graphics<br>
chip so the Intel IGP isn&#39;t used. So I am curious if the value returned<br>
by your tool is meaningful or not?<br>
<br>
* Note that the correct unit name is degree Celsius, not degree<br>
Centigrade.<br>
<br>
--<br>
<font color="#888888">Jean Delvare<br>
</font></blockquote></div><br><br clear="all"><br>-- <br>Thx<br><br>Lu Zhihe<br>

------=_Part_44724_27185032.1225716943546--

------=_Part_44723_12609618.1225716943546
Content-Type: application/x-gzip; name=gpu_temp.tgz
Content-Transfer-Encoding: base64
X-Attachment-Id: f_fn3lbcaq0
Content-Disposition: attachment; filename=gpu_temp.tgz

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
------=_Part_44723_12609618.1225716943546
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
------=_Part_44723_12609618.1225716943546--

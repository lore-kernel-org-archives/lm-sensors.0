From: Carson Au <carson.au@zeptonics.com>
Date: Sat, 13 Oct 2012 10:16:17 +0000
Subject: [lm-sensors] SMBus access on PCI Express slots
Message-Id: <CAO1EDAeLLDUqG7HWqnm=7AOd-j0HCAEwTrqw0s7onMEDCFpz=Q@mail.gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============3556141557953361744=="
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org

--===============3556141557953361744==
Content-Type: multipart/alternative; boundary=20cf307c9b3e4cfc1b04cbee18c8

--20cf307c9b3e4cfc1b04cbee18c8
Content-Type: text/plain; charset=ISO-8859-1

Hi,

I am having trouble accessing the SMBus on PCI Express slots using
lm-sensors or i2c-tools. I have attached my oscilloscope probes to the CLK
and DATA lines, but even when I run sensors-detect, I can see no such
activity on the line (lm-sensors does indeed find some i2c sensors).

I am wondering if SMBus is even implemented on my Asrock Extreme 4
motherboard (is it a mandatory requirement or just optional?). Or maybe the
SMBus connected to PCIe slots are behind an SMBus multiplexer?

Thanks,
Carson

--20cf307c9b3e4cfc1b04cbee18c8
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,<div><br></div><div>I am having trouble accessing the SMBus on PCI Expre=
ss slots using lm-sensors or i2c-tools. I have attached my oscilloscope pro=
bes to the CLK and DATA lines, but even when I run sensors-detect, I can se=
e no such activity on the line (lm-sensors does indeed find some i2c sensor=
s).=A0</div>
<div><br></div><div>I am wondering if SMBus is even implemented on my Asroc=
k Extreme 4 motherboard (is it a mandatory requirement or just optional?). =
Or maybe the SMBus connected to PCIe slots are behind an SMBus multiplexer?=
</div>
<div><br></div><div>Thanks,</div><div>Carson</div>

--20cf307c9b3e4cfc1b04cbee18c8--


--===============3556141557953361744==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============3556141557953361744==--

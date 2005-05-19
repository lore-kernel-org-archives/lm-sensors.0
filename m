From: THarrington@trilogicsystems.com (Todd Harrington)
Date: Thu, 19 May 2005 06:23:26 +0000
Subject: Winbond w83782d hanging problem
Message-Id: <01Dec10.101201est.119050@bouncer.trilogic.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <01Dec7.115131est.119045@bouncer.trilogic.com>
In-Reply-To: <01Dec7.115131est.119045@bouncer.trilogic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

We are using a Tyan 2688 motherboard (WinBond w83782d). The problem that I
am having is the lm_sensors package is hanging when I load the w83781d
(modprobe w83781d) driver. 

We are using the lm_sensors 2.6.2 and i2c 2.6.2. I have also tried the CVS
version and have done:

modprobe i2c-piix4
modprobe w83781d init=0

I have also tried modprobe w83781d force_w83782d=0,0x29

The system still hangs.

I read on the linux-kernel mailing list a similar problem and it said there
was a bug in the winbond driver but there was has been patch posted to
bugtracker but the changes have not been integrated with CVS yet? Not sure
if this related.

Hoping someone can help me!

Regards,


Todd Harrington
Trilogic Systems
Senior Systems Engineer
Tel -  978-658-3800 x-151
Fax - 978-657-5927
todd@trilogic.com
"Trilogic Systems:Providing you a full portfolio of 
design, integration, certification and support services."



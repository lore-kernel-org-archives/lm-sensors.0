From: pgaige@cadesis.com (=?ISO-8859-1?Q?Gaig=E9_Pierre?=)
Date: Thu, 19 May 2005 06:24:08 +0000
Subject: beeping issues (solved)
Message-Id: <3F281B71.1090300@cadesis.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030730172101.1a01a380.khali@linux-fr.org>
In-Reply-To: <20030730172101.1a01a380.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Yes, the step 1 stopped the beeping problem.
Thanks for your input.

Pierre.

Jean Delvare wrote:
> Hi all,
> 
> Here is the solution (hopefully) to the beeping problem you encountered
> using LM Sensors with the AS99127F chip.
> 
> It turns out that the beeping is caused by VCore being out of range
> (Thanks to "The Master" for noticing this.) The reason why it beeps is
> obscure, and we can't do anything against that since we don't have a
> data sheet for the AS19927F (Damn Asus. Ask them if you want one.)
> 
> So, since we can't turn the beeping off, the solution is to ensure VCore
> isn't out of range anymore. Most of the time, VCore is indeed OK, but
> the chip thinks it isn't because the limits are bad. Bad limits are
> usually caused by a bad VID reading. So here are the things to try, in
> order:
> 
> 1* Edit the vrm option in /etc/sensors.conf, section as99127f-*.
> Typically, this means uncommenting the "vrm 9.0" line. It should make
> the VID reading OK. Run "sensors -s", the beeping should stop.
> 
> 2* Edit the in0_min and in0_max lines in /etc/sensors/conf, section
> as99127f-*. Instead of using vid, write down the value you know VCore
> should have (simply run sensors to see what it is). Run "sensors -s",
> the beeping should stop.
> 
> You can check that the limits are OK by running "sensors".
> 
> Please let us know wether it works or not.
> 


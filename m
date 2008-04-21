From: "Pierce Ward" <pierceward@gmail.com>
Date: Mon, 21 Apr 2008 18:28:00 +0000
Subject: Re: [lm-sensors] lm_sensors + IBM xseries 336
Message-Id: <874302b50804211128i3b236797n962b0315be6cb9ec@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <874302b50804210937n5d003656teaa61cbec6d5a65e@mail.gmail.com>
In-Reply-To: <874302b50804210937n5d003656teaa61cbec6d5a65e@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hey,


 On Mon, Apr 21, 2008 at 7:03 PM, Darrick J. Wong <djwong@us.ibm.com> wrote:
 > On Mon, Apr 21, 2008 at 07:35:49PM +0200, Jean Delvare wrote:
 >
 >  > Better download the latest version of the script here:
 >  > http://www.lm-sensors.org/browser/lm-sensors/trunk/prog/detect/sensors-detect?format=txt
 >  > You can run it without installing it. It doesn't have the check for IBM
 >  > systems, since it was updated to behave more safely. And a recent
 >  > version has more chances to know about your hardware.
 >  >
 >  > But I wouldn't hold my breath... As far as I know these IBM xseries
 >  > servers do not have hardware monitoring chips.

 After a bit of googling it seems you are correct !


 >  If there's a BMC (the x336 has one) then the sensors can be read via
 >  ipmitool because the hwmon controllers are wired to the BMC, not to
 >  the system.

 Also after a bit of googling it seems you are correct ! The xSeries
 336 has a BMC, so I'll look into using ipmitool to read from it.

 Thanks a lot for the replies,

 Pierce.

 >  --D
 >

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

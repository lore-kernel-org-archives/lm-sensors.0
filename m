From: ericb@aspsys.com (Eric J. Bowersox)
Date: Fri, 01 Jul 2005 17:44:23 +0000
Subject: [lm-sensors] W83792D & Overtemperature LED on Supermicro
Message-Id: <1120232599.19205.4.camel@wiz.dev.aspsys.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1120167411.32695.31.camel@wiz.dev.aspsys.com>
In-Reply-To: <1120167411.32695.31.camel@wiz.dev.aspsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, 2005-06-30 at 18:33, Mark Studebaker wrote:
> you want hyst (hysteresis) to be high, like 68.
> The alarm isn't cleared until the temperature goes below the hysteresis value.

I just tried that on one of the nodes in question.  Didn't help.  Even
with all tempN_over values set to 80 and all tempN_hyst values set to
75, the output of "sensors" still displays "ALARM" by the two CPU
temperatures (which currently read 46 and 49 respectively), and the
front-panel temperature light still blinks.  (The output of "sensors"
did show that the two limits were set correctly by "sensors -s" though.)

					Eric

-- 
Eric J. Bowersox, Software Engineer     Aspen Systems, Inc.
<ericb@aspsys.com>                      3900 Youngfield Street
Tel: +01 303 431 4606 x113              Wheat Ridge, CO  80033, USA
Fax: +01 303 431 7196                   <http://www.aspsys.com>


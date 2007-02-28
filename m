From: hmh@hmh.eng.br (Henrique de Moraes Holschuh)
Date: Wed, 28 Feb 2007 14:34:34 +0000
Subject: [lm-sensors] Conversion of ACPI fan+thermal to hwmon sysfs
Message-Id: <20070228143433.GB30168@khazad-dum.debian.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <20070224182024.GA23865@khazad-dum.debian.net> <20070226172716.b2e956b7.khali@linux-fr.org> <1172655111.11100.50.camel@localhost.localdomain>
In-Reply-To: <1172655111.11100.50.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Zhang Rui <rui.zhang@intel.com>
Cc: Jean Delvare <khali@linux-fr.org>, "linux-acpi@vger" <linux-acpi@vger.kernel.org>, lm-sensors@lm-sensors.org

(ibm-acpi-devel removed from cc, subject changed)

On Wed, 28 Feb 2007, Zhang Rui wrote:
> I'm converting these two modules to sysfs. I think "thermal" has too
> much ACPI specific information and is not that easy to have a generic
> interface.

It is not easy.  In fact, it could be quite complicated.  But when combined
with the fan objects, it should be possible.

hwmon's idea of thermal zones are chip-specific, so the way to get ACPI to
work with that without much changes is to think of the entire ACPI model as
a "single chip".  This probably means ACPI fan and thermal zones need to
cooperate to be ported to the hwmon model.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh


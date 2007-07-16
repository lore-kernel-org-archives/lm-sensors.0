From: Vadim Zeitlin <vadim@zeitlins.org>
Date: Mon, 16 Jul 2007 23:22:45 +0000
Subject: Re: [lm-sensors] [PATCH] adt7470: Temperatures should be signed
Message-Id: <E1IAZxE-0005HX-As@teufli.physik.fu-berlin.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <20070716230724.GG2619@tree.beaverton.ibm.com>
In-Reply-To: <20070716230724.GG2619@tree.beaverton.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, 16 Jul 2007 16:07:24 -0700 "Darrick J. Wong" <djwong@us.ibm.com> wrote:

DJW> On Mon, Jul 16, 2007 at 03:19:04PM -0700, Philip Pokorny wrote:
DJW> > The values 0x81 and 0x7f are signed 8 bit quantities.  0x81 whould be considered -127
DJW> 
DJW> Ah yes, excellent point.  Here's a patch to correct that.
DJW> 
DJW> ---
DJW> adt7470: Temperature sensors are signed quantities
DJW> 
DJW> Philip Pokorny points out that the temperature sensors are signed
DJW> quantities, hence the anomalous looking readings reported by Vadim
DJW> Zeitlin.
DJW> 
DJW> Signed-off-by: Darrick J. Wong <djwong@us.ibm.com>
DJW> ---
DJW> 
DJW>  drivers/hwmon/adt7470.c |    8 ++++----
DJW>  1 files changed, 4 insertions(+), 4 deletions(-)

 Thanks, this does fix the shown values of low/high values. Some of the
temperature values (2, 5, 6) themselves are still strange though:

% sensors3 -c /dev/null
adt7470-i2c-0-2e
Adapter: SMBus I801 adapter at 18c0
fan1:       2001 RPM  (min =    0 RPM)
fan2:          0 RPM  (min =    0 RPM)
fan3:       1717 RPM  (min =    0 RPM)
fan4:       1539 RPM  (min =    0 RPM)
temp1:        +1.0 C  (low  = -127.0 C, high = +127.0 C)
temp2:       -30.0 C  (low  = -127.0 C, high = +127.0 C)
temp3:       +56.0 C  (low  = -127.0 C, high = +127.0 C)
temp4:       +52.0 C  (low  = -127.0 C, high = +127.0 C)
temp5:       -33.0 C  (low  = -127.0 C, high = +127.0 C)
temp6:       -31.0 C  (low  = -127.0 C, high = +127.0 C)
temp7:       +57.0 C  (low  = -127.0 C, high = +127.0 C)
temp8:       +53.0 C  (low  = -127.0 C, high = +127.0 C)
temp9:       +47.0 C  (low  = -127.0 C, high = +127.0 C)
temp10:      +49.0 C  (low  = -127.0 C, high = +127.0 C)

 Normally I'd just say that the corresponding sensors are not connected but
these values do change slightly (+/-1 degree) from time to time so I'm not
sure if this is indeed the case or they are connected but should be
interpreted differently somehow.

 Thanks,
VZ


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

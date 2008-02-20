From: Matt Roberds <mattroberds@cox.net>
Date: Wed, 20 Feb 2008 04:24:02 +0000
Subject: Re: [lm-sensors] adt7475 support status update?
Message-Id: <Pine.LNX.4.64.0802192212540.2276@birdbird.example.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <47B32CEF.40405@hhs.nl>
In-Reply-To: <47B32CEF.40405@hhs.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On Tue, 19 Feb 2008, Jordan Crouse wrote:
> Updated patch against HEAD is attached.
> [...]
>+/* 7475 Notes:
>+ * Addeded by: Jordan Crouse <jordan.crouse@amd.com>
>+ * Datasheet:  http://www.analog.com/UploadedFiles/Data_Sheets/ADT7475.pdf
>+ * TODO:  enhanced acoustics
>+ */

This doesn't affect the code at all, but this line of chips was
apparently sold to On Semiconductor, effective 1 Jan 2008.  When I was
looking for data on this chip in mid-January, Analog Devices no longer
had the data sheet and On hadn't posted it yet, but now it is available
from On.  Product page is
http://www.onsemi.com/PowerSolutions/product.do?id=ADT7475 and datasheet
is http://www.onsemi.com/pub/Collateral/ADT7475-D.PDF .  This seems to
have affected several of the ADT74xx series chips.

It might be out of scope for lm-sensors, but I wonder if it would be a
good idea to collect the datasheets on the various hardware monitoring
chips and possibly make them available on the lm-sensors site.  I know
the Devices page has links to the manufacturer pages, but these can and
do change or go away.

Matt Roberds


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

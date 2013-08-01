From: Harald Judt <h.judt@gmx.at>
Date: Thu, 01 Aug 2013 14:36:43 +0000
Subject: Re: [lm-sensors] w83627ehf: Wrong values reported after resuming from suspend/hibernation
Message-Id: <51FA727B.90904@gmx.at>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------070505040801070405060002"
List-Id: <lm-sensors.vger.kernel.org>
References: <50856051.5070803@gmx.at>
In-Reply-To: <50856051.5070803@gmx.at>
To: lm-sensors@vger.kernel.org

This is a multi-part message in MIME format.
--------------070505040801070405060002
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi,

Am 01.08.2013 15:42, schrieb Guenter Roeck:
> On 08/01/2013 02:08 AM, Harald Judt wrote:
>> -----BEGIN PGP SIGNED MESSAGE----- Hash: SHA1
>> 
>> Am 01.08.2013 00:11, schrieb Guenter Roeck:
>>> On Mon, Jul 29, 2013 at 05:27:35PM +0200, Harald Judt wrote: [
>>> ... ]
>>>> 
>>>> -- `Experience is the best teacher.'
>>>> 
>>> 
>>>> From c3961cf2fa1d6975b9bcffeb746c57bda09e7489 Mon Sep 17
>>>> 00:00:00 2001 From: Harald Judt <h.judt@gmx.at> Date: Mon, 29
>>>> Jul 2013 17:00:27 +0200 Subject: hwmon: (nct6775) Add support
>>>> for hibernate
>>>> 
>>> Hi Harald,
>>> 
>>> Signed-off-by: is missing. Ok if I add your Signed-off to the
>>> patch ?
>>> 
>>> Thanks, Guenter
>> 
>> Sure, no problem, I didn't think about that. Also, even though 
>> deprecated, probably a similar patch would be needed for the
>> original w83627ehf.c. I could create, test and send you another
>> such patch today in the evening or tomorrow. Otherwise,
>> 
> Yes, that would be great.
> 
>> Signed-off-by: Harald Judt <h.judt@gmx.at>
>> 
> Thanks!
> 
> Guenter

Attached you will find the two patches, tested and this time already
signed-off.

Harald

- -- 
`Experience is the best teacher.'

PGP Key ID: 0xBA3AC516
Fingerprint: 569E 0ADA 440A 8B11 D1A2 AB47 8238 0256 BA3A C516
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBAgAGBQJR+nJ7AAoJEII4Ala6OsUWtq4H/Re5XomkMpB7HyGWUHMB4Lgg
tWf156At41eB6UUKKpM3wpmdAeTKEEVKheX6hEoAdnz1cHdPtw4XUSheKIS7KHjf
VOE1KWXipzLWBF4h3bM5hPS1NFeSyUE43UIZFYvYw97P3eoffyrt/PS5zIeUnYBm
d0D12it6b00heBOIfh11TofhsQLZfHBbcNBfMM43sez12J5yYOSfhZ9SCBssiViQ
ujEMv5vO5ig1Co1RucuMfsHwgX8ZsunlxW9djgXHHUtDI++nBmKk0Xnrd+n/u1d2
GAyKYCBo7FJyOxFqTNr5WfZOeqdXCeGblrVMM34T7Zm554vsUaIMJ96yr565U+w=
=Y3PD
-----END PGP SIGNATURE-----

--------------070505040801070405060002
Content-Type: text/x-patch;
 name="0001-hwmon-nct6775-Add-support-for-hibernate.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="0001-hwmon-nct6775-Add-support-for-hibernate.patch"

From 67c57edfefeca37f8ec7a85a9f0eaeedea5d10a1 Mon Sep 17 00:00:00 2001
From: Harald Judt <h.judt@gmx.at>
Date: Tue, 30 Jul 2013 19:50:16 +0200
Subject: hwmon: (nct6775) Add support for hibernate

Signed-off-by: Harald Judt <h.judt@gmx.at>
---
 drivers/hwmon/nct6775.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/hwmon/nct6775.c b/drivers/hwmon/nct6775.c
index 99cec18..005cfd5 100644
--- a/drivers/hwmon/nct6775.c
+++ b/drivers/hwmon/nct6775.c
@@ -4056,6 +4056,8 @@ static int nct6775_resume(struct device *dev)
 static const struct dev_pm_ops nct6775_dev_pm_ops = {
 	.suspend = nct6775_suspend,
 	.resume = nct6775_resume,
+	.freeze = nct6775_suspend,
+	.restore = nct6775_resume,
 };
 
 #define NCT6775_DEV_PM_OPS	(&nct6775_dev_pm_ops)
-- 
1.8.3.2


--------------070505040801070405060002
Content-Type: text/x-patch;
 name="0002-hwmon-w83627ehf-Add-support-for-hibernate.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0002-hwmon-w83627ehf-Add-support-for-hibernate.patch"

From 0a13e05b3bd2a3b8943525555914aea64d941424 Mon Sep 17 00:00:00 2001
From: Harald Judt <h.judt@gmx.at>
Date: Thu, 1 Aug 2013 16:18:45 +0200
Subject: hwmon: (w83627ehf) Add support for hibernate

Signed-off-by: Harald Judt <h.judt@gmx.at>
---
 drivers/hwmon/w83627ehf.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/hwmon/w83627ehf.c b/drivers/hwmon/w83627ehf.c
index 004801e..69e1ee1 100644
--- a/drivers/hwmon/w83627ehf.c
+++ b/drivers/hwmon/w83627ehf.c
@@ -2694,6 +2694,8 @@ static int w83627ehf_resume(struct device *dev)
 static const struct dev_pm_ops w83627ehf_dev_pm_ops = {
 	.suspend = w83627ehf_suspend,
 	.resume = w83627ehf_resume,
+	.freeze = w83627ehf_suspend,
+	.restore = w83627ehf_resume,
 };
 
 #define W83627EHF_DEV_PM_OPS	(&w83627ehf_dev_pm_ops)
-- 
1.8.3.2


--------------070505040801070405060002
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--------------070505040801070405060002--

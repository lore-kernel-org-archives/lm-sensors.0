From: "R, Durgadoss" <durgadoss.r@intel.com>
Date: Tue, 05 Apr 2011 14:43:20 +0000
Subject: Re: [lm-sensors] [PATCH:hwmon:v4:]Merging_pkgtemp_with_coretemp
Message-Id: <D6D887BA8C9DFF48B5233887EF046541095167721C@bgsmsx502.gar.corp.intel.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="_003_D6D887BA8C9DFF48B5233887EF046541095167721Cbgsmsx502garc_"
List-Id: <lm-sensors.vger.kernel.org>
References: <1299101865-10797-1-git-send-email-durgadoss.r@intel.com>
In-Reply-To: <1299101865-10797-1-git-send-email-durgadoss.r@intel.com>
To: lm-sensors@vger.kernel.org

--_003_D6D887BA8C9DFF48B5233887EF046541095167721Cbgsmsx502garc_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi Fenghua,

I have attached the logs of the merged coretemp driver on
a SNB and non-SNB platform. Kindly review and let me know your
comments.
For me, the log indicates that the driver works fine.
Let me know your Ack/comments on the patch too.

[NON_SNB]
/sys/class/hwmon/hwmon0/device
---
modalias:platform:coretemp
name:coretemp
temp1_crit:105000
temp1_crit_alarm:0
temp1_input:23000
temp1_label:Core 0
temp1_max:89000
temp2_crit:105000
temp2_crit_alarm:0
temp2_input:25000
temp2_label:Core 2
temp2_max:89000
uevent:DRIVER=3Dcoretemp
uevent:MODALIAS=3Dplatform:coretemp

[SNB-With PKG Support]
/sys/class/hwmon/hwmon1/device
---
modalias:platform:coretemp
name:coretemp
temp1_crit:100000
temp1_crit_alarm:0
temp1_input:37000
temp1_label:Physical id 0
temp1_max:86000
temp2_crit:100000
temp2_crit_alarm:0
temp2_input:30000
temp2_label:Core 0
temp2_max:86000
temp3_crit:100000
temp3_crit_alarm:0
temp3_input:37000
temp3_label:Core 1
temp3_max:86000
temp4_crit:100000
temp4_crit_alarm:0
temp4_input:29000
temp4_label:Core 2
temp4_max:86000
temp5_crit:100000
temp5_crit_alarm:0
temp5_input:36000
temp5_label:Core 3
temp5_max:86000
uevent:DRIVER=3Dcoretemp
uevent:MODALIAS=3Dplatform:coretemp

Thanks,
Durga

> -----Original Message-----
> From: Yu, Fenghua
> Sent: Monday, April 04, 2011 11:47 PM
> To: R, Durgadoss; guenter.roeck@ericsson.com; khali@linux-fr.org
> Cc: lm-sensors@lm-sensors.org
> Subject: RE: [PATCH:hwmon:v4:]Merging_pkgtemp_with_coretemp
>=20
> > This patch merges the pkgtemp driver with the coretemp driver.
> > This merged driver creates one hwmon device per physical CPU.
> >
> > Changes from v3 of this patch:
> > Added appropriate support for CONFIG_HOTPLUG_CPU.
> >
> > Signed-off-by: Durgadoss R <durgadoss.r@intel.com>
> > ---
> >  drivers/hwmon/coretemp.c |  618 ++++++++++++++++++++++++++++++++++----
> > --------
> >  1 files changed, 455 insertions(+), 163 deletions(-)
>=20
> You patch needs to remove pkgtemp.c file as well.
>=20
> Please publish your test results on Sandybridge and non-Sandybridge.
>=20
> Thanks.
>=20
> -Fenghua

--_003_D6D887BA8C9DFF48B5233887EF046541095167721Cbgsmsx502garc_
Content-Type: application/octet-stream; name="non_snb_coretemp.log"
Content-Description: non_snb_coretemp.log
Content-Disposition: attachment; filename="non_snb_coretemp.log"; size=313;
	creation-date="Tue, 05 Apr 2011 19:53:15 GMT";
	modification-date="Wed, 06 Apr 2011 01:24:34 GMT"
Content-Transfer-Encoding: base64

L3N5cy9jbGFzcy9od21vbi9od21vbjAvZGV2aWNlCi0tLQptb2RhbGlhczpwbGF0Zm9ybTpjb3Jl
dGVtcApuYW1lOmNvcmV0ZW1wCnRlbXAxX2NyaXQ6MTA1MDAwCnRlbXAxX2NyaXRfYWxhcm06MAp0
ZW1wMV9pbnB1dDoyMzAwMAp0ZW1wMV9sYWJlbDpDb3JlIDAKdGVtcDFfbWF4Ojg5MDAwCnRlbXAy
X2NyaXQ6MTA1MDAwCnRlbXAyX2NyaXRfYWxhcm06MAp0ZW1wMl9pbnB1dDoyNTAwMAp0ZW1wMl9s
YWJlbDpDb3JlIDIKdGVtcDJfbWF4Ojg5MDAwCnVldmVudDpEUklWRVI9Y29yZXRlbXAKdWV2ZW50
Ok1PREFMSUFTPXBsYXRmb3JtOmNvcmV0ZW1wCg==

--_003_D6D887BA8C9DFF48B5233887EF046541095167721Cbgsmsx502garc_
Content-Type: application/octet-stream; name="snb_coretemp.log"
Content-Description: snb_coretemp.log
Content-Disposition: attachment; filename="snb_coretemp.log"; size=590;
	creation-date="Tue, 05 Apr 2011 19:53:15 GMT";
	modification-date="Mon, 27 Dec 2010 16:13:48 GMT"
Content-Transfer-Encoding: base64

L3N5cy9jbGFzcy9od21vbi9od21vbjEvZGV2aWNlCi0tLQptb2RhbGlhczpwbGF0Zm9ybTpjb3Jl
dGVtcApuYW1lOmNvcmV0ZW1wCnRlbXAxX2NyaXQ6MTAwMDAwCnRlbXAxX2NyaXRfYWxhcm06MAp0
ZW1wMV9pbnB1dDozNzAwMAp0ZW1wMV9sYWJlbDpQaHlzaWNhbCBpZCAwCnRlbXAxX21heDo4NjAw
MAp0ZW1wMl9jcml0OjEwMDAwMAp0ZW1wMl9jcml0X2FsYXJtOjAKdGVtcDJfaW5wdXQ6MzAwMDAK
dGVtcDJfbGFiZWw6Q29yZSAwCnRlbXAyX21heDo4NjAwMAp0ZW1wM19jcml0OjEwMDAwMAp0ZW1w
M19jcml0X2FsYXJtOjAKdGVtcDNfaW5wdXQ6MzcwMDAKdGVtcDNfbGFiZWw6Q29yZSAxCnRlbXAz
X21heDo4NjAwMAp0ZW1wNF9jcml0OjEwMDAwMAp0ZW1wNF9jcml0X2FsYXJtOjAKdGVtcDRfaW5w
dXQ6MjkwMDAKdGVtcDRfbGFiZWw6Q29yZSAyCnRlbXA0X21heDo4NjAwMAp0ZW1wNV9jcml0OjEw
MDAwMAp0ZW1wNV9jcml0X2FsYXJtOjAKdGVtcDVfaW5wdXQ6MzYwMDAKdGVtcDVfbGFiZWw6Q29y
ZSAzCnRlbXA1X21heDo4NjAwMAp1ZXZlbnQ6RFJJVkVSPWNvcmV0ZW1wCnVldmVudDpNT0RBTElB
Uz1wbGF0Zm9ybTpjb3JldGVtcAo=

--_003_D6D887BA8C9DFF48B5233887EF046541095167721Cbgsmsx502garc_
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--_003_D6D887BA8C9DFF48B5233887EF046541095167721Cbgsmsx502garc_--

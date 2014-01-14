From: Phil Pokorny <ppokorny@penguincomputing.com>
Date: Tue, 14 Jan 2014 18:39:41 +0000
Subject: Re: [lm-sensors] Call for lm-sensors 3.3.5
Message-Id: <CAAek22G6H+xxarDKRcnK8hJtuvoEDn4Kz6Scacdcbh7xV4oYGg@mail.gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="bcaec518664efd156b04eff28303"
List-Id: <lm-sensors.vger.kernel.org>
References: <20140114165101.4958fc13@endymion.delvare>
In-Reply-To: <20140114165101.4958fc13@endymion.delvare>
To: lm-sensors@vger.kernel.org

--bcaec518664efd156b04eff28303
Content-Type: text/plain; charset=ISO-8859-1

On Tue, Jan 14, 2014 at 8:17 AM, Jean Delvare <khali@linux-fr.org> wrote:
>
> Hi Phil,
>
> On Tue, 14 Jan 2014 08:07:51 -0800, Phil Pokorny wrote:
> > AMD announced Kaveri boxed proc availability today.
> > http://finance.yahoo.com/news/amd-revolutionizes-compute-ultrahd-entertainment-130000053.html
> >
> > K10temp needs a new PCI table entry for this proc.  I've tested and it
> > gives readings that change as expected. PCI ID is already in mainline
> > PCI-ids.h
> >
> > Or did I misunderstand and you are talking about userspace?
>
> I was talking about user-space, yes. But sensors-detect would need to
> be taught about the new PCI ID too.
>
> Maybe we already have it:
> http://www.lm-sensors.org/changeset/6191
>
> Or is it yet another PCI ID?


New PCI ID:  141d  aka  PCI_DEVICE_ID_AMD_15H_M30H_NB_F3 for A10-7850K
and others in Kaveri family for k10temp driver.

I suppose I should send a new e-mail with just the patch and description...

-- 
Philip Pokorny, RHCE
Chief Technical Officer
PENGUIN COMPUTING, Inc
www.penguincomputing.com

--bcaec518664efd156b04eff28303
Content-Type: application/octet-stream; name="Kaveri.patch"
Content-Disposition: attachment; filename="Kaveri.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_hqfi73tq0

ZGlmZiAtLWdpdCBhL2RyaXZlcnMvaHdtb24vazEwdGVtcC5jIGIvZHJpdmVycy9od21vbi9rMTB0
ZW1wLmMKaW5kZXggZDY1ZjNmZC4uNzU4Nzc0ZiAxMDA2NDQKLS0tIGEvZHJpdmVycy9od21vbi9r
MTB0ZW1wLmMKKysrIGIvZHJpdmVycy9od21vbi9rMTB0ZW1wLmMKQEAgLTIxMCw2ICsyMTAsNyBA
QCBzdGF0aWMgREVGSU5FX1BDSV9ERVZJQ0VfVEFCTEUoazEwdGVtcF9pZF90YWJsZSkgPSB7CiAJ
eyBQQ0lfVkRFVklDRShBTUQsIFBDSV9ERVZJQ0VfSURfQU1EX0NOQjE3SF9GMykgfSwKIAl7IFBD
SV9WREVWSUNFKEFNRCwgUENJX0RFVklDRV9JRF9BTURfMTVIX05CX0YzKSB9LAogCXsgUENJX1ZE
RVZJQ0UoQU1ELCBQQ0lfREVWSUNFX0lEX0FNRF8xNUhfTTEwSF9GMykgfSwKKwl7IFBDSV9WREVW
SUNFKEFNRCwgUENJX0RFVklDRV9JRF9BTURfMTVIX00zMEhfTkJfRjMpIH0sCiAJeyBQQ0lfVkRF
VklDRShBTUQsIFBDSV9ERVZJQ0VfSURfQU1EXzE2SF9OQl9GMykgfSwKIAl7fQogfTsK
--bcaec518664efd156b04eff28303
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--bcaec518664efd156b04eff28303--

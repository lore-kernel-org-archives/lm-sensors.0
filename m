From: "Juerg Haefliger" <juergh@gmail.com>
Date: Sat, 26 Jan 2008 16:54:24 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon/dme1737: fix Super-IO device ID
Message-Id: <191fb4ca0801260854o4a1cbc33l97d711e9f62c07e8@mail.gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="----=_Part_3860_656289.1201366464861"
List-Id: <lm-sensors.vger.kernel.org>
References: <191fb4ca0801240942h64bd96c1j67554c131c32c01e@mail.gmail.com>
In-Reply-To: <191fb4ca0801240942h64bd96c1j67554c131c32c01e@mail.gmail.com>
To: lm-sensors@vger.kernel.org

------=_Part_3860_656289.1201366464861
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Shoot, sorry about that. Attached  is the correct patch.

------
The dme1737 has a second place where the Super-IO device ID is
checked. This has been missed by Jean's initial patch that adds
support for user-controlled Super-IO device ID override. This patch
fixes this issue.

Signed-off-by: Juerg Haefliger <juergh at gmail.com>




On Jan 26, 2008 8:40 AM, Jean Delvare <khali@linux-fr.org> wrote:
> Hi Juerg,
>
>
> On Thu, 24 Jan 2008 09:42:52 -0800, Juerg Haefliger wrote:
> > The dme1737 has a second place where the Super-IO device ID is
> > checked. This has been missed by Jean's initial patch that adds
> > support for user-controlled Super-IO device ID override. This patch
> > fixes this issue.
> >
> > Signed-off-by: Juerg Haefliger <juergh at gmail.com>
>
> I'm confused. The patch you attached is exactly the same as the one I
> sent originally. Did you send the wrong patch by any chance?
>
> --
> Jean Delvare
>

------=_Part_3860_656289.1201366464861
Content-Type: text/x-patch; name=dme1737-fix-super-io-override.patch
Content-Transfer-Encoding: base64
X-Attachment-Id: f_fbwehps80
Content-Disposition: attachment; filename=dme1737-fix-super-io-override.patch

SW5kZXg6IGxpbnV4L2RyaXZlcnMvaHdtb24vZG1lMTczNy5jCj09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0KLS0tIGxpbnV4
Lm9yaWcvZHJpdmVycy9od21vbi9kbWUxNzM3LmMJMjAwOC0wMS0yNCAwOTozMjo0Ny4wMDAwMDAw
MDAgLTA4MDAKKysrIGxpbnV4L2RyaXZlcnMvaHdtb24vZG1lMTczNy5jCTIwMDgtMDEtMjQgMDk6
Mzg6NTkuMDAwMDAwMDAwIC0wODAwCkBAIC0yMDIzLDcgKzIwMjMsNyBAQAogCiAJLyogQ2hlY2sg
ZGV2aWNlIElECiAJICogVGhlIERNRTE3MzcgY2FuIHJldHVybiBlaXRoZXIgMHg3OCBvciAweDc3
IGFzIGl0cyBkZXZpY2UgSUQuICovCi0JcmVnID0gZG1lMTczN19zaW9faW5iKHNpb19jaXAsIDB4
MjApOworCXJlZyA9IGZvcmNlX2lkID8gZm9yY2VfaWQgOiBkbWUxNzM3X3Npb19pbmIoc2lvX2Np
cCwgMHgyMCk7CiAJaWYgKCEocmVnID09IDB4NzcgfHwgcmVnID09IDB4NzgpKSB7CiAJCWVyciA9
IC1FTk9ERVY7CiAJCWdvdG8gZXhpdDsK
------=_Part_3860_656289.1201366464861
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
------=_Part_3860_656289.1201366464861--

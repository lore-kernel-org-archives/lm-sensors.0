From: "Sebastian Thias, ATEBIS GmbH" <s.thias@atebis.info>
Date: Wed, 19 Sep 2007 07:25:59 +0000
Subject: Re: [lm-sensors] "sensord --rrd-file" cant't find a sensor
Message-Id: <46F0CF07.4080005@atebis.info>
List-Id: <lm-sensors.vger.kernel.org>
References: <46DE9261.8030900@sthias.de>
In-Reply-To: <46DE9261.8030900@sthias.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Jean,

thank you very much for your reply and your patch. I'll test it during
the next days and give you report!

Thanks and greetings!
Sebastian

Jean Delvare schrieb:
> Hi again Sebastian,
>=20
> On Tue, 18 Sep 2007 20:56:17 +0200, Jean Delvare wrote:
>> On Wed, 05 Sep 2007 13:26:25 +0200, Sebastian Thias wrote:
>>> Any idea what could be wrong...?
>> sensord simply lacks support for the w83793 driver, which is rather
>> recent.
>=20
> Here's a patch adding support for the w83793 driver to sensord. It's
> untested as I do not have the hardware. You can give it a try and
> report.
>=20
> Known limitations:
> * Alarms are not supported.
> * You may have to add ignore statements in sensors.conf for missing
>   features.



--=20
ATEBIS GmbH
Welterstra=DFe 57
57072 Siegen

Internet: www.atebis.info
eMail: post@atebis.info

Telefon: 0271-31316950
Telefax: 0271-31316951

Handelsregister: Siegen, HRB 8330
USt-IdNr.: DE 254 237 499
Gesch=E4ftsf=FChrer: Mario Afholderbach, Sebastian Thias
Sitz der Gesellschaft: Siegen

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

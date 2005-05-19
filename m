From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:35 +0000
Subject: Request for driver
Message-Id: <20040118182318.2031158e.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <4006AFFA.80500@mart.ck.ua>
In-Reply-To: <4006AFFA.80500@mart.ck.ua>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

> I've got the Elitgroup 865G-M motherboard.
> sensors-detect shows that it use Winbond W83637HF Super IO Sensors.
> But seems, at now there is no plan to support it yet.

No plan yet, as you guessed. But a data sheet is available from Winbond
[1] and the chip doesn't seem to be too different from the W83627HF, so
it should be possible to either write a new driver using w83627hf as a
template, or even add support for the W83637HF chip to the existing
driver.

Let us know if you start something, so that we can add it on our page
and give you the contact information of a potential tester.

[1] http://www.winbond.com/e-winbondhtm/partner/PDFresult.asp?Pname=886

--=20
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/

From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 19 Jun 2007 08:15:16 +0000
Subject: Re: [lm-sensors] Proposal
Message-Id: <20070619101516.45db4118@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <200704081630.17151.hjk@linutronix.de>
In-Reply-To: <200704081630.17151.hjk@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi Mark,

On Sat, 16 Jun 2007 11:42:13 -0400, Mark M. Hoffman wrote:
> A chip like uguru breaks this model, because we have *no* *idea* what it =
might
> be measuring at the *pin*.  But it turns out, it doesn't matter.

I don't think I agree with this statement. There are not dozens of ways
to measure a voltage. The chip must have an ADC. The table in Hans'
driver (derived from the .ini file provided by Abit) suggests a 10 mV
LSB. Assuming an 8-bit ADC, this means a range from 0 to 2.55V, and the
other scaling factors seem to confirm this (*3 for 5V, *6 for 12V.) If
we know which chip Abit is using (still a W83L950D as for the previous
=B5Gurus?) we might even be able to verify this.

--=20
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

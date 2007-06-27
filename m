From: "Voipio Riku" <Riku.Voipio@movial.fi>
Date: Wed, 27 Jun 2007 19:41:37 +0000
Subject: Re: [lm-sensors] Help needed for implementing&testing Fintek F75375
Message-Id: <60828.80.222.56.248.1182973297.squirrel@webmail.movial.fi>
List-Id: <lm-sensors.vger.kernel.org>
References: <5327.79319.qm@web25109.mail.ukl.yahoo.com>
In-Reply-To: <5327.79319.qm@web25109.mail.ukl.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org


>> This means that the driver isn't reporting the values in RPM as it
>> should. Usually no compute statement is needed for fans.
> That's correct, the value is not in RPM, in the document
> '2005111153128.pdf' you can download on the fintek page
> ( http://www.fintek.com.tw/eng/products.asp?BID=3D4&SID=3D5 )its written =
on
> page 8:
> "Determine the fan counter according to:
> Count =3D (1.5=D710^6) / RPM "
> That means that the driver is reporting the count value, not the rpm.
> So i have to compute in sensors.conf:
> RPM =3D (1.5=D710^6)/ Count

Thus this algorithm actually return sane RPM values for you? Now I
remember why I did not use this - Here the "Count" rises linear, which
makes "RPM =3D(1.5=D710^6)/ Count" *lower* when fan speed increases. OTOH it
might be the fan is just too small and thus rotates too fast to be
reliably measured..

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

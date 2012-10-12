From: Jean Delvare <khali@linux-fr.org>
Date: Fri, 12 Oct 2012 09:01:32 +0000
Subject: Re: [lm-sensors] [PATCH 1/5] hwmon: (coretemp) Drop dependency on PCI for TjMax detection on Atom CP
Message-Id: <20121012110132.13818fc2@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1349816943-17697-2-git-send-email-linux@roeck-us.net>
In-Reply-To: <1349816943-17697-2-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On Fri, 12 Oct 2012 10:40:32 +0200, Jean Delvare wrote:
> I think we simply never bothered special-casing the Atom 230/330.

Oh actually we did, I didn't remember that. So well no, I have no idea
where the 100=B0C for Atom 230 comes from, probably we just got it wrong
when introducing tjmax_table in commit 41e58a1f.

--=20
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:00 +0000
Subject: Maxim MAX6657 Support in lm_sensors
Message-Id: <200406041349.i54DnHAA022295@zone3.gcu-squad.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <40C04A4A.2010208@brend.org>
In-Reply-To: <40C04A4A.2010208@brend.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


>I just wanted to ask you why the MAX6657 Sensor Chip (which is mostly
>identical to the supported lm90) is not supported in lm_sensors?

Simply because no request was made so far. I just didn't feel like
adding support for a chip nobody was interested in. The scientific
reason behind my position is that supporting an additional chip slightly
increases the driver size and, more importantly, slightly increases
misdetection risks, so I avoided doing this by default. But I agree that
there is no common policy about this (even I am not necessarily
consistent on this).

>I have seen the lm89 and adm1032 which are mostly identical to the lm90,
>are supported.
>Are you going to include support for the MAX6657 and if yes, when are
>you going to do this?

Yes, support can be added very easily, as you noticed. You may provide a
patch against lm_sensors CVS (2.4 kernel and user-space) and/or Linux
2.6.7-rc2 if you need support to be added immediately. Else I'll do it,
but delay isn't guaranteed.

Which system or motherboard do you have a MAX6657 on? Do you know of any
system having a MAX6658 on it? Support could possibly be added for both
chips at once if there is a need for this.

>Thanks in advance,

You're welcome.

Jean Delvare
